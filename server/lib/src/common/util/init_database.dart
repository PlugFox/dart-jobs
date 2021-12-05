import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:dart_jobs_server/src/common/database/database.dart';

Future<Database> initDatabase(final ArgResults args) => Database.init(
      host: _getArgument(args, 'db_host', 'DB_HOST') ?? 'postgres',
      port: int.parse(_getArgument(args, 'db_port', 'DB_PORT') ?? '5432'),
      database: _getArgument(args, 'db_name', 'DB_NAME') ?? 'dart_jobs',
      username: _getArgument(args, 'db_username', 'DB_USERNAME') ?? _getFromSecrets('DB_USERNAME_SECRET_PATH'),
      password: _getArgument(args, 'db_password', 'DB_PASSWORD') ?? _getFromSecrets('DB_PASSWORD_SECRET_PATH'),
    );

String? _getArgument(ArgResults args, String arg, String env) {
  String? result;
  if (args.wasParsed(arg)) {
    result = args[arg]?.toString();
  }
  return (result ?? io.Platform.environment[env])?.trim();
}

String _getFromSecrets(String key) {
  final path = io.Platform.environment[key];
  if (path == null) {
    throw FormatException('Secret "$key" does not exist');
  }
  final file = io.File(path);
  if (file.existsSync()) {
    final secret = file.readAsStringSync().trim();
    if (secret.isEmpty) {
      throw FormatException('Secret ашду "$path" is empty');
    }
    //l.d('$key : $path : "$secret"');
    return secret;
  } else {
    throw FormatException('Secret file "$path" does not exist');
  }
}
