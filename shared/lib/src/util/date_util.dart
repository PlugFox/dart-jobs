import 'package:meta/meta.dart';

/// Namespace
@sealed
abstract class DateUtil {
  DateUtil._();

  /// Дату в миллисекунды UnixTime
  static int toUnixTime(final DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  /// Миллисекунды UnixTime в дату
  static DateTime fromUnixTime(final int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch).toUtc();

  /// Преобразовать значение JSON в Дату
  static DateTime fromJson(final Object date) {
    if (date is DateTime) {
      return date;
    } else if (date is int) {
      return DateTime.fromMillisecondsSinceEpoch(date).toUtc();
    } else if (date is String) {
      return DateTime.parse(date).toUtc();
    } else {
      throw FormatException('Invalid date type: ${date.runtimeType}');
    }
  }

  /// Преобразовать Дату в значение JSON
  static String toJson(final DateTime date) => date.toIso8601String();
}
