import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

/// Удалить работу по идентификатору
/// 204 (No Content) - в случае успеха
Response deleteJob(Request request) {
  /// TODO: разбор токена Firebase Authentication в мидлваре:
  final userId = request.context['user_id'];
  if (userId == null) return Response.forbidden(List<int>.empty());

  final id = request.params['id'];
  if (id == null) return Response.notFound(List<int>.empty());

  return Response(204);
}
