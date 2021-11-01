import 'dart:async';
import 'dart:io' as io;

import 'package:l/l.dart';

/// Запуск сервера, который может быть завершен по ошибке или
/// по сигналу операционной системы или команде пользователя
/// [initialization] - инициализация приложения
/// [onShutdown] - попытка аккуратного закрытия приложения
/// [onError] - произошла ошибка которая повлечет за собой закрытие сервера
/// [initializationTimeout] - время отведенное на запуск сервера
/// [shutdownTimeout] -
Future<Config>? runner<Config extends Object>({
  required final Future<Config> Function() initialization,
  required final Future<void> Function(Config config) onShutdown,
  final Future<void> Function(Object error, StackTrace stackTrace)? onError,
  final Duration initializationTimeout = const Duration(seconds: 15),
  final Duration shutdownTimeout = const Duration(seconds: 5),
}) {
  io.exitCode = 0; // presume success
  Config? config;
  return runZonedGuarded<Future<Config>>(
    () async {
      config = await initialization().timeout(initializationTimeout);
      // ignore: unawaited_futures
      _shutdownHandler(() {
        final shutdownConfig = config;
        config = null;
        return shutdownConfig == null ? Future<void>.value() : onShutdown(shutdownConfig);
      }).then<Never>(
        (_) {
          io.exitCode = 0; // presume success
          io.exit(0);
        },
      );
      return config!;
    },
    (Object error, StackTrace stackTrace) async {
      io.exitCode = 2; // presume error
      try {
        l.e('Unsupported error: $error\n' '$stackTrace');
        await Future.wait<void>(
          <Future<void>>[
            if (onError != null) onError(error, stackTrace),
            if (config != null) onShutdown(config!),
          ],
        ).timeout(shutdownTimeout);
      } finally {
        io.exit(2);
      }
    },
  );
}

/// Приготовимся к завершению приложения
Future<T?> _shutdownHandler<T extends Object?>(final Future<T> Function() onShutdown) {
  //StreamSubscription<String>? userKeySub;
  StreamSubscription<io.ProcessSignal>? sigIntSub;
  StreamSubscription<io.ProcessSignal>? sigTermSub;
  final shutdownCompleter = Completer<T>.sync();
  var catchShutdownEvent = false;
  {
    Future<void> signalHandler(io.ProcessSignal signal) async {
      if (catchShutdownEvent) return;
      catchShutdownEvent = true;
      l.i('Received signal [$signal] - closing');
      T? result;
      try {
        //userKeySub?.cancel();
        // ignore: unawaited_futures
        sigIntSub?.cancel();
        // ignore: unawaited_futures
        sigTermSub?.cancel();
        result = await onShutdown();
      } finally {
        shutdownCompleter.complete(result);
      }
    }

    /*
    // Ошибка в проде при попытке отслеживания событий с клавиатуры
    // StdinException: Error setting terminal echo mode, OS Error: Inappropriate ioctl for device, errno = 25
    if (io.stdin.hasTerminal) {
      l.i('Press [Q] to exit');
      io.stdin.echoMode = false;
      io.stdin.lineMode = false;
      userKeySub = const Utf8Decoder().bind(io.stdin).listen(
        (line) {
          final formattedLine = line.trim().toLowerCase();
          if (formattedLine.contains('q')) {
            signalHandler(io.ProcessSignal.sigint);
          } else {
            l.i('Press [Q] to exit');
          }
        },
      );
    }
    */

    sigIntSub = io.ProcessSignal.sigint.watch().listen(signalHandler, cancelOnError: false);
    // SIGTERM is not supported on Windows. Attempting to register a SIGTERM handler raises an exception.
    if (!io.Platform.isWindows) {
      sigTermSub = io.ProcessSignal.sigterm.watch().listen(signalHandler, cancelOnError: false);
    }
  }
  return shutdownCompleter.future;
}
