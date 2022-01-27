import 'dart:async';

import 'package:dart_jobs_shared/graphql.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

class PerformanceLink extends InterceptorLink {
  final FirebasePerformance performance;

  PerformanceLink({
    required this.performance,
  });

  @override
  Future<Request> onRequest(Request request) => _startTrace(request);

  @override
  Future<void> onDone(
    Request request,
    Response? response,
  ) async {
    try {
      final context = response?.context.entry<_PerformanceContext>() ?? request.context.entry<_PerformanceContext>();
      if (context == null) return;

      final httpResponseContextEntry = response?.context.entry<HttpResponseContext>();
      final httpResponse = httpResponseContextEntry?.response;

      context.metric
        ..requestPayloadSize = httpResponse?.request?.contentLength ?? 0
        ..responsePayloadSize = httpResponse?.contentLength ?? 0
        ..httpResponseCode = httpResponse?.statusCode
        ..responseContentType = httpResponse?.headers['content-type'] ?? 'application/json';

      await context.trace.stop();
      await context.metric.stop();
    } on Object catch (error, stackTrace) {
      l.w(
        'Исключение остановки мониторинга производительности запроса "${request.operation.operationName}": $error',
        stackTrace,
      );
    }
  }

  Future<Request> _startTrace(Request request) async {
    try {
      /// Позволяет  установить начало и конец пользовательской трассировки
      final trace = performance.newTrace('GraphQL_${request.operation.operationName}_trace');

      /// Позволяет установить метрику для отслеживания скорости запросов
      final metric = performance.newHttpMetric('GraphQL_${request.operation.operationName}_metric', HttpMethod.Post)
        //по дефолту ставим в 0, тк на этом этапе не знаем эти значения
        ..requestPayloadSize = 0
        //по дефолту ставим в 0, тк на этом этапе не знаем эти значения
        ..responsePayloadSize = 0;

      await trace.start();
      await metric.start();
      trace.incrementMetric(
        'response_count',
        1,
      );
      return request.withContextEntry<_PerformanceContext>(
        _PerformanceContext(
          trace: trace,
          metric: metric,
        ),
      );
    } on Object catch (error, stackTrace) {
      l.w(
        'Исключение запуска мониторинга производительности запроса "${request.operation.operationName}": $error',
        stackTrace,
      );
      return request;
    }
  }
}

@immutable
class _PerformanceContext extends ContextEntry {
  const _PerformanceContext({
    required final this.trace,
    required final this.metric,
  });

  final Trace trace;
  final HttpMetric metric;

  @override
  List<Object> get fieldsForEquality => <Object>[
        trace,
        metric,
      ];
}
