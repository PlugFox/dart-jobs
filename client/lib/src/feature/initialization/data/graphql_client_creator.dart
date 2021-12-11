import 'package:dart_jobs_client/src/common/constant/environment.dart';
import 'package:dart_jobs_shared/graphql.dart';

abstract class GraphQLClientCreator {
  GraphQLClientCreator._();

  static GQLClient create() => GQLClient(_getLinks());

  static Link _getLinks() {
    final links = <Link>[];

    final dedupeLink = DedupeLink();
    links.add(dedupeLink);

    /// TODO: ExceptionLink with Sentry

    /// TODO: Cache Link

    /// TODO: Log link

    /// TODO: Auth Link

    /// TODO: заменить на собственный хендлер линк
    /// берущий URL из переменных окружения, RemoteConfig, LocalStorage
    final httpLink = HttpLink(
      kGraphQLEndpoint,
    );
    links.add(httpLink);

    return Link.from(
      links,
    );
  }
}
