import 'dart:async';
import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:l/l.dart';
import 'package:server/src/runner.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

// Configure routes.
final Router router = Router()
  ..get('/', _rootHandler)
  ..get('/echo/<message>', _echoHandler);

Response _rootHandler(Request req) {
  return Response.ok('Hello, World!\n');
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  return Response.ok('$message\n');
}

void main(List<String> args) => l.capture(
      () => runner<io.HttpServer>(
        initialization: () async {
          final stopwatch = Stopwatch()..start();
          final argResult = (ArgParser()
                ..addOption(
                  'port',
                  abbr: 'p',
                  valueHelp: '80',
                  help: 'Порт запуска приложения',
                ))
              .parse(args);

          // Установим маску
          final ip = io.InternetAddress.anyIPv4;

          // Получим порт
          final portFromArg = argResult.wasParsed('port') ? argResult['port'] : null;
          //final portFromEnv = io.Platform.environment['PORT'];
          const defaultPort = '80';
          final port = int.parse(portFromArg ?? defaultPort);

          // Пайплайн обработки запроса
          final handler = Pipeline()
              .addMiddleware(
                logRequests(
                  logger: (msg, isError) => isError ? l.e(msg) : l.i(msg),
                ),
              )
              .addHandler(router);

          // Запуск сервера
          final server = await serve(handler, ip, port);

          l.i('Server started in ${(stopwatch..stop()).elapsedMilliseconds} ms and listening on port [${server.port}]');

          return server;
        },
        onShutdown: (server) async {
          try {
            await server.close().timeout(const Duration(seconds: 5));
          } on TimeoutException {
            server.close(force: true);
          }
        },
      ),
      LogOptions(
        handlePrint: true,
        outputInRelease: true,
      ),
    );
