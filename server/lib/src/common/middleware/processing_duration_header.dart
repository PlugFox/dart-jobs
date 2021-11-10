import 'package:shelf/shelf.dart';

/// Добавляет время обработки запроса в заголовки ответа
Handler Function(Handler innerHandler) get processingDurationHeader => (innerHandler) => (request) {
      final sw = Stopwatch()..start();
      return Future<Response>.sync(
        () => innerHandler(request),
      ).then<Response>(
        (response) => response.change(
          headers: <String, String>{
            'X-Server-Processing-Duration': '${(sw..stop()).elapsedMilliseconds} ms',
          },
        ),
        onError: (Object error, StackTrace stackTrace) {
          sw.stop();
          // ignore: only_throw_errors
          throw error;
        },
      );
    };
