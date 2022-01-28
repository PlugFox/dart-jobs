import 'package:meta/meta.dart';

/// Репорт от пользователя
@immutable
class BugReportEntity {
  const BugReportEntity({
    required final this.type,
    required final this.message,
    this.userId,
    this.email,
  });

  /// Представление типа баг репорта
  String get typeRepresentation {
    switch (type) {
      case BugReportType.feature:
        return 'FEATURE';
      case BugReportType.improvement:
        return 'IMPROVEMENT';
      case BugReportType.bug:
        return 'BUG';
    }
  }

  /// Представление пользователя
  /// Может быть null
  String? get userRepresentation {
    if (userId == null) return null;
    return '$userId${email == null ? '' : ' <$email>'}';
  }

  /// Обладает идентификатором пользователя
  bool get hasUserId => userId != null;

  /// Тип репорта
  final BugReportType type;

  /// Сообщение
  final String message;

  /// Идентификатор пользователя.
  /// Может быть null
  final String? userId;

  /// е-мейл пользователя
  /// Может быть null
  final String? email;
}

/// Тип репорта
enum BugReportType {
  /// Новая фишка
  feature,

  /// Улучшение
  improvement,

  /// Баг
  bug,
}
