import 'dart:async';

import 'package:dart_jobs_shared/grpc.dart' as grpc;
import 'package:dart_jobs_shared/models.dart';
import 'package:grpc/grpc.dart' as grpc;

abstract class IJobNetworkDataProvider {
  /// Запросить новейшие
  /// Получение последних записей по указаной фильтрации
  Future<JobsChunk> getRecent({
    required final DateTime updatedAfter,
    required final JobFilter filter,
  });

  /// Запросить порцию старых
  /// Получение последних записей по указаной фильтрации
  Future<JobsChunk> paginate({
    required final DateTime updatedBefore,
    required final JobFilter filter,
  });

  /// Запросить порцию старых
  Future<Job> createJob({
    required final JobData jobData,
    required final String idToken,
  });

  /// Получить работу по идентификатору
  /// Если работа не найдена - возвращает с пометкой [deletionMark]
  Future<Job> getJob({required final String id});

  /// Обновить данные по работе
  /// В ответ получаем обновленную работу
  Future<Job> updateJob({
    required final Job job,
    required final String idToken,
  });

  /// Удалить работу по идентификатору
  Future<Job> deleteJob({
    required final Job job,
    required final String idToken,
  });
}

class JobNetworkDataProviderImpl implements IJobNetworkDataProvider {
  final grpc.JobServiceClient _client;

  const JobNetworkDataProviderImpl({
    required final grpc.JobServiceClient client,
  }) : _client = client;

  @override
  Future<JobsChunk> getRecent({
    required DateTime updatedAfter,
    required JobFilter filter,
  }) =>
      _client.getRecent(filter.toRecentProtobuf(updatedAfter)).then<JobsChunk>(JobsChunk.fromProtobuf);

  @override
  Future<JobsChunk> paginate({
    required DateTime updatedBefore,
    required JobFilter filter,
  }) =>
      _client.getRecent(filter.toPaginateProtobuf(updatedBefore)).then<JobsChunk>(JobsChunk.fromProtobuf);

  @override
  Future<Job> createJob({
    required JobData jobData,
    required final String idToken,
  }) =>
      _client
          .createJob(
            jobData.toProtobuf(),
            options: grpc.CallOptions(
              metadata: <String, String>{
                'Authorization': 'Bearer $idToken',
              },
            ),
          )
          .then<Job>(Job.fromProtobuf);

  @override
  Future<Job> getJob({required String id}) => _client.getJob(grpc.UUID(uuid: id)).then<Job>(Job.fromProtobuf);

  @override
  Future<Job> updateJob({
    required Job job,
    required final String idToken,
  }) =>
      _client
          .updateJob(
            job.toProtobuf(),
            options: grpc.CallOptions(
              metadata: <String, String>{
                'Authorization': 'Bearer $idToken',
              },
            ),
          )
          .then<Job>(Job.fromProtobuf);

  @override
  Future<Job> deleteJob({
    required Job job,
    required final String idToken,
  }) =>
      _client
          .deleteJob(
            job.toProtobuf(),
            options: grpc.CallOptions(
              metadata: <String, String>{
                'Authorization': 'Bearer $idToken',
              },
            ),
          )
          .then<Job>(Job.fromProtobuf);
}
