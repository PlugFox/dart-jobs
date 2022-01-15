import 'dart:async';
import 'dart:convert';

import 'package:dart_jobs_shared/src/graphql/exceptions.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

typedef HttpResponseDecoder = FutureOr<Map<String, dynamic>?> Function(http.Response httpResponse);

/// Handler link implementation
///
/// To customize the request headers you can pass a custom
/// [http.Client] to the constructor.
class HandlerLink extends Link with _MultipartProcessor {
  /// Endpoint of the GraphQL service
  final Uri uri;

  final http.Client? _httpClient;

  /// Serializer used to serialize request
  final RequestSerializer _serializer;

  /// Parser used to parse response
  final ResponseParser _parser;

  /// A function that decodes the incoming http response to `Map<String, dynamic>`,
  /// the decoded map will be then passes to the `RequestSerializer`.
  /// It is recommended for performance to decode the response using `compute` function.
  /// ```
  /// httpResponseDecoder : (http.Response httpResponse) async => await compute(jsonDecode, httpResponse.body) as Map<String, dynamic>,
  /// ```
  final HttpResponseDecoder _httpResponseDecoder;

  /// Default HTTP headers
  final Map<String, String> _defaultHeaders;

  HandlerLink(
    String uri, {
    http.Client? httpClient,
    Map<String, String>? defaultHeaders,
  })  : uri = Uri.parse(uri),
        _httpClient = httpClient ?? http.Client(),
        _serializer = const RequestSerializer(),
        _defaultHeaders = defaultHeaders ?? const <String, String>{},
        _httpResponseDecoder = _defaultHttpResponseDecoder,
        _parser = const ResponseParser();

  static Map<String, Object?>? _defaultHttpResponseDecoder(http.Response httpResponse) => json.decode(
        utf8.decode(
          httpResponse.bodyBytes,
        ),
      ) as Map<String, Object?>?;

  @override
  Stream<Response> request(
    Request request, [
    NextLink? forward,
  ]) async* {
    final httpRequest = _prepareRequest(request);

    final httpResponse = await _executeRequest(httpRequest);

    final response = await _parseHttpResponse(httpResponse);

    if (httpResponse.statusCode >= 300 || (response.data == null && response.errors == null)) {
      throw HttpLinkServerException(
        response: httpResponse,
        parsedResponse: response,
      );
    }

    yield Response(
      response: response.response,
      data: response.data,
      errors: response.errors,
      context: _updateResponseContext(request, httpRequest, response, httpResponse),
    );
  }

  /// Выполнить HTTP запрос
  Future<http.Response> _executeRequest(http.BaseRequest httpRequest) async {
    try {
      //httpRequest.url;
      //httpRequest.method;
      //httpRequest.headers.entries.map<String>((kv) => '${kv.key}:${kv.value}').join('\n');
      final response = await _httpClient!.send(httpRequest);
      return http.Response.fromStream(response);
    } on Object catch (e) {
      throw ServerException(
        originalException: e,
        parsedResponse: null,
      );
    }
  }

  http.BaseRequest _prepareRequest(Request request) {
    final body = _encodeAttempter<Map<String, Object?>, Request>(
      request,
      _serializer.serializeRequest,
    )(request);

    final contextHeaders = _getHttpLinkHeaders(request);
    final headers = <String, String>{
      'Content-type': 'application/json',
      'Accept': '*/*',
      ..._defaultHeaders,
      ...contextHeaders,
    };

    //final headersRepresentation = headers.entries.map((e) => '${e.key} : ${e.value}').join('\r\n');

    final fileMap = _extractFlattenedFileMap(body);

    final httpBody = _encodeAttempter<String, Map<String, Object?>>(
      request,
      (Map<String, Object?> body) => jsonEncode(
        body,
        toEncodable: (Object? object) {
          if (object is http.MultipartFile) return null;
          // ignore: avoid_dynamic_calls
          return (object as dynamic).toJson();
        },
      ),
    )(body);

    /*
    assert(() {
      l.i('GraphQL httpBody:\n$httpBody');
      return true;
    }(), 'Вывожу содержимое запроса');
    httpBody;
    */

    if (fileMap.isNotEmpty) {
      final multipartRequest = http.MultipartRequest('POST', uri)
        ..fields['operations'] = httpBody
        ..headers.addAll(headers);
      _addAllFiles(multipartRequest, fileMap);
      return multipartRequest;
    }

    return http.Request('POST', uri)
      ..body = httpBody
      ..headers.addAll(headers);
  }

  /// Wrap an encoding transform in exception handling
  T Function(V) _encodeAttempter<T, V>(
    Request request,
    T Function(V) encoder,
  ) =>
      (V input) {
        try {
          return encoder(input);
        } on Object catch (e) {
          throw RequestFormatException(
            originalException: e,
            request: request,
          );
        }
      };

  Map<String, String> _getHttpLinkHeaders(Request request) {
    try {
      final linkHeaders = request.context.entry<HttpLinkHeaders>();
      if (linkHeaders == null) return <String, String>{};
      return Map<String, String>.of(linkHeaders.headers);
    } on Object catch (e) {
      throw ContextReadException(
        originalException: e,
      );
    }
  }

