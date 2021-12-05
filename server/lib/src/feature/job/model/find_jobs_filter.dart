import 'dart:math' as math;

class FindJobsFilter {
  factory FindJobsFilter.fromQuery(Map<String, String> queryParameters) => FindJobsFilter(
        limit: math.min(_parseOrNull(queryParameters['limit'], int.tryParse) ?? 100, 100),
        before: _parseOrNull(queryParameters['before'], DateTime.tryParse)?.toUtc(),
        after: _parseOrNull(queryParameters['after'], DateTime.tryParse)?.toUtc(),
      );

  FindJobsFilter({
    required final this.limit,
    required final DateTime? before,
    required final DateTime? after,
  })  : before = before?.toUtc(),
        after = after?.toUtc();

  static T? _parseOrNull<T>(final String? value, T? Function(String) parse) => value != null ? parse(value) : null;

  final int limit;

  final DateTime? before;

  final DateTime? after;

  @override
  String toString() => 'FindJobsFilter( ' 'limit: $limit ' 'before: $before ' 'after: $after ' ')';
}
