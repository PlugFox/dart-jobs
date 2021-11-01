import 'dart:io' as io;

import 'package:args/args.dart';

/// Получить http/ws порт
int getPort([final List<String>? args]) {
  String? portFromArg;
  if (args != null) {
    final argResult = (ArgParser()
          ..addOption(
            'port',
            abbr: 'p',
            valueHelp: '80',
            help: 'Порт запуска приложения',
          ))
        .parse(args);
    portFromArg = argResult.wasParsed('port') ? argResult['port']?.toString() : null;
  }
  final portFromEnv = io.Platform.environment['PORT'];
  const defaultPort = '80';
  return int.parse(portFromArg ?? portFromEnv ?? defaultPort);
}
