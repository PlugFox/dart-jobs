import 'dart:convert';

import 'package:dart_jobs_client/src/common/utils/platform/error_util_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/src/common/utils/platform/error_util_web.dart' as exceptions;
import 'package:dart_jobs_shared/graphql.dart';
import 'package:l/l.dart';

abstract class ErrorUtil {
  ErrorUtil._();

  static void logError(Object exception, {StackTrace? stackTrace, String? hint}) {
    try {
      if (exception is String) {
        return logMessage(exception, stackTrace: stackTrace, hint: hint, warning: true);
        //} else if (exception is MinorException) {
        //  assert(false, 'Минорные ошибки не нуждаются в отправке на сервер');
        //  return;
      }
      exceptions.logError(exception, stackTrace: stackTrace ?? StackTrace.current, hint: hint);
    } on Object catch (error, stackTrace) {
      l.e('Произошло исключение "$error" в ErrorUtil.logError', stackTrace);
    }
  }

  static void logMessage(
    String message, {
    StackTrace? stackTrace,
    String? hint,
    bool warning = false,
    List<String>? params,
  }) {
    try {
      exceptions.logMessage(message, stackTrace: stackTrace, hint: hint, warning: warning, params: params);
    } on Object catch (error, stackTrace) {
      l.e('Произошло исключение "$error" в ErrorUtil.logMessage', stackTrace);
    }
  }

  // ignore: long-method
  static void logGraphQLError(
    final Request request,
    final Response response,
  ) {
    const jsonEncoder = JsonEncoder.withIndent('  ');
    final buffer = StringBuffer('Ошибка ')
      ..writeln('${request.isMutation ? 'мутации' : 'запроса'} GraphQL: "${request.operation.operationName}"')
      ..writeln()
      ..writeln()
      ..writeln('# Запрос:');
    try {
      final httpLinkHeaders = request.context.entry<HttpLinkHeaders>();
      if (httpLinkHeaders != null && httpLinkHeaders.headers.isNotEmpty) {
        buffer.writeln('### Заголовки:');
        httpLinkHeaders.headers.entries.map((header) => '+ ${header.key} : ${header.value}').forEach(buffer.writeln);
        buffer.writeln();
      }
    } on Object catch (error, stackTrace) {
      l.w('Ошибка формирования тела исключения GraphQL ошибки: $error', stackTrace);
    }
    try {
      final httpRequest = response.context.entry<HttpRequestContext>();
      if (httpRequest != null) {
        buffer
          ..writeln('## Метод:')
          ..writeln(httpRequest.request.method)
          ..writeln()
          ..writeln('## Тело:')
          ..writeln(httpRequest.request.body)
          ..writeln();
      }
    } on Object catch (error, stackTrace) {
      l.w('Ошибка формирования тела исключения GraphQL ошибки: $error', stackTrace);
    }

    try {
      buffer
        ..writeln('## Операция:')
        ..writeln(request.operation.toString())
        ..writeln()
        ..writeln('## Переменные:')
        ..writeln(jsonEncoder.convert(request.variables))
        ..writeln()
        ..writeln();
    } on Object catch (error, stackTrace) {
      l.w('Ошибка формирования тела исключения GraphQL ошибки: $error', stackTrace);
    }
    try {
      final errors = response.errors;
      if (errors != null) {
        buffer.writeln('# Ошибки:');
        var i = 0;
        for (final error in errors) {
          i++;
          buffer
            ..writeln('## Ошибка №$i')
            ..writeln()
            ..writeln('### Сообщение:')
            ..writeln(error.message)
            ..writeln();
          final locations = error.locations;
          if (locations != null && locations.isNotEmpty) {
            buffer.writeln('### Расположение: ');
            for (final location in locations) {
              buffer.writeln('+ line: ${location.line}, column: ${location.column}');
            }
            buffer.writeln();
          }
          final path = error.path;
          if (path != null && path.isNotEmpty) {
            buffer.writeln('### Путь: ');
            for (final p in path) {
              buffer.writeln('+ $p');
            }
            buffer.writeln();
          }
          final extensions = error.extensions;
          if (extensions != null && extensions.isNotEmpty) {
            buffer
              ..writeln('### Расширения: ')
              ..writeln(extensions)
              ..writeln();
          }
        }
      }
    } on Object catch (error, stackTrace) {
      l.w('Ошибка формирования тела исключения GraphQL ошибки: $error', stackTrace);
    }
    buffer.writeln();
    final message = buffer.toString();
    l.w(message);
    logMessage(
      message,
      hint: 'graphql_error',
    );
  }

  // ignore: long-method
  static void logLinkException(
    final Request request,
    final Response? response,
    final Object exception,
    final StackTrace stackTrace,
  ) {
    var originalStackTrace = stackTrace;
    final buffer = StringBuffer('Исключение линка GraphQL при ')
      ..writeln('${request.isMutation ? 'мутации' : 'запросе'}: "${request.operation.operationName}"');
    try {
      final vars = request.variables.entries;
      if (vars.isNotEmpty) {
        buffer.writeln('Параметры:');
        vars.map<String>((e) => ' * ${e.key}:${e.value}').forEach(buffer.writeln);
      }
      if (exception is HttpLinkServerException) {
        buffer.writeln('Сетевое исключение: "${exception.toString()}"');
        final rsp = exception.response;
        buffer
          ..writeln('http.code: ${rsp.statusCode}')
          ..writeln('http.headers:');
        rsp.headers.entries.map<String>((e) => ' * ${e.key}:${e.value}').forEach(buffer.writeln);
        final errors = exception.parsedResponse?.errors;
        if (errors != null) {
          buffer.writeln('С ошибками:');
          errors.map<String>((e) {
            final ext = e.extensions?.entries;
            return ext != null && ext.isNotEmpty
                ? ' * ${e.message}; ${ext.map((e) => '${e.key}:${e.value}').join(',')}'
                : ' * ${e.message}';
          }).forEach(buffer.writeln);
        }
      } else if (exception is HttpLinkParserException) {
        buffer.writeln('Исключение разбора ответа: "${exception.toString()}"');
        final rsp = exception.response;
        buffer
          ..writeln('http.code: ${rsp.statusCode}')
          ..writeln('http.headers:');
        rsp.headers.entries.map<String>((e) => ' * ${e.key}:${e.value}').forEach(buffer.writeln);
      }
      final originalException = exception is LinkException ? exception.originalException as Object? : exception;
      if (originalException is WrongContentTypeException) {
        originalStackTrace = originalException.stackTrace;
        buffer
          ..writeln('http.body:')
          ..writeln(originalException.body)
          ..writeln('Исключение: получен не верный Content-Type от сервера "${originalException.contentType}"');
      } else {
        buffer.writeln('Исключение: "$exception"');
      }
    } on Object catch (error, stackTrace) {
      l.w('Ошибка формирования тела исключения линка GraphQL: $error', stackTrace);
    }
    final message = buffer.toString();
    l.w(message, originalStackTrace);
    logMessage(
      message,
      stackTrace: originalStackTrace,
      hint: 'graphql_link_exception',
    );
  }
}
