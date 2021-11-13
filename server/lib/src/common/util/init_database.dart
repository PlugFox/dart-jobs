import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:dart_jobs_server/src/common/database/database.dart';

Future<Database> initDatabase([final List<String>? args]) {
  final argResult = (ArgParser()
        ..addOption(
          'db_host',
          valueHelp: 'postgres',
          help: 'Хост БД',
        )
        ..addOption(
          'db_port',
          valueHelp: '5432',
          help: 'Порт доступа к БД',
        )
        ..addOption(
          'db_name',
          valueHelp: 'postgres',
          help: 'Имя базы данных',
        )
        ..addOption(
          'db_username',
          valueHelp: 'username',
          help: 'Логин базы данных',
        )
        ..addOption(
          'db_password',
          valueHelp: 'password',
          help: 'Пароль базы данных',
        ))
      .parse(args ?? const <String>[]);
  return Database.init(
    host: argResult['db_host']?.toString() ?? io.Platform.environment['DB_HOST'] ?? 'postgres',
    port: int.parse(argResult['db_port']?.toString() ?? io.Platform.environment['DB_PORT'] ?? '5432'),
    database: argResult['db_name']?.toString() ?? io.Platform.environment['DB_NAME'] ?? 'postgres',
    username: argResult['db_host']?.toString() ?? io.Platform.environment['DB_USERNAME'],
    password: argResult['db_password']?.toString() ?? io.Platform.environment['DB_PASSWORD'],
  );
}
