import 'package:dart_jobs_server/src/common/database/database.dart';
import 'package:dart_jobs_server/src/feature/job/database/job_dao.dart';
import 'package:shelf/shelf.dart';

const _$database = r'$database$';
const _$jobDao = r'$jobDao$';

/// Добавляет время обработки запроса в заголовки ответа
Middleware databaseInjector(Database database) => (innerHandler) => (request) {
      final jobDao = JobDao(database);
      request.change(
        context: <String, Object>{
          _$database: database,
          _$jobDao: jobDao,
        },
      );
      return Future<Response>.sync(
        () => innerHandler(request),
      );
    };

extension GetDatabaseFromContextX on Request {
  Database get database => (context[_$database] as Database?)!;
  JobDao get jobDao => (context[_$jobDao] as JobDao?)!;
}
