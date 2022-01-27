import 'package:dart_jobs_client/src/common/constant/environment.dart';
import 'package:dart_jobs_client/src/common/utils/error_util.dart';
import 'package:dart_jobs_shared/graphql.dart';

abstract class GraphQLClientCreator {
  GraphQLClientCreator._();

  static GQLClient create() => GQLClient(_getLinks());

  static Link _getLinks() {
    final links = <Link>[];

    /// Exception link with logging
    final exceptionLink = ExceptionLink(
      onGraphQLError: ErrorUtil.logGraphQLError,
      onLinkException: ErrorUtil.logLinkException,
    );
    links.add(exceptionLink);

    /// Dedupe link
    final dedupeLink = DedupeLink();
    links.add(dedupeLink);

    /// Performance link
    /// https://github.com/FirebaseExtended/flutterfire/issues/6140
    //final performanceLink = PerformanceLink(performance: FirebasePerformance.instance);
    //links.add(performanceLink);

    /// Metadata link
    final metadataLink = MetadataLink(metadata: <String, String>{});
    links.add(metadataLink);

    /// TODO: Cache Link

    /// TODO: Log link

    /// Handler
    final handlerLink = HandlerLink(kGraphQLEndpoint);
    links.add(handlerLink);

    return Link.from(
      links,
    );
  }
}
