import 'dart:async';

import 'package:dart_jobs_shared/graphql.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:meta/meta.dart';

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
    required final String creatorId,
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
  final GQLClient _client;

  const JobNetworkDataProviderImpl({
    required final GQLClient client,
  }) : _client = client;

  @override
  Future<JobsChunk> getRecent({required DateTime updatedAfter, required JobFilter filter}) async {
    final result = await _client.execute(
      FetchRecentQuery(
        variables: FetchRecentArguments(
          after: updatedAfter,
          limit: filter.limit,
        ),
      ),
    );
    await Future<void>.delayed(Duration.zero);
    final jobs = result.data?.job
        .map<Job>(
          (e) => Job(
            creatorId: e.creatorId,
            id: e.id,
            deletionMark: e.deletionMark,
            created: e.created,
            updated: e.updated,
            data: JobData(
              title: e.title,
              company: e.company,
              country: e.country,
              remote: e.remote,
              relocation: e.relocation,
              employments: e.employments,
              levels: e.levels,
              address: e.address,
              descriptions: Description.fromLanguages(
                english: e.isEnglish ? 'English' : '',
                russian: e.isRussian ? 'Russian' : '',
              ),
            ),
          ),
        )
        .toList(growable: false);

    if (jobs == null) {
      throw GraphQLJobException(result.errors ?? const <GraphQLError>[]);
    }

    await Future<void>.delayed(Duration.zero);

    jobs.sort();

    return JobsChunk(
      jobs: jobs,
      endOfList: jobs.isEmpty,
    );
  }

  @override
  Future<JobsChunk> paginate({required DateTime updatedBefore, required JobFilter filter}) async {
    final result = await _client.execute(
      PaginateQuery(
        variables: PaginateArguments(
          before: updatedBefore,
          limit: filter.limit,
        ),
      ),
    );

    await Future<void>.delayed(Duration.zero);
    final jobs = result.data?.job
        .map<Job>(
          (e) => Job(
            creatorId: e.creatorId,
            id: e.id,
            deletionMark: e.deletionMark,
            created: e.created,
            updated: e.updated,
            data: JobData(
              title: e.title,
              company: e.company,
              country: e.country,
              remote: e.remote,
              relocation: e.relocation,
              employments: e.employments,
              levels: e.levels,
              address: e.address,
              descriptions: Description.fromLanguages(
                english: e.isEnglish ? 'English' : '',
                russian: e.isRussian ? 'Russian' : '',
              ),
            ),
          ),
        )
        .toList(growable: false);

    if (jobs == null) {
      throw GraphQLJobException(result.errors ?? const <GraphQLError>[]);
    }

    await Future<void>.delayed(Duration.zero);

    jobs.sort();

    return JobsChunk(
      jobs: jobs,
      endOfList: jobs.isEmpty,
    );
  }

  @override
  // ignore: long-method
  Future<Job> createJob({
    required JobData jobData,
    required String idToken,
    required String creatorId,
  }) async {
    assert(idToken.isNotEmpty, 'idToken должен быть не пустой строкой');
    final result = await _client.execute(
      InsertJobMutation(
        variables: InsertJobArguments(
          title: jobData.title,
          company: jobData.company,
          country: jobData.country,
          address: jobData.address,
          creator_id: creatorId,
          remote: jobData.remote,
          relocation: jobData.relocation,
          english_description: jobData.englishDescription,
          is_english: jobData.englishDescription.isNotEmpty,
          russian_description: jobData.russianDescription,
          is_russian: jobData.russianDescription.isNotEmpty,
          contacts: jobData.contacts,
          employments: jobData.employments,
          levels: jobData.levels,
          skills: jobData.skills,
          tags: jobData.tags,
        ),
      ),
      context: _addTokenToContext(idToken),
    );
    await Future<void>.delayed(Duration.zero);
    final job = result.data?.insertJobOne;
    if (job == null) {
      throw GraphQLJobException(result.errors ?? const <GraphQLError>[]);
    }
    return Job(
      creatorId: job.creatorId,
      id: job.id,
      deletionMark: job.deletionMark,
      created: job.created,
      updated: job.updated,
      data: JobData(
        title: job.title,
        company: job.company,
        country: job.country,
        address: job.address,
        remote: job.remote,
        relocation: job.relocation,
        employments: job.employments,
        levels: job.levels,
        tags: job.tags,
        skills: job.skills,
        contacts: job.contacts,
        descriptions: Description.fromLanguages(
          english: job.englishDescription,
          russian: job.russianDescription,
        ),
      ),
    );
  }

  @override
  Future<Job> getJob({required int id}) async {
    assert(!id.isNegative, 'id должен быть положительным');
    final result = await _client.execute(
      GetJobQuery(
        variables: GetJobArguments(
          id: id,
        ),
      ),
    );
    await Future<void>.delayed(Duration.zero);
    final job = result.data?.jobByPk;
    if (job == null) {
      throw GraphQLJobException(result.errors ?? const <GraphQLError>[]);
    }
    return Job(
      creatorId: job.creatorId,
      id: job.id,
      deletionMark: job.deletionMark,
      created: job.created,
      updated: job.updated,
      data: JobData(
        title: job.title,
        company: job.company,
        country: job.country,
        address: job.address,
        remote: job.remote,
        relocation: job.relocation,
        employments: job.employments,
        levels: job.levels,
        tags: job.tags,
        skills: job.skills,
        contacts: job.contacts,
        descriptions: Description.fromLanguages(
          english: job.englishDescription,
          russian: job.russianDescription,
        ),
      ),
    );
  }

  @override
  Future<Job> updateJob({required Job job, required String idToken}) async {
    assert(idToken.isNotEmpty, 'idToken должен быть не пустой строкой');
    assert(job.hasID, 'У работы должен быть валидный идентификатор');
    final result = await _client.execute(
      UpdateJobMutation(
        variables: UpdateJobArguments(
          id: job.id,
          data: JobSetInput(
            deletionMark: job.deletionMark,
            company: job.data.company,
            contacts: job.data.contacts,
            country: job.data.country,
            address: job.data.address,
            employments: job.data.employments,
            englishDescription: job.data.englishDescription,
            isEnglish: job.data.englishDescription.isNotEmpty,
            levels: job.data.levels,
            relocation: job.data.relocation,
            remote: job.data.remote,
            russianDescription: job.data.russianDescription,
            isRussian: job.data.russianDescription.isNotEmpty,
            skills: job.data.skills,
            tags: job.data.tags,
            title: job.data.title,
          ),
        ),
      ),
      context: _addTokenToContext(idToken),
    );
    await Future<void>.delayed(Duration.zero);
    final updatedJob = result.data?.updateJobByPk;
    if (updatedJob == null) {
      throw GraphQLJobException(result.errors ?? const <GraphQLError>[]);
    }
    return job.copyWith(
      id: updatedJob.id,
      updated: updatedJob.updated,
      created: updatedJob.created,
      deletionMark: updatedJob.deletionMark,
      creatorId: updatedJob.creatorId,
    );
  }

  @override
  Future<Job> deleteJob({required Job job, required String idToken}) async {
    assert(idToken.isNotEmpty, 'idToken должен быть не пустой строкой');
    assert(job.hasID, 'У работы должен быть валидный идентификатор');

    final result = await updateJob(
      job: job.copyWith(
        deletionMark: true,
      ),
      idToken: idToken,
    );
    return result;
  }

  Context _addTokenToContext(
    String idToken, [
    final Context? context,
  ]) =>
      (context ?? const Context()).updateEntry<HttpLinkHeaders>(
        (entry) => HttpLinkHeaders(
          headers: {
            ...?entry?.headers,
            'Authorization': 'Bearer $idToken',
          },
        ), // (entry ?? const HttpLinkHeaders()),
      );
}

/// Исключение получения данных по работе
@immutable
class GraphQLJobException implements Exception {
  const GraphQLJobException(this.errors);

  final List<GraphQLError> errors;

  @override
  String toString() => 'Job GraphQL exception: ${errors.map<String>((e) => e.message).join(', ')}';
}
