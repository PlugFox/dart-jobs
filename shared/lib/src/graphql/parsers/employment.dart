import 'package:dart_jobs_shared/model.dart';
import 'package:dart_jobs_shared/util.dart';

/* Employment <-> employment */

Employment fromGraphQLemploymentToDartEmployment(String employment) => Employment.fromName(employment);

String fromDartEmploymentToGraphQLemployment(Employment employment) => employment.name;

Employment? fromGraphQLEmploymentNullableToDartEmploymentNullable(String? employment) =>
    employment.nullOr(Employment.fromName);

String? fromDartEmploymentNullableToGraphQLEmploymentNullable(Employment? employment) => employment?.name;

/* List<Employment> <-> _employment */

List<Employment> fromGraphQL$employmentToDartListEmployment(Object employments) =>
    GraphQLArray.toDart<Employment>(employments, Employment.fromName).toList();

String fromDartListEmploymentToGraphQL$employment(List<Employment> employments) =>
    GraphQLArray.toGraphQL<Employment>(employments, (e) => e.name);

List<Employment>? fromGraphQL$employmentNullableToDartListNullableEmployment(Object? employments) =>
    employments.nullOr(fromGraphQL$employmentToDartListEmployment);

String? fromDartListNullableEmploymentToGraphQL$employmentNullable(List<Employment>? employments) =>
    employments.nullOr(fromDartListEmploymentToGraphQL$employment);
