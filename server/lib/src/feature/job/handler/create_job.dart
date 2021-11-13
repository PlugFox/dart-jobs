import 'dart:typed_data';

import 'package:dart_jobs_shared/model.dart';
import 'package:shelf/shelf.dart';

/// Создание нового элемента в коллекции
/// 201 (Created), заголовок 'Location' ссылается на /jobs/id{id}, где ID - идентификатор нового экземпляра.
Future<Response> createJob(Request request) async {
  /// TODO: разбор токена Firebase Authentication в мидлваре:
  final userId = request.context['user_id'];
  if (userId == null) return Response.forbidden(List<int>.empty());

  JobData jobData;
  try {
    final bytesBuilder = BytesBuilder(copy: false);
    await request.read().forEach(bytesBuilder.add);
    jobData = JobData.fromBytes(bytesBuilder.takeBytes());
  } on Object catch (err) {
    return Response.internalServerError(
      body: 'Server can not read job data, maybe request contain corrupted body: $err',
    );
  }

  final id = DateTime.now().millisecondsSinceEpoch;
  return Response(
    201,
    body: Job(
      id: id,
      //weight: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      updated: DateTime.now().toUtc(),
      created: DateTime.now().toUtc(),
      creatorId: 'creatorId',
      data: jobData,
    ).toBytes(),
    headers: <String, String>{
      'Content-Type': 'application/octet-stream',
      'Content-Location': '/jobs/id$id',
    },
  );
}
