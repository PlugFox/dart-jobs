import 'package:dart_jobs_shared/model.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Обновление данных по идентификатору
/// в теле содержатся новые данные [JobData]
/// 200 - в случае успеха и [Job] в теле
Response updateJob(Request request) {
  /// TODO: разбор токена Firebase Authentication в мидлваре:
  final userId = request.context['user_id'];
  if (userId == null) return Response.forbidden(List<int>.empty());

  final id = int.tryParse(request.params['id'] ?? '');
  if (id == null) return Response.notFound(List<int>.empty());

  return Response(
    200,
    body: Job(
      id: id,
      //weight: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      updated: DateTime.now().toUtc(),
      created: DateTime.now().toUtc(),
      creatorId: 'creatorId',
      data: JobData(
        title: 'title ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
        company: 'company ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
        country: 'company ${DateTime.now().millisecondsSinceEpoch.toRadixString(36)}',
        remote: false,
      ),
    ).toBytes(),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream',
      'Content-Location': '/jobs/id$id',
    },
  );
}
