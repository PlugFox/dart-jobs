import 'package:dart_jobs_server/src/feature/job/model/find_jobs_filter.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:shelf/shelf.dart';

/// Паджинация или отбор последних из коллекции
/// параметры отбора, количества и указателя передаются как query
/// 200 (OK) - возвращает [JobsChunk]
Response findJobs(Request request) {
  final filter = FindJobsFilter.fromQuery(request.url.queryParameters);

  final after = filter.after;
  final before = filter.before;
  if (after == before) return Response(204);
  if (after is DateTime && before is DateTime && after.isBefore(before)) {
    return Response(204);
  }
  if (after is DateTime && after.isAfter(DateTime.now().add(const Duration(days: 7)))) {
    return Response(204);
  }

  final date = before ?? DateTime.now();
  return Response.ok(
    JobsChunk(
      endOfList: false,
      jobs: Iterable<Job>.generate(
        filter.limit,
        (i) => Job(
          id: (date.millisecondsSinceEpoch ~/ 1000 - i * 60 * 60).toRadixString(36),
          //weight: request.before.toDateTime().millisecondsSinceEpoch ~/ 1000,
          updated: date.subtract(Duration(hours: i)),
          created: date.subtract(Duration(hours: i)),
          creatorId: 'creatorId',
          data: JobData(
            title: 'title ${date.subtract(Duration(hours: i)).millisecondsSinceEpoch.toRadixString(36)}',
            company: 'company ${date.subtract(Duration(hours: i)).millisecondsSinceEpoch.toRadixString(36)}',
            country: 'company ${date.subtract(Duration(hours: i)).millisecondsSinceEpoch.toRadixString(36)}',
            remote: false,
          ),
        ),
      ).toList(growable: false),
    ).toBytes(),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream',
    },
  );
}
