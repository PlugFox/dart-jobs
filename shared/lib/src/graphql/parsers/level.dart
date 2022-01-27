import 'package:dart_jobs_shared/model.dart';
import 'package:dart_jobs_shared/util.dart';

/* DeveloperLevel <-> level */

DeveloperLevel fromGraphQLlevelToDartDeveloperLevel(String level) => DeveloperLevel.fromName(level);

String fromDartDeveloperLevelToGraphQLlevel(DeveloperLevel level) => level.name;

DeveloperLevel? fromGraphQLLevelNullableToDartDeveloperLevelNullable(String? level) =>
    level.nullOr(DeveloperLevel.fromName);

String? fromDartDeveloperLevelNullableToGraphQLLevelNullable(DeveloperLevel? level) => level?.name;

/* List<DeveloperLevel> <-> _level */

List<DeveloperLevel> fromGraphQL$levelToDartListDeveloperLevel(Object levels) =>
    GraphQLArray.toDart<DeveloperLevel>(levels, DeveloperLevel.fromName).toList();

String fromDartListDeveloperLevelToGraphQL$level(List<DeveloperLevel> levels) =>
    GraphQLArray.toGraphQL<DeveloperLevel>(levels, (e) => e.name);

List<DeveloperLevel>? fromGraphQL$levelNullableToDartListNullableDeveloperLevel(Object? levels) =>
    levels.nullOr(fromGraphQL$levelToDartListDeveloperLevel);

String? fromDartListNullableDeveloperLevelToGraphQL$levelNullable(List<DeveloperLevel>? levels) =>
    levels.nullOr(fromDartListDeveloperLevelToGraphQL$level);
