import 'package:collection/collection.dart';
import 'package:dart_jobs_server/src/common/database/database.dart';
import 'package:dart_jobs_server/src/feature/job/model/find_jobs_filter.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:multiline/multiline.dart';

class JobDao {
  JobDao(final this.db);

  final Database db;

  /// Добавить новую работу
  Future<Job> createJob({required final String creatorId, required final JobData data}) async {
    final rows = await db.query(
      MultilineStringX('''
    |-- Добавим новую запись
    |INSERT INTO jobs.job (creator_id, job_data)
    |VALUES(@creatorId, @jobData::jsonb)
    |RETURNING
    |  id, deletion_mark, creator_id, created, updated, job_data;
    ''').multiline(),
      substitutionValues: <String, Object?>{
        'creatorId': creatorId,
        'jobData': data.toJson(),
      },
    );
    final row = rows.firstOrNull?.toColumnMap();
    if (row == null) {
      throw Exception('После создания не получен результат');
    }
    return Job.fromJson(row);
  }

  /// Получим данные по работе по идентификатору
  Future<Job> getJob(int id) async {
    final rows = await db.query(
      MultilineStringX('''
    |-- Получим данные по работе по идентификатору
    |SELECT id, deletion_mark, creator_id, created, updated, job_data FROM jobs.job WHERE id = @id LIMIT 1;
    ''').multiline(),
      substitutionValues: <String, Object?>{
        'id': id,
      },
    );
    final row = rows.firstOrNull?.toColumnMap();
    if (row == null) {
      throw Exception('Работа не найдена');
    }
    return Job.fromJson(row);
  }

  /// Обновить данные работы по идентификатору
  Future<Job> updateJob({required int id, required final String creatorId, required final JobData data}) async {
    final rows = await db.query(
      MultilineStringX('''
    |-- Обновим данные по работе по идентификатору
    |UPDATE jobs.job SET job_data = @jobData::jsonb WHERE id = @id AND creator_id = @creatorId AND deletion_mark = false
    |RETURNING
    |  id, deletion_mark, creator_id, created, updated, job_data;
    ''').multiline(),
      substitutionValues: <String, Object?>{
        'id': id,
        'creatorId': creatorId,
        'jobData': data.toJson(),
      },
    );
    final row = rows.firstOrNull?.toColumnMap();
    if (row == null) {
      throw Exception('После обновления не получен результат');
    }
    return Job.fromJson(row);
  }

  /// Пометить на удаление работу по идентификатору
  Future<void> deleteJob({required int id, required final String creatorId}) async {
    final rows = await db.query(
      MultilineStringX('''
    |-- Пометим на удаление работу по идентификатору
    |UPDATE jobs.job SET deletion_mark = true WHERE id = @id AND creator_id = @creatorId
    |RETURNING id;
    ''').multiline(),
      substitutionValues: <String, Object?>{
        'id': id,
        'creatorId': creatorId,
      },
    );
    final row = rows.firstOrNull?.toColumnMap();
    if (row == null) {
      throw Exception('Работа не была помечена на удаление');
    }
  }

  /// Получим список работ удовлетворяющих условиям
  Future<List<Job>> findJobs(FindJobsFilter filter) async {
    final rows = await db.query(
      MultilineStringX('''
    |-- Получим данные по работе по идентификатору
    |SELECT id, deletion_mark, creator_id, created, updated, job_data
    |FROM jobs.job
    |WHERE
    |  (@after IS NULL OR updated > @after)
    |  AND (@before IS NULL OR updated < @before)
    |LIMIT ${filter.limit.toString()};
    ''').multiline(),
      substitutionValues: <String, Object?>{
        'after': filter.after,
        'before': filter.before,
      },
    );
    return rows.map<Job>((row) => Job.fromJson(row.toColumnMap())).toList(growable: false);
  }
}
