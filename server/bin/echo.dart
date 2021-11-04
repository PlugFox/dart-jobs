import 'dart:async';
import 'dart:io' as io;

import 'package:dart_jobs_server/src/common/util/get_port.dart';
import 'package:dart_jobs_server/src/common/util/runner.dart';
import 'package:dart_jobs_server/src/feature/echo/http_echo_router.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';

void main(List<String> args) => l.capture(
      () => runner<ServerConfig>(
        initialization: () async {
          final stopwatch = Stopwatch()..start();

          // Установим маску
          final ip = io.InternetAddress.anyIPv4;

          // Получим http порт
          final port = getPort(args);

          // Пайплайн обработки запроса
          final httpHandler = const Pipeline()
              //.addMiddleware(exceptionResponse())
              .addMiddleware(logRequests(logger: (msg, isError) => isError ? l.e(msg) : l.i(msg)))
              //.addMiddleware(authMiddleware)
              .addHandler(httpEchoRouter);

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

          return ServerConfig(
            servers: <io.HttpServer>[
              httpServer,
            ],
          );
        },
        onShutdown: (config) async {
          try {
            await Future.wait<void>(config.servers.map((s) => s.close())).timeout(const Duration(seconds: 5));
          } on TimeoutException {
            await Future.wait<void>(config.servers.map((s) => s.close(force: true)))
                .timeout(const Duration(seconds: 5));
          }
        },
      ),
      const LogOptions(
        handlePrint: true,
        outputInRelease: true,
      ),
    );

@immutable
class ServerConfig {
  final List<io.HttpServer> servers;
  const ServerConfig({
    required final this.servers,
  });
}
