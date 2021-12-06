import 'package:dart_jobs_server/src/common/util/jwt.dart';
import 'package:shelf/shelf.dart';

const String _$subject = r'$subject$';

/// Проверяет заголовки авторизации на наличие JWT.
/// Если он содержится - валидирует его и добавляет результат в контекст
Handler Function(Handler innerHandler) get authMiddleware => (innerHandler) => (request) {
      final header = request.headers['authorization'];
      if (header == null) {
        return Future<Response>.sync(
          () => innerHandler(request),
        );
      }
      final now = DateTime.now();
      final idx = header.indexOf('Bearer ');
      final token = idx > 0 ? header.substring(idx) : header;
      final jwt = JWT.decode(token);
      // https://firebase.google.com/docs/auth/admin/verify-id-tokens
      final errors = jwt.validatePayload(
        dateTime: now,
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
            request.change(context: <String, Object>{
              _$subject: uid!,
            }),
          ),
        );
      }
      return Response.forbidden(errors.join(', '));
    };

extension GetAuthenticationFromContextX on Request {
  /// Получить идентификатор пользователя
  String? get uid => context[_$subject]?.toString();
}
