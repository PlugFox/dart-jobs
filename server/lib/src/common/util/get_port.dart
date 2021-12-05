import 'dart:io' as io;

import 'package:args/args.dart';

/// Получить http/ws порт
int getPort(final ArgResults args) {
  final portFromArg = args.wasParsed('port') ? args['port']?.toString() : null;
  final portFromEnv = io.Platform.environment['PORT'];
  const defaultPort = '80';
  return int.parse(portFromArg ?? portFromEnv ?? defaultPort);
}
