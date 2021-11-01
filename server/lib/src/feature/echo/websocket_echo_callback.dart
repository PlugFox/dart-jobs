import 'package:l/l.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Configure routes.
void webSocketEchoCallback(Object? message, WebSocketSink sink) {
  l.i('ws: $message');
  sink.add('echo $message');
}
