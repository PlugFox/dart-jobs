import 'package:meta/meta.dart';

/// Исключение содержащее исходный StackTrace
@immutable
abstract class Throwable implements Exception {
  /// Исходный стектрейс
  StackTrace get stackTrace;
}

/// Не важные, предсказуемые исключения
/// Например "такого элемента не существует" или "отсутсвует интернет"
abstract class MinorException implements Throwable {}

/// Исключение приложения
@immutable
abstract class AppException implements Throwable {
  const AppException(
    this.stackTrace, [
    final this.message,
  ]);

  /// Исходный стектрейс
  @override
  final StackTrace stackTrace;

  /// Сообщение об ошибки или исходная ошибка строкой
  final String? message;

  @override
  String toString() {
    if (message == null) return 'AppException';
    return 'AppException: $message';
  }
}

/// Не найдено
class NotFoundException extends AppException implements MinorException {
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
class NotAuthorized extends AppException implements MinorException {
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
