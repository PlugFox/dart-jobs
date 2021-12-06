import 'package:dart_jobs_server/src/common/middleware/database_injector.dart';
import 'package:shelf/shelf.dart';

/// Health check
Response healthCheck(Request request) {
  if (request.database.isClosed) {
    return Response.internalServerError(
      body: '{"status":"database-connection-closed",'
          '"message":"Database connection has been closed or encountered an unrecoverable error"}',
      headers: <String, String>{
        'Content-Type': 'application/health+json',
        'Cache-Control': 'no-cache',
        'Connection': 'close',
        'X-Health-Check': 'database-connection-closed',
      },
    );
  }
  return Response.ok(
    '{"status":"ok","message":"everything is fine"}',
    headers: <String, String>{
      'Content-Type': 'application/health+json',
      'Cache-Control': 'no-cache',
      'Connection': 'close',
      'X-Health-Check': 'ok',
    },
  );
}
