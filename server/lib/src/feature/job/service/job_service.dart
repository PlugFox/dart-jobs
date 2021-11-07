import 'package:dart_jobs_shared/grpc.dart' as grpc;
import 'package:dart_jobs_shared/models.dart';
import 'package:grpc/grpc.dart';

class JobService extends grpc.JobServiceBase {
  JobService();

  @override
  Future<grpc.JobsChunk> getRecent(ServiceCall call, grpc.JobFilter request) => Future<grpc.JobsChunk>.value(
        JobsChunk(
          endOfList: true,
          jobs: Iterable<Job>.generate(
            3,
            (i) => Job(
              id: (request.after.toDateTime().millisecondsSinceEpoch ~/ 1000 - i * 60).toRadixString(36),
              //weight: request.after.toDateTime().millisecondsSinceEpoch ~/ 1000,
              updated: request.after.toDateTime().add(const Duration(seconds: 1)),
              created: request.after.toDateTime().add(const Duration(minutes: 1)),
              creatorId: call.clientMetadata?['Authorization']?.toString() ?? '',
              data: const JobData(),
            ),
          ).toList(),
        ).toProtobuf(),
      );

  @override
  Future<grpc.JobsChunk> paginate(ServiceCall call, grpc.JobFilter request) => Future<grpc.JobsChunk>.value(
        JobsChunk(
          endOfList: false,
          jobs: Iterable<Job>.generate(
            request.limit,
            (i) => Job(
              id: (request.before.toDateTime().millisecondsSinceEpoch ~/ 1000 - i * 60).toRadixString(36),
              //weight: request.before.toDateTime().millisecondsSinceEpoch ~/ 1000,
              updated: request.before.toDateTime().subtract(const Duration(minutes: 1)),
              created: request.before.toDateTime().subtract(const Duration(minutes: 1)),
              creatorId: call.clientMetadata?['Authorization']?.toString() ?? '',
              data: const JobData(),
            ),
          ).toList(),
        ).toProtobuf(),
      );

  /// TODO: verifyToken
  /// https://firebase.google.com/docs/auth/admin/verify-id-tokens#verify_id_tokens_using_a_third-party_jwt_library
  @override
  Future<grpc.Job> createJob(ServiceCall call, grpc.JobData request) => Future<grpc.Job>.value(
        Job(
          id: (DateTime.now().millisecondsSinceEpoch ~/ 1000).toRadixString(36),
          //weight: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          updated: DateTime.now().toUtc(),
          created: DateTime.now().toUtc(),
          creatorId: call.clientMetadata?['Authorization']?.toString() ?? '',
          data: const JobData(),
        ).toProtobuf()
          ..data = request,
      );

  @override
  Future<grpc.Job> getJob(ServiceCall call, grpc.UUID request) => Future<grpc.Job>.value(
        Job(
          id: request.uuid,
          //weight: DateTime.now().millisecondsSinceEpoch ~/ 1000,
          updated: DateTime.now().toUtc(),
          created: DateTime.now().toUtc(),
          creatorId: call.clientMetadata?['Authorization']?.toString() ?? '',
          data: const JobData(),
        ).toProtobuf(),
      );

  /// TODO: verifyToken
  /// https://firebase.google.com/docs/auth/admin/verify-id-tokens#verify_id_tokens_using_a_third-party_jwt_library
  @override
  Future<grpc.Job> updateJob(ServiceCall call, grpc.Job request) => Future<grpc.Job>.value(
        request
          ..updated = grpc.Timestamp.fromDateTime(
            DateTime.now().toUtc(),
          ),
      );

  /// TODO: verifyToken
  /// https://firebase.google.com/docs/auth/admin/verify-id-tokens#verify_id_tokens_using_a_third-party_jwt_library
  @override
  Future<grpc.Job> deleteJob(ServiceCall call, grpc.Job request) => Future<grpc.Job>.value(
        request..deletionMark = true,
      );
}
