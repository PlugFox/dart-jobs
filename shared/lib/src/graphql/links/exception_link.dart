import 'dart:async';
import 'dart:convert';

import 'package:dart_jobs_shared/src/graphql/links/handler_link.dart';
import 'package:dart_jobs_shared/src/graphql/links/interceptor_link.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:sentry/sentry.dart';

@immutable
class ExceptionLink extends InterceptorLink {
  ExceptionLink({
    final this.onGraphQLError,
    final this.onLinkException,
  });

  /// Обратный вызов на ответ с ошибками возвращаемый с сервера
  final FutureOr<void> Function(
    Request request,
    Response response,
  )? onGraphQLError;

  /// Обратный вызов на любую внутреннюю ошибку линка
  final FutureOr<void> Function(
    Request request,
    Response? response,
    Object exception,
    StackTrace stackTrace,
  )? onLinkException;

  @override
  Future<Request> onRequest(Request request) {
    String getOperationType() {
      if (request.isQuery) {
        return 'query';
      } else if (request.isMutation) {
        return 'mutation';
      } else if (request.isSubscription) {
        return 'subscription';
      } else {
        return 'unknown';
      }
    }

    final operationType = getOperationType();
    final operation = request.operation.operationName ?? 'graphql_$operationType';
    final transaction = Sentry.startTransaction(
      'graphql_request',
      operation,
      description: 'GraphQL request: "$operation"',
      bindToScope: true,
      autoFinishAfter: const Duration(seconds: 120),
    )
      ..setTag('type', operationType)
      ..setTag('operation', operation);
    return super.onRequest(
      request.withContextEntry<_SentryTransactionContext>(
        _SentryTransactionContext(
          transaction: transaction,
        ),
      ),
    );
  }

  @override
  Future<Response> onResponse(
    Request request,
    Response response,
  ) async {
    final errors = response.errors;
    final callback = onGraphQLError;
    final context = _getTransactionContext(request, response);
    if (errors != null && errors.isNotEmpty) {
      if (callback != null) {
        await callback(request, response);
      }
      if (context != null) {
        context.transaction
          ..setTag('successfully', 'false')
          ..setData(
            'errors',
            errors.map<String>((e) => e.message.length > 100 ? e.message.substring(0, 100) : e.message).join(','),
          );
      }
    }
    return super.onResponse(request, response);
  }

  @override
  Future<void> onError(
    Request request,
    Response? response,
    Object error,
    StackTrace stackTrace,
  ) async {
    try {
      final callback = onLinkException;
      final context = _getTransactionContext(request, response);
      if (context != null) {
        context.transaction
          ..setTag('successfully', 'false')
          ..setData('errors', error.toString())
          ..setData(
            'stack_trace',
            stackTrace.toString(),
          );
      }
      if (callback != null) {
        await callback(request, response, error, stackTrace);
      }
    } on Object catch (error, stackTrace) {
      l.e('Ошибка вызова onLinkException в ExceptionLink: $error', stackTrace);
    }
    return super.onError(request, response, error, stackTrace);
  }

  @override
  void onDone(Request request, Response? response) {
    try {
      final context = _getTransactionContext(request, response);
      if (context != null && !context.transaction.finished) {
        _finishTransaction(context.transaction, response);
      }
    } on Object catch (error, stackTrace) {
      l.e('Ошибка вызова onDone в ExceptionLink: $error', stackTrace);
    }
  }

  void _finishTransaction(ISentrySpan transaction, Response? response) {
    if (transaction.finished) return;

    final httpRsp = response?.context.entry<HttpResponseContext>()?.response;
    if (httpRsp != null) {
      final statusCode = httpRsp.statusCode;
      transaction
        ..setTag('status_code', statusCode.toString())
        ..setData('status_code', statusCode.toString());
      if (statusCode > 299) {
        transaction
          ..setData('headers', jsonEncode(httpRsp.headers))
          ..setData('body', httpRsp.body);
        final reasonPhrase = httpRsp.reasonPhrase;
        if (reasonPhrase != null) {
          transaction.setData('reason_phrase', reasonPhrase);
        }
      }
    }

    final errors = response?.errors;
    if (errors?.isEmpty ?? true) {
      transaction
        ..setTag('successfully', 'true')
        ..finish(status: const SpanStatus.ok());
      return;
    }

    transaction.setTag('successfully', 'false');
    if (response == null) {
      transaction.finish(status: const SpanStatus.unknownError());
      return;
    }

    if (errors != null && errors.isNotEmpty) {
      if (_hasErrorCodes(errors, ['UNAUTHENTICATED'])) {
        transaction.finish(status: const SpanStatus.unauthenticated());
        return;
      } else if (_hasErrorCodes(errors, ['BADREQUEST'])) {
        transaction.finish(status: const SpanStatus.notFound());
        return;
      } else if (_hasErrorCodes(errors, ['INTERNAL'])) {
        transaction.finish(status: const SpanStatus.internalError());
        return;
      } else if (_hasErrorCodes(errors, ['TIMEOUT'])) {
        transaction.finish(status: const SpanStatus.deadlineExceeded());
        return;
      } else {
        transaction.finish(status: const SpanStatus.aborted());
      }
    } else {
      transaction.finish(status: const SpanStatus.unknown());
      return;
    }
  }

  bool _hasErrorCodes(List<GraphQLError> errors, List<String> codes) => errors.any(
        (e) {
          for (final code in codes) {
            if (e.extensions?.containsKey(code) ?? false) {
              return true;
            }
          }
          return false;
        },
      );

  _SentryTransactionContext? _getTransactionContext(Request request, [Response? response]) =>
      response?.context.entry<_SentryTransactionContext>() ?? request.context.entry<_SentryTransactionContext>();
}

@immutable
class _SentryTransactionContext extends ContextEntry {
  const _SentryTransactionContext({
    required final this.transaction,
  });

  final ISentrySpan transaction;

  @override
  List<Object> get fieldsForEquality => <Object>[
        transaction,
      ];
}
