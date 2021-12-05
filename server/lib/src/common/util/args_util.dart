import 'package:args/args.dart';

abstract class ArgsUtil {
  ArgsUtil._();

  static ArgResults parse(List<String>? args) => (ArgParser()
        ..addOption(
          'port',
          abbr: 'p',
          valueHelp: '80',
          help: 'Порт запуска приложения',
        )
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
      .parse(args ?? <String>[]);
}
