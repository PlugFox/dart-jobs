import 'dart:async';
import 'dart:io' as io;

import 'package:dart_jobs_server/src/common/middleware/cors_headers.dart';
import 'package:dart_jobs_server/src/common/middleware/processing_duration_header.dart';
import 'package:dart_jobs_server/src/common/util/get_port.dart';
import 'package:dart_jobs_server/src/common/util/runner.dart';
import 'package:dart_jobs_server/src/feature/job/handler/jobs_router.dart';
import 'package:l/l.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) => l.capture(
      () => runner<io.HttpServer>(
        initialization: () async {
          final stopwatch = Stopwatch()..start();

          // Установим маску
          final ip = io.InternetAddress.anyIPv4;

          // Получим http порт
          final port = getPort(args);

          // Пайплайн обработки запроса
          final httpHandler = const Pipeline()
              //.addMiddleware(exceptionResponse())
              .addMiddleware(processingDurationHeader)
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

          return httpServer;
        },
        onShutdown: (config) async {
          try {
            await config.close().timeout(const Duration(seconds: 5));
          } on TimeoutException {
            await config.close(force: true).timeout(const Duration(seconds: 5));
          }
        },
      ),
      const LogOptions(
        handlePrint: true,
        outputInRelease: true,
      ),
    );
