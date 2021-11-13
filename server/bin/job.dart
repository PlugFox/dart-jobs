import 'dart:async';
import 'dart:io' as io;

import 'package:dart_jobs_server/src/common/database/database.dart';
import 'package:dart_jobs_server/src/common/middleware/cors_headers.dart';
import 'package:dart_jobs_server/src/common/middleware/database_injector.dart';
import 'package:dart_jobs_server/src/common/middleware/processing_duration_header.dart';
import 'package:dart_jobs_server/src/common/util/get_port.dart';
import 'package:dart_jobs_server/src/common/util/init_database.dart';
import 'package:dart_jobs_server/src/common/util/runner.dart';
import 'package:dart_jobs_server/src/feature/job/handler/jobs_router.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

/// --port=        || PORT
/// --db_host=     || DB_HOST
/// --db_port=     || DB_PORT
/// --db_name=     || DB_NAME
/// --db_username= || DB_USERNAME
/// --db_password= || DB_PASSWORD
void main(List<String> args) => l.capture(
      () => runner<JobServerConfig>(
        initialization: () async {
          final stopwatch = Stopwatch()..start();

          // Установим маску
          final ip = io.InternetAddress.anyIPv4;

          // Получим http порт
          final port = getPort(args);

          // Postgres
          final database = await initDatabase(args);

          // Пайплайн обработки запроса
          final httpHandler = const Pipeline()
              //.addMiddleware(exceptionResponse())
              .addMiddleware(processingDurationHeader)
              .addMiddleware(databaseInjector(database))
              .addMiddleware(logRequests(logger: (msg, isError) => isError ? l.w(msg) : null))
              .addMiddleware(corsHeaders())
              //.addMiddleware(authMiddleware)
              .addHandler(jobsRouter);

          // Запуск http сервера
          final httpServer = await serve(
            httpHandler,
            ip,
            port,
            shared: false,
          );

          l.i(
            'Server started in ${(stopwatch..stop()).elapsedMilliseconds} ms '
            'at http://${httpServer.address.host}:${httpServer.port}',
          );

          return JobServerConfig(
            httpServer: httpServer,
            database: database,
          );
        },
        onShutdown: (config) async {
          try {
            await config.database.close().timeout(const Duration(seconds: 5));
            await config.httpServer.close().timeout(const Duration(seconds: 5));
          } on TimeoutException {
            await Future.wait<void>([
              config.httpServer.close(force: true),
              config.database.close(),
            ]).timeout(const Duration(seconds: 5));
          }
        },
      ),
      const LogOptions(
        handlePrint: true,
        outputInRelease: true,
      ),
    );

@immutable
class JobServerConfig {
  const JobServerConfig({
    required final this.database,
    required final this.httpServer,
  });

  final Database database;
  final io.HttpServer httpServer;
}
