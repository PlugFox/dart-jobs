/* Timestamp <-> DateTime */

DateTime fromGraphQLTimestampToDartDateTime(final String timestamp) =>
    DateTime.parse(_normalizeTimestamp(timestamp)).toUtc();

String fromDartDateTimeToGraphQLTimestamp(final DateTime timestamp) => timestamp.toUtc().toIso8601String();

DateTime? fromGraphQLTimestampNullableToDartDateTimeNullable(final String? timestamp) =>
    timestamp == null ? null : DateTime.tryParse(_normalizeTimestamp(timestamp))?.toUtc();

String? fromDartDateTimeNullableToGraphQLTimestampNullable(final DateTime? timestamp) =>
    timestamp?.toUtc().toIso8601String();

String _normalizeTimestamp(String timestamp) {
  final time = timestamp.split('T').last;
  if (time.endsWith('Z') || time.contains('+') || time.contains('-')) return timestamp;
  return '${timestamp}Z';
}
