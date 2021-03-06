import 'dart:async';

import 'package:gql/ast.dart';
import 'package:gql_exec/gql_exec.dart';
import 'package:gql_link/gql_link.dart';
//import 'package:graphql/client.dart' hide JsonSerializable;
import 'package:l/l.dart';

//export 'package:graphql/client.dart' hide JsonSerializable;
export 'package:gql_exec/gql_exec.dart';
export 'package:gql_link/gql_link.dart';

/// Линк позволяющий отдельно перехватывать запросы и ответы
abstract class InterceptorLink extends Link {
  InterceptorLink({
    final this.timeout = const Duration(
      seconds: 30,
    ),
  });

  /// Таймаут на все операции
  final Duration timeout;

  @override
  Stream<Response> request(final Request request, [final NextLink? forward]) async* {
    if (forward == null) {
      throw Exception('This link does not support queries and subscription.');
    } else if (request.isSubscription) {
      yield* forward(request);
    }

    var newRequest = request;
    Response? newResponse;
    try {
      newRequest = await onRequest(request).timeout(timeout);
      newResponse = await forward(newRequest).first.timeout(timeout);
      newResponse = await onResponse(request, newResponse).timeout(timeout);
      yield newResponse;
    } on Object catch (error, stackTrace) {
      await onError(newRequest, newResponse, error, stackTrace).timeout(timeout);
      rethrow;
    } finally {
      try {
        onDone(newRequest, newResponse);
      } on Object catch (error, stackTrace) {
        l.w('Не пробрасываемая ошибка в InterceptorLink.onDone: $error', stackTrace);
      }
    }
  }

  /// Обратный вызов на запрос
  Future<Request> onRequest(
    Request request,
  ) =>
      Future<Request>.value(request);

  /// Обратный вызов на ответ
  Future<Response> onResponse(
    Request request,
    Response response,
  ) =>
      Future<Response>.value(response);

  /// Обратный вызов на ошибку
  Future<void> onError(
    Request request,
    Response? response,
    Object error,
    StackTrace stackTrace,
  ) =>
      Future<void>.sync(() {});

  /// Содержит запрос и ответ (если существуют)
  void onDone(Request request, Response? response) {}
}

extension WithType on Request {
  OperationType get type {
    final definitions = operation.document.definitions.whereType<OperationDefinitionNode>().toList();
    if (operation.operationName != null) {
      definitions.removeWhere(
        (node) => node.name!.value != operation.operationName,
      );
    }
    // TODO differentiate error types, add exception
    assert(definitions.length == 1, 'definitions = 1');
    return definitions.first.type;
  }

  bool get isQuery => type == OperationType.query;
  bool get isMutation => type == OperationType.mutation;
  bool get isSubscription => type == OperationType.subscription;
}
