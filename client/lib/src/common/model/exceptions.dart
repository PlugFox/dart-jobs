import 'package:meta/meta.dart';

/// Исключение содержащее исходный StackTrace
@immutable
abstract class Throwable implements Exception {
  /// Исходный стектрейс
  StackTrace get stackTrace;
}

/// Исключение приложения
@immutable
abstract class AppException implements Throwable {
  /// Исходный стектрейс
  @override
  final StackTrace stackTrace;

  /// Сообщение об ошибки или исходная ошибка строкой
  final String? message;

  const AppException(
    this.stackTrace, [
    final this.message,
  ]);

  @override
  String toString() {
    if (message == null) return 'AppException';
    return 'AppException: $message';
  }
}

/// Не найдено
class NotFoundException extends AppException {
  const NotFoundException(
    StackTrace stackTrace, [
    final String? message,
  ]) : super(
          stackTrace,
          message,
        );

  @override
  String toString() {
    if (message == null) return 'NotFoundException';
    return 'NotFoundException: $message';
  }
}

/// Не авторизован
class NotAuthorized extends AppException {
  const NotAuthorized(
    StackTrace stackTrace, [
    final String? message,
  ]) : super(
          stackTrace,
          message,
        );

  @override
  String toString() {
    if (message == null) return 'NotAuthorized';
    return 'NotAuthorized: $message';
  }
}
