import 'package:collection/collection.dart';
import 'package:dart_jobs_server/src/common/database/database.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:multiline/multiline.dart';

class JobDao {
  final Database db;
  JobDao(final this.db);

  Future<Job> createJob({required final String creatorId, required final JobData data}) async {
    final rows = await db.query(
      MultilineStringX('''
    |-- Добавим новую запись
    |INSERT INTO jobs.job (creator_id, job_data)
    |VALUES(@creatorId, @jobData::jsonb)
    |RETURNING
    |  id, deletion_mark, creator_id, created, updated, job_data
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
}
