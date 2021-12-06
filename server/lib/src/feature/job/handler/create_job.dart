import 'dart:typed_data';

import 'package:dart_jobs_server/src/common/middleware/authentication.dart';
import 'package:dart_jobs_server/src/common/middleware/database_injector.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:l/l.dart';
import 'package:shelf/shelf.dart';

/// Создание нового элемента в коллекции
/// 201 (Created), заголовок 'Location' ссылается на /jobs/id{id}, где ID - идентификатор нового экземпляра.
Future<Response> createJob(Request request) async {
  final creatorId = request.uid;
  if (creatorId is! String) return Response.forbidden(List<int>.empty());

  JobData jobData;
  try {
    final bytesBuilder = BytesBuilder(copy: false);
    await request.read().forEach(bytesBuilder.add);
    jobData = JobData.fromBytes(bytesBuilder.takeBytes());
  } on Object catch (err, stackTrace) {
    l.w(err, stackTrace);
    return Response.internalServerError(
      body: 'Server can not read job data, maybe request contain corrupted body',
    );
  }

  try {
    final job = await request.jobDao.createJob(
      creatorId: creatorId,
      data: jobData,
    );

    return Response(
      201,
      body: job.toBytes(),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
        'Content-Location': '/jobs/id${job.id}',
      },
    );
  } on Object catch (err, stackTrace) {
    l.w(err, stackTrace);
    return Response.internalServerError(
      body: 'Server can not create new job',
    );
  }
}
