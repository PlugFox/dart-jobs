import 'package:dart_jobs_shared/model.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Получение элемента по идентификатору
/// 200 (OK) - получаем данные работы по идентификатору
Response getJob(Request request) {
  final uuid = request.params['id'];
  if (uuid == null) return Response.notFound(List<int>.empty());

  return Response.ok(
    Job(
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
    },
  );
}
