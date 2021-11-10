import 'package:dart_jobs_shared/model.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Создание нового элемента в коллекции
/// 201 (Created), заголовок 'Location' ссылается на /jobs/id{id}, где ID - идентификатор нового экземпляра.
Response createJob(Request request) {
  /// TODO: разбор токена Firebase Authentication в мидлваре:
  final userId = request.context['user_id'];
  if (userId == null) return Response.forbidden(List<int>.empty());

  final id = request.params['id'];
  if (id == null) return Response.notFound(List<int>.empty());

  const uuid = 'some-id';
  return Response(
    201,
    body: Job(
      id: uuid,
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
      'Content-Location': '/jobs/id$uuid',
    },
  );
}
