/// Namespace
abstract class DateUtil {
  DateUtil._();
  static int dateToUnixTime(final DateTime dateTime) => dateTime.millisecondsSinceEpoch;
  static DateTime dateFromUnixTime(final int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}
