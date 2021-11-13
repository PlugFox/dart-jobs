import 'package:dart_jobs_server/src/common/database/database.dart';
import 'package:shelf/shelf.dart';

/// Добавляет время обработки запроса в заголовки ответа
Middleware databaseInjector(Database database) => (innerHandler) => (request) {
      //pg.PgDatabase();
      request.change(
        context: <String, Object>{
          'database': database,
        },
      );
      return Future<Response>.sync(
        () => innerHandler(request),
      );
    };
