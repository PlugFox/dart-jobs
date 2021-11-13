import 'dart:async';

import 'package:dart_jobs_shared/model.dart';
import 'package:dio/dio.dart';

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
  Future<Job> getJob({required final int id});

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
  final Dio _client;

  const JobNetworkDataProviderImpl({
    required final Dio client,
  }) : _client = client;

  @override
  Future<JobsChunk> getRecent({required DateTime updatedAfter, required JobFilter filter}) async {
    final response = await _client.get<List<int>>(
      '/jobs',
      queryParameters: <String, Object>{
        ...filter.toQueryParameters(),
        'after': updatedAfter.toUtc().toIso8601String(),
      },
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/octet-stream',
        },
      ),
    );
    final bytes = response.data;
    if (bytes == null) throw UnsupportedError('Jobs does not received from server');
    final chunk = JobsChunk.fromBytes(bytes);
    if (chunk.isEmpty && !chunk.endOfList) {
      return const JobsChunk(
        jobs: <Job>[],
        endOfList: true,
      );
    }
    return chunk;
  }

  @override
  Future<JobsChunk> paginate({required DateTime updatedBefore, required JobFilter filter}) async {
    final response = await _client.get<List<int>>(
      '/jobs',
      queryParameters: <String, Object>{
        ...filter.toQueryParameters(),
        'before': updatedBefore.toUtc().toIso8601String(),
      },
      options: Options(
        headers: <String, String>{
          'Content-Type': 'application/octet-stream',
        },
      ),
    );
    final bytes = response.data;
    if (bytes == null) throw UnsupportedError('Jobs does not received from server');
    final chunk = JobsChunk.fromBytes(bytes);
    if (chunk.isEmpty && !chunk.endOfList) {
      return const JobsChunk(
        jobs: <Job>[],
        endOfList: true,
      );
    }
    return chunk;
  }

  @override
  Future<Job> createJob({required JobData jobData, required String idToken}) async {
    assert(idToken.isNotEmpty, 'idToken должен быть не пустой строкой');
    final response = await _client.post<List<int>>(
      '/jobs',
      data: jobData.toBytes(),
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/octet-stream',
        },
      ),
    );
    final bytes = response.data;
    if (bytes == null) throw UnsupportedError('Job does not returned from server');
    return Job.fromBytes(bytes);
  }

  @override
  Future<Job> getJob({required int id}) async {
    assert(!id.isNegative, 'id должен быть положительным');
    final response = await _client.get<List<int>>('/jobs/id$id');
    final bytes = response.data;
    if (bytes == null) throw UnsupportedError('Job does not returned from server');
    return Job.fromBytes(bytes);
  }

  @override
  Future<Job> updateJob({required Job job, required String idToken}) async {
    assert(idToken.isNotEmpty, 'idToken должен быть не пустой строкой');
    assert(job.hasID, 'У работы должен быть валидный идентификатор');
    final response = await _client.put<List<int>>(
      '/jobs/id${job.id}',
      data: job.data.toBytes(),
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $idToken',
          'Content-Type': 'application/octet-stream',
        },
      ),
    );
    final bytes = response.data;
    if (bytes == null) throw UnsupportedError('Job does not updated at server');
    return Job.fromBytes(bytes);
  }

  @override
  Future<Job> deleteJob({required Job job, required String idToken}) async {
    assert(idToken.isNotEmpty, 'idToken должен быть не пустой строкой');
    assert(job.hasID, 'У работы должен быть валидный идентификатор');
    final response = await _client.delete<List<int>>(
      '/jobs/id${job.id}',
      options: Options(
        headers: <String, String>{
          'Authorization': 'Bearer $idToken',
        },
      ),
    );
    final bytes = response.data;
    if (bytes == null) throw UnsupportedError('Job does not deleted at server');
    return job.copyWith(
      updated: DateTime.now(),
      deletionMark: true,
    );
  }
}
