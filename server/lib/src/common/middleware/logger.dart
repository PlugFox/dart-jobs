// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:l/l.dart';
import 'package:shelf/shelf.dart';
import 'package:stack_trace/stack_trace.dart';

/// Middleware which prints the time of the request, the elapsed time for the
/// inner handlers, the response's status code and the request URI.
///
/// If [logger] is passed, it's called for each request. The `msg` parameter is
/// a formatted string that includes the request time, duration, request method,
/// and requested path. When an exception is thrown, it also includes the
/// exception's string and stack trace; otherwise, it includes the status code.
/// The `isError` parameter indicates whether the message is caused by an error.
///
/// If [logger] is not passed, the message is just passed to [print].
Middleware logMiddleware({void Function(String message, bool isError)? logger}) => (innerHandler) {
      final theLogger = logger ?? _defaultLogger;
      return (request) {
        final startTime = DateTime.now();
        final watch = Stopwatch()..start();
        return Future<Response>.sync(() => innerHandler(request)).then<Response>(
          (response) {
            final msg = _message(startTime, response.statusCode, request.requestedUri, request.method, watch.elapsed);
            // Не логируем успешные хелсчеки
            if (!response.headers.containsKey('X-Health-Check')) {
              theLogger(msg, false);
            }
            return response;
          },
          onError: (Object error, StackTrace stackTrace) {
            if (error is HijackException) {
              throw error;
            }
            final msg = _errorMessage(
              startTime,
              request.requestedUri,
              request.method,
              watch.elapsed,
              error,
              stackTrace,
            );
            theLogger(msg, true);
            // ignore: only_throw_errors
            throw error;
          },
        );
      };
    };

String _formatQuery(String query) => query.isEmpty ? '' : '?$query';

String _message(DateTime requestTime, int statusCode, Uri requestedUri, String method, Duration elapsedTime) =>
    '${requestTime.toIso8601String()} '
    '${elapsedTime.toString().padLeft(15)} '
    '${method.padRight(7)} [$statusCode] ' // 7 - longest standard HTTP method
    '${requestedUri.path}${_formatQuery(requestedUri.query)}';

String _errorMessage(
    DateTime requestTime, Uri requestedUri, String method, Duration elapsedTime, Object error, StackTrace? stack) {
  var chain = Chain.current();
  if (stack != null) {
    chain = Chain.forTrace(stack).foldFrames((frame) => frame.isCore || frame.package == 'shelf').terse;
  }

  final msg = '$requestTime\t$elapsedTime\t$method\t${requestedUri.path}'
      '${_formatQuery(requestedUri.query)}\n$error';

  return '$msg\n$chain';
}

void _defaultLogger(String msg, bool isError) {
  if (isError) {
    l.e('[ERROR] $msg');
  } else {
    l.v6(msg);
  }
}
