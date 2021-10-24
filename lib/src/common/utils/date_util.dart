import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:meta/meta.dart';

export 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

/// Namespace
@sealed
abstract class DateUtil {
  DateUtil._();

  /// Дату в миллисекунды UnixTime
  static int toUnixTime(final DateTime dateTime) => dateTime.millisecondsSinceEpoch;

  /// Миллисекунды UnixTime в дату
  static DateTime fromUnixTime(final int millisecondsSinceEpoch) =>
      DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch);

  /// Привести к формату Firestore
  static Timestamp toTimestamp(final DateTime date) => Timestamp.fromDate(date);

  /// Привести к дате из формата Firestore
  static DateTime fromTimestamp(final Timestamp timestamp) => timestamp.toDate();
}
