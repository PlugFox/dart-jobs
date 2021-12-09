import 'package:dart_jobs_shared/model.dart';
import 'package:dart_jobs_shared/util.dart';

/* Employment <-> employment */

Employment fromGraphQLemploymentToDartEmployment(String employment) => Employment.fromName(employment);

String fromDartEmploymentToGraphQLemployment(Employment employment) => employment.name;

Employment? fromGraphQLemploymentNullableToDartEmploymentNullable(String? employment) =>
    employment.nullOr(Employment.fromName);

String? fromDartEmploymentNullableToGraphQLemploymentNullable(Employment? employment) => employment?.name;

/* List<Employment> <-> _employment */

List<Employment> fromGraphQL$employmentToDartListEmployment(String employments) =>
    GraphQLArray.toDart<Employment>(employments, Employment.fromName).toList();

String fromDartListEmploymentToGraphQL$employment(List<Employment> employments) =>
    GraphQLArray.toGraphQL<Employment>(employments, (e) => e.name);

List<Employment>? fromGraphQL$employmentNullableToDartListEmploymentNullable(String? employments) =>
    employments.nullOr(fromGraphQL$employmentToDartListEmployment);

String? fromDartListEmploymentNullableToGraphQLemploymentNullable(List<Employment>? employments) =>
    employments.nullOr(fromDartListEmploymentToGraphQL$employment);
