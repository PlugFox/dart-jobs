import 'package:meta/meta.dart';

/// Namespace
@sealed
abstract class DateUtil {
  DateUtil._();

  /// Дату в миллисекунды UnixTime
  static int toUnixTime(final DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  /// Миллисекунды UnixTime в дату
  static DateTime fromUnixTime(final int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}
