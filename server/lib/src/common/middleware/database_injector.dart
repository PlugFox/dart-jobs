import 'package:dart_jobs_server/src/common/database/database.dart';
import 'package:dart_jobs_server/src/feature/job/database/job_dao.dart';
import 'package:shelf/shelf.dart';

const String _$database = r'$database$';
const String _$jobDao = r'$jobDao$';

/// Добавляет время обработки запроса в заголовки ответа
Middleware databaseInjector(Database database) => (innerHandler) => (request) {
      final jobDao = JobDao(database);
      return Future<Response>.sync(
        () => innerHandler(
          request.change(
            context: <String, Object>{
              _$database: database,
              _$jobDao: jobDao,
            },
          ),
        ),
      );
    };

extension GetDatabaseFromContextX on Request {
  /// Получить базу данных из контекста запроса
  Database get database {
    final db = context[_$database];
    if (db is Database) {
      return db;
    }
    throw UnsupportedError('Can not find Database in context');
  }

  /// Получить DAO из контекста запроса
  JobDao get jobDao {
    final dao = context[_$jobDao];
    if (dao is JobDao) {
      return dao;
    }
    throw UnsupportedError('Can not find JobDao in context');
  }
}
