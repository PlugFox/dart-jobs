/* Timestamp <-> DateTime */

DateTime fromGraphQLTimestampToDartDateTime(String timestamp) => DateTime.parse(timestamp).toUtc();

String fromDartDateTimeToGraphQLTimestamp(DateTime timestamp) => timestamp.toUtc().toIso8601String();

DateTime? fromGraphQLTimestampNullableToDartDateTimeNullable(String? timestamp) =>
    timestamp == null ? null : DateTime.tryParse(timestamp)?.toUtc();

String? fromDartDateTimeNullableToGraphQLTimestampNullable(DateTime? timestamp) => timestamp?.toUtc().toIso8601String();
