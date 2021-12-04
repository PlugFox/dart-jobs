import 'package:dart_jobs_server/src/common/middleware/database_injector.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Получение элемента по идентификатору
/// 200 (OK) - получаем данные работы по идентификатору
Future<Response> getJob(Request request) async {
  final id = int.tryParse(request.params['id'] ?? '');
  if (id is! int) return Response.notFound(List<int>.empty());

  try {
    final job = await request.jobDao.getJob(id);

    return Response.ok(
      job.toBytes(),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
      },
    );
  } on Object catch (err) {
    return Response.internalServerError(
      body: 'Server can not get job: $err',
    );
  }
}
