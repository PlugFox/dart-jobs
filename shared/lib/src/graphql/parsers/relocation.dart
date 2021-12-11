import 'package:dart_jobs_shared/model.dart';
import 'package:dart_jobs_shared/util.dart';

/* Relocation <-> relocation */

Relocation fromGraphQLRelocationToDartRelocation(String relocation) => Relocation.fromName(relocation);

String fromDartRelocationToGraphQLRelocation(Relocation relocation) => relocation.name;

Relocation? fromGraphQLRelocationNullableToDartRelocationNullable(String? relocation) =>
    relocation.nullOr(Relocation.fromName);

String? fromDartRelocationNullableToGraphQLRelocationNullable(Relocation? relocation) => relocation?.name;
