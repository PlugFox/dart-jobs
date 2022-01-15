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

  static void logMessage(String message, {StackTrace? stackTrace, String? hint, bool warning = false}) {
    try {
      exceptions.logMessage(message, stackTrace: stackTrace, hint: hint, warning: warning);
    } on Object catch (error, stackTrace) {
      l.e('Произошло исключение "$error" в ErrorUtil.logMessage', stackTrace);
    }
  }

  static void logGraphQLError(
    final Request request,
    final Response response,
  ) {
    final buffer = StringBuffer('Произошла ошибка GraphQL')
      ..writeln('${request.isMutation ? 'Мутация' : 'Запрос'}: "${request.operation.operationName}"');
    final vars = request.variables.entries;
    if (vars.isNotEmpty) {
      buffer.writeln('Параметры:');
      vars.map<String>((e) => ' * ${e.key}:${e.value}').forEach(buffer.writeln);
    }
    final errors = response.errors;
    if (errors != null) {
      buffer.writeln('С ошибками:');

      errors.map<String>((e) {
        final ext = e.extensions?.entries;
        return ext != null && ext.isNotEmpty
            ? ' * ${e.message}; ${ext.map((e) => '${e.key}:${e.value}').join(',')}'
            : ' * ${e.message}';
      }).forEach(buffer.writeln);
    }
    final message = buffer.toString();
    l.w(message);
    logMessage(
      message,
      hint: 'graphql_error',
    );
  }

  static void logLinkException(
    final Request request,
    final Response? response,
    final Object exception,
    final StackTrace stackTrace,
  ) {
    var originalStackTrace = stackTrace;
    final buffer = StringBuffer('Произошло исключение линка GraphQL\n')
      ..writeln('${request.isMutation ? 'Мутация' : 'Запрос'}: "${request.operation.operationName}"');
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
    final message = buffer.toString();
    l.w(message, originalStackTrace);
    logMessage(
      message,
      stackTrace: originalStackTrace,
      hint: 'graphql_link_exception',
    );
  }
}
