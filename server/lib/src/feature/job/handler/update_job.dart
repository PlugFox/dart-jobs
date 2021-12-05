import 'dart:typed_data';

import 'package:dart_jobs_server/src/common/middleware/database_injector.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:l/l.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Обновление данных по идентификатору
/// в теле содержатся новые данные [JobData]
/// 200 - в случае успеха и [Job] в теле
Future<Response> updateJob(Request request) async {
  //l.v6('updateJob');

  /// TODO: разбор токена Firebase Authentication в мидлваре:
  final creatorId = request.context['user_id'];
  if (creatorId is! String) return Response.forbidden(List<int>.empty());

  final id = int.tryParse(request.params['id'] ?? '');
  if (id is! int) return Response.notFound(List<int>.empty());

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
    final job = await request.jobDao.updateJob(id: id, creatorId: creatorId, data: jobData);

    return Response(
      200,
      body: job.toBytes(),
      headers: <String, String>{
        'Content-Type': 'application/octet-stream',
        'Content-Location': '/jobs/id$id',
      },
    );
  } on Object catch (err, stackTrace) {
    l.w(err, stackTrace);
    return Response.internalServerError(
      body: 'Server can not update job',
    );
  }
}
