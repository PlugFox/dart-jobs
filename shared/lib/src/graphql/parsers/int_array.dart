import 'package:dart_jobs_shared/util.dart';

/* List<DeveloperLevel> <-> _level */

List<int> fromGraphQL$int4ToDartListint(Object ints) => GraphQLArray.toDart<int>(ints, int.parse).toList();

String fromDartListintToGraphQL$int4(List<int> ints) => GraphQLArray.toGraphQL<int>(ints, (i) => i.toString());
