import 'dart:convert';
import 'dart:io';

import 'package:l/l.dart';

void main() => Future<void>(
      () async {
        final uri = Uri.parse('https://api.plugfox.dev:443/dart_jobs/prod/echo');

        /// HTTP CLIENT
        final client = HttpClient(context: SecurityContext.defaultContext);

        /// Send http echo request
        final request = await client.getUrl(uri);
        request.headers.add('Authentication', '123');
        final response = await request.close();
        l.i('statusCode: ${response.statusCode}\n' 'headers: ${response.headers}');
        final body = await const Utf8Decoder().bind(response).transform(const LineSplitter()).join('\n');
        l.i('body: $body\n\n');

        /// WEB SOCKET CLIENT
        final ws = await WebSocket.connect(
          'wss://${uri.host}${uri.path}/ws',
          protocols: <String>[
            'demo',
            'echo',
            'sample',
          ],
          compression: CompressionOptions.compressionDefault,
          headers: <String, String>{
            'Authentication': '123',
          },
        );
        l.i('Обновились до ws');

        /// Send ws echo requests
        ws.listen((Object? message) => l.s('< $message'));
        l.i('Подписались на ws');
        for (var i = 0; i < 10; i++) {
          final msg = '*$i*';
          ws.add(msg);
          l.i('> $msg');
          await Future<void>.delayed(const Duration(milliseconds: 150));
        }

        client.close();
        await ws.close(1000, 'Well done');
        l.i('Отписались от ws и http');
      },
    );

/*
HOW TO UPGRADE FROM HTTP TO WS:
https://ru.wikipedia.org/wiki/WebSocket

REQUEST:
GET /chat HTTP/1.1
Host: server.example.com
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Key: dGhlIHNhbXBsZSBub25jZQ==
Sec-WebSocket-Origin: http://example.com
Sec-WebSocket-Protocol: chat, superchat
Sec-WebSocket-Version: 7

->

RESPONSE:
HTTP/1.1 101 Switching Protocols
Upgrade: websocket
Connection: Upgrade
Sec-WebSocket-Accept: s3pPLMBiTxaQ9kYGzzhZRbK+xOo=
Sec-WebSocket-Protocol: chat
*/