  Future<Response> _parseHttpResponse(http.Response httpResponse) async {
    try {
      final responseBody = await _httpResponseDecoder(httpResponse);
      return _parser.parseResponse(responseBody!);
    } on Object catch (e, stackTrace) {
      final contentType = httpResponse.headers['Content-Type'] ?? httpResponse.headers['content-type'];
      if (contentType != null && contentType.toLowerCase().contains('text')) {
        throw HttpLinkParserException(
          originalException: WrongContentTypeException(
            message: 'Вместо JSON получен Content-Type:$contentType',
            stackTrace: stackTrace,
            body: httpResponse.body,
            contentType: contentType,
          ),
          response: httpResponse,
        );
      }
      throw HttpLinkParserException(
        originalException: e,
        response: httpResponse,
      );
    }
  }

  Context _updateResponseContext(
    Request request,
    http.BaseRequest httpRequest,
    Response response,
    http.Response httpResponse,
  ) {
    try {
      final context = response.context
          .withEntry(
            HttpLinkResponseContext(
              statusCode: httpResponse.statusCode,
              headers: httpResponse.headers,
            ),
          )
          .withEntry<HttpResponseContext>(
            HttpResponseContext(
              httpResponse,
            ),
          );
      if (httpRequest is http.Request) {
        return context.withEntry<HttpRequestContext>(
          HttpRequestContext(
            httpRequest,
          ),
        );
      }
      return context;
    } on Object catch (e) {
      throw ContextWriteException(
        originalException: e,
      );
    }
  }
}

mixin _MultipartProcessor {
  /// Recursively extract [MultipartFile]s and return them as a normalized map of [path] => [file]
  /// From the given request body
  ///
  /// ```dart
  /// {
  ///   "foo": [ { "bar": MultipartFile("blah.txt") } ]
  ///  }
  /// // =>
  /// {
  ///   "foo.0.bar": MultipartFile("blah.txt")
  /// }
  /// ```
  Map<String, http.MultipartFile> _extractFlattenedFileMap(
    dynamic body, {
    Map<String, http.MultipartFile>? currentMap,
    List<String> currentPath = const <String>[],
  }) {
    currentMap ??= <String, http.MultipartFile>{};
    if (body is Map<String, dynamic>) {
      final Iterable<MapEntry<String, Object?>> entries = body.entries;
      for (final element in entries) {
        currentMap.addAll(
          _extractFlattenedFileMap(
            element.value,
            currentMap: currentMap,
            currentPath: List<String>.from(currentPath)..add(element.key),
          ),
        );
      }
      return currentMap;
    }
    if (body is List<dynamic>) {
      for (var i = 0; i < body.length; i++) {
        currentMap.addAll(
          _extractFlattenedFileMap(
            body[i],
            currentMap: currentMap,
            currentPath: List<String>.from(currentPath)..add(i.toString()),
          ),
        );
      }
      return currentMap;
    }

    if (body is http.MultipartFile) {
      return currentMap
        ..addAll({
          currentPath.join('.'): body,
        });
    }

    return currentMap;
  }

  /// Добавить файлы в MultipartRequest
  void _addAllFiles(http.MultipartRequest request, Map<String, http.MultipartFile> fileMap) {
    final fileMapping = <String, List<String>>{};
    final fileList = <http.MultipartFile>[];

    final fileMapEntries = fileMap.entries.toList(growable: false);

    for (var i = 0; i < fileMapEntries.length; i++) {
      final entry = fileMapEntries[i];
      final indexString = i.toString();
      fileMapping.addAll(<String, List<String>>{
        indexString: <String>[entry.key],
      });
      final f = entry.value;
      fileList.add(
        http.MultipartFile(
          indexString,
          f.finalize(),
          f.length,
          contentType: f.contentType,
          filename: f.filename,
        ),
      );
    }
    request.fields['map'] = json.encode(fileMapping);
    request.files.addAll(fileList);
  }
}

class HttpRequestContext extends ContextEntry {
  const HttpRequestContext(this.request);

  final http.Request request;

  @override
  List<Object?> get fieldsForEquality => [
        request.contentLength,
        request.body,
        request.headers,
        request.bodyBytes,
      ];
}

class HttpResponseContext extends ContextEntry {
  const HttpResponseContext(this.response);

  final http.Response response;

  @override
  List<Object?> get fieldsForEquality => [
        response.contentLength,
        response.statusCode,
        response.body,
        response.headers,
        response.isRedirect,
        response.bodyBytes,
      ];
}

class WrongContentTypeException implements UnsupportedError {
  WrongContentTypeException({
    required this.message,
    required this.stackTrace,
    required this.contentType,
    required this.body,
  });

  @override
  final String message;

  @override
  final StackTrace stackTrace;

  final String contentType;

  final String body;
}

/// HTTP link headers
@immutable
class HttpLinkHeaders extends ContextEntry {
  const HttpLinkHeaders({
    this.headers = const {},
  });

  /// Headers to be added to the request.
  ///
  /// May overrides Apollo Client awareness headers.
  final Map<String, String> headers;

  @override
  List<Object> get fieldsForEquality => [
        headers,
      ];
}

/// HTTP link Response Context
@immutable
class HttpLinkResponseContext extends ContextEntry {
  const HttpLinkResponseContext({
    required this.statusCode,
    required this.headers,
  });

  /// HTTP status code of the response
  final int statusCode;

  /// HTTP response headers
  final Map<String, String> headers;

  @override
  List<Object> get fieldsForEquality => [
        statusCode,
        headers,
      ];
}
