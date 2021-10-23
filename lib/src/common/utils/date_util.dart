import 'package:meta/meta.dart';

/// Namespace
@sealed
abstract class DateUtil {
  DateUtil._();
  static int toUnixTime(final DateTime dateTime) => dateTime.millisecondsSinceEpoch;
  static DateTime fromUnixTime(final int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}
