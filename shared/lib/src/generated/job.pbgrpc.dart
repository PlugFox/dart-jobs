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
import 'google/protobuf/wrappers.pb.dart' as $1;
export 'job.pb.dart';

class JobServiceClient extends $grpc.Client {
  static final _$getRecent = $grpc.ClientMethod<$0.JobFilter, $0.JobChanges>('/job.JobService/GetRecent',
      ($0.JobFilter value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobChanges.fromBuffer(value));
  static final _$paginate = $grpc.ClientMethod<$0.JobFilter, $0.JobChanges>('/job.JobService/Paginate',
      ($0.JobFilter value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobChanges.fromBuffer(value));
  static final _$createJob = $grpc.ClientMethod<$0.JobData, $0.JobChange>('/job.JobService/CreateJob',
      ($0.JobData value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobChange.fromBuffer(value));
  static final _$getJob = $grpc.ClientMethod<$1.StringValue, $0.JobChange>('/job.JobService/GetJob',
      ($1.StringValue value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobChange.fromBuffer(value));
  static final _$updateJob = $grpc.ClientMethod<$0.Job, $0.JobChange>('/job.JobService/UpdateJob',
      ($0.Job value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobChange.fromBuffer(value));
  static final _$deleteJob = $grpc.ClientMethod<$0.Job, $0.JobChange>('/job.JobService/DeleteJob',
      ($0.Job value) => value.writeToBuffer(), ($core.List<$core.int> value) => $0.JobChange.fromBuffer(value));

  JobServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options, $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options, interceptors: interceptors);

  $grpc.ResponseStream<$0.JobChanges> getRecent($0.JobFilter request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$getRecent, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.JobChanges> paginate($0.JobFilter request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$paginate, request, options: options);
  }

  $grpc.ResponseFuture<$0.JobChange> createJob($0.JobData request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$createJob, request, options: options);
  }

  $grpc.ResponseFuture<$0.JobChange> getJob($1.StringValue request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$getJob, request, options: options);
  }

  $grpc.ResponseFuture<$0.JobChange> updateJob($0.Job request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateJob, request, options: options);
  }

  $grpc.ResponseFuture<$0.JobChange> deleteJob($0.Job request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteJob, request, options: options);
  }
}

abstract class JobServiceBase extends $grpc.Service {
  $core.String get $name => 'job.JobService';

  JobServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.JobFilter, $0.JobChanges>(
        'GetRecent',
        getRecent_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.JobFilter.fromBuffer(value),
        ($0.JobChanges value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JobFilter, $0.JobChanges>(
        'Paginate',
        paginate_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.JobFilter.fromBuffer(value),
        ($0.JobChanges value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.JobData, $0.JobChange>('CreateJob', createJob_Pre, false, false,
        ($core.List<$core.int> value) => $0.JobData.fromBuffer(value), ($0.JobChange value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$1.StringValue, $0.JobChange>(
        'GetJob',
        getJob_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $1.StringValue.fromBuffer(value),
        ($0.JobChange value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Job, $0.JobChange>('UpdateJob', updateJob_Pre, false, false,
        ($core.List<$core.int> value) => $0.Job.fromBuffer(value), ($0.JobChange value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.Job, $0.JobChange>('DeleteJob', deleteJob_Pre, false, false,
        ($core.List<$core.int> value) => $0.Job.fromBuffer(value), ($0.JobChange value) => value.writeToBuffer()));
  }

  $async.Stream<$0.JobChanges> getRecent_Pre($grpc.ServiceCall call, $async.Future<$0.JobFilter> request) async* {
    yield* getRecent(call, await request);
  }

  $async.Future<$0.JobChanges> paginate_Pre($grpc.ServiceCall call, $async.Future<$0.JobFilter> request) async {
    return paginate(call, await request);
  }

  $async.Future<$0.JobChange> createJob_Pre($grpc.ServiceCall call, $async.Future<$0.JobData> request) async {
    return createJob(call, await request);
  }

  $async.Future<$0.JobChange> getJob_Pre($grpc.ServiceCall call, $async.Future<$1.StringValue> request) async {
    return getJob(call, await request);
  }

  $async.Future<$0.JobChange> updateJob_Pre($grpc.ServiceCall call, $async.Future<$0.Job> request) async {
    return updateJob(call, await request);
  }

  $async.Future<$0.JobChange> deleteJob_Pre($grpc.ServiceCall call, $async.Future<$0.Job> request) async {
    return deleteJob(call, await request);
  }

  $async.Stream<$0.JobChanges> getRecent($grpc.ServiceCall call, $0.JobFilter request);
  $async.Future<$0.JobChanges> paginate($grpc.ServiceCall call, $0.JobFilter request);
  $async.Future<$0.JobChange> createJob($grpc.ServiceCall call, $0.JobData request);
  $async.Future<$0.JobChange> getJob($grpc.ServiceCall call, $1.StringValue request);
  $async.Future<$0.JobChange> updateJob($grpc.ServiceCall call, $0.Job request);
  $async.Future<$0.JobChange> deleteJob($grpc.ServiceCall call, $0.Job request);
}
