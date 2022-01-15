import 'package:artemis/artemis.dart' show GraphQLQuery, GraphQLResponse;
import 'package:gql_exec/gql_exec.dart' show Context, Operation, Request;
import 'package:gql_link/gql_link.dart' show Link;
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:meta/meta.dart' show immutable;

@immutable
class GQLClient {
  const GQLClient(final Link link) : _link = link;

  final Link _link;

  /// Executes a [GraphQLQuery], returning a typed response.
  /// [T] - результат ответа
  /// [U] - переменные
  Future<GraphQLResponse<T>> execute<T, U extends JsonSerializable>(
    GraphQLQuery<T, U> query, {
    Context context = const Context(),
  }) async {
    final request = Request(
      operation: Operation(
        document: query.document,
        operationName: query.operationName,
      ),
      variables: query.getVariablesMap(),
      context: context,
    );
    final response = await _link.request(request).first;
    return GraphQLResponse<T>(
      data: response.data == null ? null : query.parse(response.data ?? <String, Object?>{}),
      errors: response.errors,
      context: response.context,
    );
  }

  /// Streams a [GraphQLQuery], returning a typed response stream.
  /// [T] - результат ответа
  /// [U] - переменные
  Stream<GraphQLResponse<T>> stream<T, U extends JsonSerializable>(
    GraphQLQuery<T, U> query, {
    Context context = const Context(),
  }) {
    final request = Request(
      operation: Operation(
        document: query.document,
        operationName: query.operationName,
      ),
      variables: query.getVariablesMap(),
      context: context,
    );
    return _link.request(request).map<GraphQLResponse<T>>(
          (response) => GraphQLResponse<T>(
            data: response.data == null ? null : query.parse(response.data ?? <String, Object?>{}),
            errors: response.errors,
            context: response.context,
          ),
        );
  }
}
