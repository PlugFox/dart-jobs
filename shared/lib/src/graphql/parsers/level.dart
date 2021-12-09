import 'package:dart_jobs_shared/model.dart';
import 'package:dart_jobs_shared/util.dart';

/* DeveloperLevel <-> level */

DeveloperLevel fromGraphQLlevelToDartDeveloperLevel(String level) => DeveloperLevel.fromName(level);

String fromDartDeveloperLevelToGraphQLlevel(DeveloperLevel level) => level.name;

DeveloperLevel? fromGraphQLlevelNullableToDartDeveloperLevelNullable(String? level) =>
    level.nullOr(DeveloperLevel.fromName);

String? fromDartDeveloperLevelNullableToGraphQLlevelNullable(DeveloperLevel? level) => level?.name;

/* List<DeveloperLevel> <-> _level */

List<DeveloperLevel> fromGraphQL$levelToDartListDeveloperLevel(String levels) =>
    GraphQLArray.toDart<DeveloperLevel>(levels, DeveloperLevel.fromName).toList();

String fromDartListDeveloperLevelToGraphQL$level(List<DeveloperLevel> levels) =>
    GraphQLArray.toGraphQL<DeveloperLevel>(levels, (e) => e.name);

List<DeveloperLevel>? fromGraphQL$levelNullableToDartListDeveloperLevelNullable(String? levels) =>
    levels.nullOr(fromGraphQL$levelToDartListDeveloperLevel);

String? fromDartListDeveloperLevelNullableToGraphQLlevelNullable(List<DeveloperLevel>? levels) =>
    levels.nullOr(fromDartListDeveloperLevelToGraphQL$level);
