import 'package:dart_jobs_client/src/common/model/exceptions.dart';
import 'package:dart_jobs_client/src/common/utils/platform/error_util_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/src/common/utils/platform/error_util_web.dart' as exceptions;

abstract class ErrorUtil {
  ErrorUtil._();

  static void logError(Object exception, {StackTrace? stackTrace, String? hint}) {
    if (exception is String) {
      return logMessage(exception, stackTrace: stackTrace, hint: hint);
    } else if (exception is MinorException) {
      assert(false, 'Минорные ошибки не нуждаются в логировании');
      return;
    }
    exceptions.logError(exception, stackTrace: stackTrace, hint: hint);
  }

  static void logMessage(String message, {StackTrace? stackTrace, String? hint}) {
    exceptions.logMessage(message, stackTrace: stackTrace, hint: hint);
  }
}
