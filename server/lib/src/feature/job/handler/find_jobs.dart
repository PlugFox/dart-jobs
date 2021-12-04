import 'package:dart_jobs_server/src/common/middleware/database_injector.dart';
import 'package:dart_jobs_server/src/feature/job/model/find_jobs_filter.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:shelf/shelf.dart';

/// Паджинация или отбор последних из коллекции
/// параметры отбора, количества и указателя передаются как query
/// 200 (OK) - возвращает [JobsChunk]
Future<Response> findJobs(Request request) async {
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

  try {
    final jobs = await request.jobDao.findJobs(filter);

    return Response.ok(
      JobsChunk(
        endOfList: before != null && jobs.length < filter.limit,
        jobs: jobs,
      ).toBytes(),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
      },
    );
  } on Object catch (err) {
    return Response.internalServerError(
      body: 'Server can not get jobs: $err',
    );
  }
}
