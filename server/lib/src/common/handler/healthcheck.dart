import 'package:shelf/shelf.dart';

/// Health check
Response healthCheck(Request request) => Response.ok(
      '{"status":"ok"}',
      headers: <String, String>{
        'Content-Type': 'application/health+json',
        'Cache-Control': 'no-cache',
        'Connection': 'close',
      },
    );
