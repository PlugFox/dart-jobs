import 'package:dart_jobs_server/src/common/util/jwt.dart';
import 'package:meta/meta.dart';
import 'package:shelf/shelf.dart';

const String _$subject = r'$subject$';

/// Проверяет заголовки авторизации на наличие JWT.
/// Если он содержится - валидирует его и добавляет результат в контекст
Handler Function(Handler innerHandler) get authMiddleware => (innerHandler) => (request) {
      JWT? jwt;
      try {
        jwt = getJwtFromHeaders(request.headers);
      } on Object {
        return Response.internalServerError(body: 'Token parsing error');
      }
      if (jwt == null) {
        return Future<Response>.sync(
          () => innerHandler(request),
        );
      }

      /// TODO: Вынести валидацию Firebase JWT в отдельный сервис
      // https://firebase.google.com/docs/auth/admin/verify-id-tokens
      final errors = jwt.validatePayload(
        dateTime: DateTime.now(),
        tolerance: const Duration(hours: 1),
        audience: 'dart-job',
        issuer: 'https://securetoken.google.com/dart-job',
      );
      final uid = jwt.payload.subject;
      if (uid == null || uid.isEmpty) {
        errors.add('User ID missing');
      }
      if (errors.isEmpty) {
        return Future<Response>.sync(
          () => innerHandler(
            request.change(
              context: <String, Object>{
                _$subject: uid!,
              },
            ),
          ),
        );
      }
      return Response.forbidden(errors.join(', '));
    };

@visibleForTesting
JWT? getJwtFromHeaders(Map<String, String> headers) {
  final header = headers['authorization'];
  if (header == null) return null;
  final token = header.startsWith('Bearer ') ? header.substring(7) : header;
  return JWT.decode(token);
}

extension GetAuthenticationFromContextX on Request {
  /// Получить идентификатор пользователя
  String? get uid => context[_$subject]?.toString();
}
