/// Namespace
abstract class DateUtil {
  DateUtil._();
  static int dateToUnixTime(DateTime dateTime) => dateTime.millisecondsSinceEpoch;
  static DateTime dateFromUnixTime(int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);
}
