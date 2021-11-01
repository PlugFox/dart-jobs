import 'dart:async';

import 'package:l/l.dart';
import 'package:server/src/feature/echo/websocket_echo_callback.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_web_socket/shelf_web_socket.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Configure routes.
final Router httpEchoRouter = Router()
  ..get('/', _rootHandler)
  ..get('/ws', _wsHandler)
  ..get('/<message>', _echoHandler);

Response _rootHandler(Request req) {
  l.i('http: /');
  return Response.ok('Hello, World!\n');
}

FutureOr<Response> _wsHandler(Request req) {
  l.i(
    'Запрос на соединение по ws, headers:\n'
    '${req.headers.entries.map<String>((e) => '${e.key}: ${e.value}').join('\n')}',
  );
  return webSocketHandler(
    (Object? webSocket) {
      if (webSocket is WebSocketChannel) {
        webSocket.stream.listen(
          (Object? message) => webSocketEchoCallback(message, webSocket.sink),
          cancelOnError: false,
          onDone: () => l.i('closeCode: ${webSocket.closeCode}'),
        );
      } else {
        throw UnsupportedError('Unknown web socket type: ${webSocket.runtimeType}');
      }
    },
  )(req);
}

Response _echoHandler(Request request) {
  final message = request.params['message'];
  l.i('http: /$message');
  return Response.ok('$message\n');
}