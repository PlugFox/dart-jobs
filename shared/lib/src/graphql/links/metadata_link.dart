import 'dart:async';

import 'package:dart_jobs_shared/src/graphql/links/handler_link.dart';
import 'package:dart_jobs_shared/src/graphql/links/interceptor_link.dart';

/// Линк отвечающий за установку метаданных в заголовки запросов GraphQL
/// [metadata] - дополнительные метаданные, которыми нужно сопровождать каждый запрос
class MetadataLink extends InterceptorLink {
  final Map<String, String>? metadata;

  MetadataLink({this.metadata});

  @override
  Future<Request> onRequest(Request request) => super.onRequest(
        request.updateContextEntry<HttpLinkHeaders>(
          (entry) {
            // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
            final linkHeaders = entry ?? HttpLinkHeaders(headers: <String, String>{});
            return linkHeaders
              ..headers.addAll(
                <String, String>{
                  'Meta-Device-Timestamp': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
                  ...?metadata,
                },
              );
          },
        ),
      );
}
