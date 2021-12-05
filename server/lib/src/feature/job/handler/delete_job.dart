import 'package:dart_jobs_server/src/common/middleware/database_injector.dart';
import 'package:l/l.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Удалить работу по идентификатору
/// 204 (No Content) - в случае успеха
Future<Response> deleteJob(Request request) async {
  //l.v6('deleteJob');

  /// TODO: разбор токена Firebase Authentication в мидлваре:
  final creatorId = request.context['user_id'];
  if (creatorId is! String) return Response.forbidden(List<int>.empty());

  final id = int.tryParse(request.params['id'] ?? '');
  if (id == null) return Response.notFound(List<int>.empty());

  try {
    await request.jobDao.setDeletionMark(id: id, creatorId: creatorId);

    return Response(204);
  } on Object catch (err, stackTrace) {
    l.w(err, stackTrace);
    return Response.internalServerError(
      body: 'Server can not delete job',
    );
  }
}
