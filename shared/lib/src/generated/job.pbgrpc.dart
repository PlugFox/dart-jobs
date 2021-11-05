///
//  Generated code. Do not modify.
//  source: job.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:async' as $async;

import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'job.pb.dart' as $0;
import 'common.pb.dart' as $1;
export 'job.pb.dart';

class JobServiceClient extends $grpc.Client {
  static final _$listenRecent = $grpc.ClientMethod<$0.JobFilter, $0.JobsChunk>('/job.JobService/ListenRecent',
      ($0.JobFilter value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobsChunk.fromBuffer(value));
  static final _$getRecent = $grpc.ClientMethod<$0.JobFilter, $0.JobsChunk>('/job.JobService/GetRecent',
      ($0.JobFilter value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobsChunk.fromBuffer(value));
  static final _$paginate = $grpc.ClientMethod<$0.JobFilter, $0.JobsChunk>('/job.JobService/Paginate',
      ($0.JobFilter value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobsChunk.fromBuffer(value));
  static final _$createJob = $grpc.ClientMethod<$0.JobData, $0.Job>('/job.JobService/CreateJob',
      ($0.JobData value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.Job.fromBuffer(value));
  static final _$getJob = $grpc.ClientMethod<$1.UUID, $0.Job>('/job.JobService/GetJob',
      ($1.UUID value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.Job.fromBuffer(value));
  static final _$updateJob = $grpc.ClientMethod<$0.Job, $0.Job>('/job.JobService/UpdateJob',
      ($0.Job value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.Job.fromBuffer(value));
  static final _$deleteJob = $grpc.ClientMethod<$0.Job, $0.Job>('/job.JobService/DeleteJob',
      ($0.Job value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.Job.fromBuffer(value));

  JobServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.JobsChunk> listenRecent($0.JobFilter request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$listenRecent, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.JobsChunk> getRecent($0.JobFilter request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getRecent, request, options: options);
  }

  $grpc.ResponseFuture<$0.JobsChunk> paginate($0.JobFilter request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$paginate, request, options: options);
  }

  $grpc.ResponseFuture<$0.Job> createJob($0.JobData request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createJob, request, options: options);
  }

  $grpc.ResponseFuture<$0.Job> getJob($1.UUID request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getJob, request, options: options);
  }

  $grpc.ResponseFuture<$0.Job> updateJob($0.Job request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateJob, request, options: options);
  }

  $grpc.ResponseFuture<$0.Job> deleteJob($0.Job request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteJob, request, options: options);
  }
}

abstract class JobServiceBase extends $grpc.Service {
  $core.String get $name => 'job.JobService';

  JobServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.JobFilter, $0.JobsChunk>(
        'ListenRecent',
        listenRecent_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.JobFilter.fromBuffer(value),
        ($0.JobsChunk value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JobFilter, $0.JobsChunk>(
        'GetRecent',
        getRecent_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JobFilter.fromBuffer(value),
        ($0.JobsChunk value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JobFilter, $0.JobsChunk>(
        'Paginate',
        paginate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JobFilter.fromBuffer(value),
        ($0.JobsChunk value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JobData, $0.Job>('CreateJob', createJob_Pre, false, false,
        ($core.List<$core.int> value) => $0.JobData.fromBuffer(value), ($0.Job value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.UUID, $0.Job>('GetJob', getJob_Pre, false, false,
        ($core.List<$core.int> value) => $1.UUID.fromBuffer(value), ($0.Job value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Job, $0.Job>('UpdateJob', updateJob_Pre, false, false,
        ($core.List<$core.int> value) => $0.Job.fromBuffer(value), ($0.Job value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Job, $0.Job>('DeleteJob', deleteJob_Pre, false, false,
        ($core.List<$core.int> value) => $0.Job.fromBuffer(value), ($0.Job value) => value.writeToBuffer()));
  }

  $async.Stream<$0.JobsChunk> listenRecent_Pre($grpc.ServiceCall call, $async.Future<$0.JobFilter> request) async* {
    yield* listenRecent(call, await request);
  }

  $async.Future<$0.JobsChunk> getRecent_Pre($grpc.ServiceCall call, $async.Future<$0.JobFilter> request) async {
    return getRecent(call, await request);
  }

  $async.Future<$0.JobsChunk> paginate_Pre($grpc.ServiceCall call, $async.Future<$0.JobFilter> request) async {
    return paginate(call, await request);
  }

  $async.Future<$0.Job> createJob_Pre($grpc.ServiceCall call, $async.Future<$0.JobData> request) async {
    return createJob(call, await request);
  }

  $async.Future<$0.Job> getJob_Pre($grpc.ServiceCall call, $async.Future<$1.UUID> request) async {
    return getJob(call, await request);
  }

  $async.Future<$0.Job> updateJob_Pre($grpc.ServiceCall call, $async.Future<$0.Job> request) async {
    return updateJob(call, await request);
  }

  $async.Future<$0.Job> deleteJob_Pre($grpc.ServiceCall call, $async.Future<$0.Job> request) async {
    return deleteJob(call, await request);
  }

  $async.Stream<$0.JobsChunk> listenRecent($grpc.ServiceCall call, $0.JobFilter request);
  $async.Future<$0.JobsChunk> getRecent($grpc.ServiceCall call, $0.JobFilter request);
  $async.Future<$0.JobsChunk> paginate($grpc.ServiceCall call, $0.JobFilter request);
  $async.Future<$0.Job> createJob($grpc.ServiceCall call, $0.JobData request);
  $async.Future<$0.Job> getJob($grpc.ServiceCall call, $1.UUID request);
  $async.Future<$0.Job> updateJob($grpc.ServiceCall call, $0.Job request);
  $async.Future<$0.Job> deleteJob($grpc.ServiceCall call, $0.Job request);
}
