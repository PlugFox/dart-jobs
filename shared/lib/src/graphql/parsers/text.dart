import 'package:dart_jobs_shared/util.dart';

/* String <-> text */

String fromGraphQLtextToDartString(String text) => text;

String fromDartStringToGraphQLtext(String string) => string;

String? fromGraphQLtextNullableToDartStringNullable(String? text) => text;

String? fromDartStringNullableToGraphQLtextNullable(String? string) => string;

/* List<String> <-> _text */

List<String> fromGraphQL$textToDartListString(String texts) => GraphQLArray.toDart<String>(texts, (e) => e).toList();

String fromDartListStringToGraphQL$text(List<String> strings) => GraphQLArray.toGraphQL<String>(strings, (e) => e);

List<String>? fromGraphQL$textNullableToDartListStringNullable(String? texts) =>
    texts.nullOr(fromGraphQL$textToDartListString);

String? fromDartListStringNullableToGraphQLtextNullable(List<String>? strings) =>
    strings.nullOr(fromDartListStringToGraphQL$text);
