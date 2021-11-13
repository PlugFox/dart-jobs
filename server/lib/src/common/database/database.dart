import 'package:postgres/postgres.dart';

class Database extends PostgreSQLConnection {
  Database._({
    required final String host,
    required final int port,
    required final String database,
    String? username,
    String? password,
    int timeout = 30,
    int queryTimeout = 30,
    String timeZone = 'UTC',
    bool useSSL = false,
    bool isUnixSocket = false,
  }) : super(
          host,
          port,
          database,
          username: username,
          password: password,
          timeoutInSeconds: timeout,
          queryTimeoutInSeconds: queryTimeout,
          timeZone: timeZone,
          useSSL: useSSL,
          isUnixSocket: isUnixSocket,
        );

  static Future<Database> init({
    required final String host,
    required final int port,
    required final String database,
    String? username,
    String? password,
    int timeout = 30,
    int queryTimeout = 30,
    String timeZone = 'UTC',
    bool useSSL = false,
    bool isUnixSocket = false,
  }) async {
    final db = Database._(
      host: host,
      port: port,
      database: database,
      username: username,
      password: password,
      timeout: timeout,
      queryTimeout: queryTimeout,
      timeZone: timeZone,
      useSSL: useSSL,
      isUnixSocket: isUnixSocket,
    );
    await db.open().timeout(Duration(seconds: timeout));
    return db;
  }
}
