///
//  Generated code. Do not modify.
//  source: job.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $2;

import 'job.pbenum.dart';

export 'job.pbenum.dart';

class JobFilter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'JobFilter',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'limit', $pb.PbFieldType.OU3)
    ..aOM<$2.Timestamp>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'before',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'after',
        subBuilder: $2.Timestamp.create)
    ..hasRequiredFields = false;

  JobFilter._() : super();
  factory JobFilter({
    $core.int? limit,
    $2.Timestamp? before,
    $2.Timestamp? after,
  }) {
    final _result = create();
    if (limit != null) {
      _result.limit = limit;
    }
    if (before != null) {
      _result.before = before;
    }
    if (after != null) {
      _result.after = after;
    }
    return _result;
  }
  factory JobFilter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JobFilter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JobFilter clone() => JobFilter()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JobFilter copyWith(void Function(JobFilter) updates) =>
      super.copyWith((message) => updates(message as JobFilter)) as JobFilter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JobFilter create() => JobFilter._();
  JobFilter createEmptyInstance() => create();
  static $pb.PbList<JobFilter> createRepeated() => $pb.PbList<JobFilter>();
  @$core.pragma('dart2js:noInline')
  static JobFilter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JobFilter>(create);
  static JobFilter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get limit => $_getIZ(0);
  @$pb.TagNumber(1)
  set limit($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasLimit() => $_has(0);
  @$pb.TagNumber(1)
  void clearLimit() => clearField(1);

  @$pb.TagNumber(2)
  $2.Timestamp get before => $_getN(1);
  @$pb.TagNumber(2)
  set before($2.Timestamp v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasBefore() => $_has(1);
  @$pb.TagNumber(2)
  void clearBefore() => clearField(2);
  @$pb.TagNumber(2)
  $2.Timestamp ensureBefore() => $_ensure(1);

  @$pb.TagNumber(3)
  $2.Timestamp get after => $_getN(2);
  @$pb.TagNumber(3)
  set after($2.Timestamp v) {
    setField(3, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasAfter() => $_has(2);
  @$pb.TagNumber(3)
  void clearAfter() => clearField(3);
  @$pb.TagNumber(3)
  $2.Timestamp ensureAfter() => $_ensure(2);
}

class JobChanges extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'JobChanges',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endOfList', protoName: 'endOfList')
    ..pc<JobChange>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'list', $pb.PbFieldType.PM,
        subBuilder: JobChange.create)
    ..hasRequiredFields = false;

  JobChanges._() : super();
  factory JobChanges({
    $core.bool? endOfList,
    $core.Iterable<JobChange>? list,
  }) {
    final _result = create();
    if (endOfList != null) {
      _result.endOfList = endOfList;
    }
    if (list != null) {
      _result.list.addAll(list);
    }
    return _result;
  }
  factory JobChanges.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JobChanges.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JobChanges clone() => JobChanges()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JobChanges copyWith(void Function(JobChanges) updates) =>
      super.copyWith((message) => updates(message as JobChanges)) as JobChanges; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JobChanges create() => JobChanges._();
  JobChanges createEmptyInstance() => create();
  static $pb.PbList<JobChanges> createRepeated() => $pb.PbList<JobChanges>();
  @$core.pragma('dart2js:noInline')
  static JobChanges getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JobChanges>(create);
  static JobChanges? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get endOfList => $_getBF(0);
  @$pb.TagNumber(1)
  set endOfList($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasEndOfList() => $_has(0);
  @$pb.TagNumber(1)
  void clearEndOfList() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<JobChange> get list => $_getList(1);
}

class JobChange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'JobChange',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'exists')
    ..aOM<Job>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'job', subBuilder: Job.create)
    ..hasRequiredFields = false;

  JobChange._() : super();
  factory JobChange({
    $core.bool? exists,
    Job? job,
  }) {
    final _result = create();
    if (exists != null) {
      _result.exists = exists;
    }
    if (job != null) {
      _result.job = job;
    }
    return _result;
  }
  factory JobChange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JobChange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JobChange clone() => JobChange()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JobChange copyWith(void Function(JobChange) updates) =>
      super.copyWith((message) => updates(message as JobChange)) as JobChange; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JobChange create() => JobChange._();
  JobChange createEmptyInstance() => create();
  static $pb.PbList<JobChange> createRepeated() => $pb.PbList<JobChange>();
  @$core.pragma('dart2js:noInline')
  static JobChange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JobChange>(create);
  static JobChange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get exists => $_getBF(0);
  @$pb.TagNumber(1)
  set exists($core.bool v) {
    $_setBool(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasExists() => $_has(0);
  @$pb.TagNumber(1)
  void clearExists() => clearField(1);

  @$pb.TagNumber(2)
  Job get job => $_getN(1);
  @$pb.TagNumber(2)
  set job(Job v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasJob() => $_has(1);
  @$pb.TagNumber(2)
  void clearJob() => clearField(2);
  @$pb.TagNumber(2)
  Job ensureJob() => $_ensure(1);
}

class Job extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Job',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..a<$fixnum.Int64>(
        1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'weight', $pb.PbFieldType.OU6,
        defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId', protoName: 'creatorId')
    ..aOM<$2.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created',
        subBuilder: $2.Timestamp.create)
    ..aOM<$2.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updated',
        subBuilder: $2.Timestamp.create)
    ..aOM<JobData>(101, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data',
        subBuilder: JobData.create)
    ..hasRequiredFields = false;

  Job._() : super();
  factory Job({
    $fixnum.Int64? weight,
    $core.String? id,
    $core.String? creatorId,
    $2.Timestamp? created,
    $2.Timestamp? updated,
    JobData? data,
  }) {
    final _result = create();
    if (weight != null) {
      _result.weight = weight;
    }
    if (id != null) {
      _result.id = id;
    }
    if (creatorId != null) {
      _result.creatorId = creatorId;
    }
    if (created != null) {
      _result.created = created;
    }
    if (updated != null) {
      _result.updated = updated;
    }
    if (data != null) {
      _result.data = data;
    }
    return _result;
  }
  factory Job.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Job.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Job clone() => Job()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Job copyWith(void Function(Job) updates) =>
      super.copyWith((message) => updates(message as Job)) as Job; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Job create() => Job._();
  Job createEmptyInstance() => create();
  static $pb.PbList<Job> createRepeated() => $pb.PbList<Job>();
  @$core.pragma('dart2js:noInline')
  static Job getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Job>(create);
  static Job? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get weight => $_getI64(0);
  @$pb.TagNumber(1)
  set weight($fixnum.Int64 v) {
    $_setInt64(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasWeight() => $_has(0);
  @$pb.TagNumber(1)
  void clearWeight() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get id => $_getSZ(1);
  @$pb.TagNumber(2)
  set id($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasId() => $_has(1);
  @$pb.TagNumber(2)
  void clearId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get creatorId => $_getSZ(2);
  @$pb.TagNumber(3)
  set creatorId($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCreatorId() => $_has(2);
  @$pb.TagNumber(3)
  void clearCreatorId() => clearField(3);

  @$pb.TagNumber(4)
  $2.Timestamp get created => $_getN(3);
  @$pb.TagNumber(4)
  set created($2.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCreated() => $_has(3);
  @$pb.TagNumber(4)
  void clearCreated() => clearField(4);
  @$pb.TagNumber(4)
  $2.Timestamp ensureCreated() => $_ensure(3);

  @$pb.TagNumber(5)
  $2.Timestamp get updated => $_getN(4);
  @$pb.TagNumber(5)
  set updated($2.Timestamp v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUpdated() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpdated() => clearField(5);
  @$pb.TagNumber(5)
  $2.Timestamp ensureUpdated() => $_ensure(4);

  @$pb.TagNumber(101)
  JobData get data => $_getN(5);
  @$pb.TagNumber(101)
  set data(JobData v) {
    setField(101, v);
  }

  @$pb.TagNumber(101)
  $core.bool hasData() => $_has(5);
  @$pb.TagNumber(101)
  void clearData() => clearField(101);
  @$pb.TagNumber(101)
  JobData ensureData() => $_ensure(5);
}

class JobData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'JobData',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'title')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'company')
    ..aOS(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'country')
    ..aOB(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'remote')
    ..aOS(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'address')
    ..m<$core.String, $core.String>(
        6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'descriptions',
        entryClassName: 'JobData.DescriptionsEntry',
        keyFieldType: $pb.PbFieldType.OS,
        valueFieldType: $pb.PbFieldType.OS,
        packageName: const $pb.PackageName('job'))
    ..pc<DeveloperLevel>(
        7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'levels', $pb.PbFieldType.PE,
        valueOf: DeveloperLevel.valueOf, enumValues: DeveloperLevel.values)
    ..pc<Skill>(8, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'skills', $pb.PbFieldType.PM,
        subBuilder: Skill.create)
    ..pc<Contact>(
        9, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'contacts', $pb.PbFieldType.PM,
        subBuilder: Contact.create)
    ..pc<Employment>(
        10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'employment', $pb.PbFieldType.PE,
        valueOf: Employment.valueOf, enumValues: Employment.values)
    ..pPS(11, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tags')
    ..hasRequiredFields = false;

  JobData._() : super();
  factory JobData({
    $core.String? title,
    $core.String? company,
    $core.String? country,
    $core.bool? remote,
    $core.String? address,
    $core.Map<$core.String, $core.String>? descriptions,
    $core.Iterable<DeveloperLevel>? levels,
    $core.Iterable<Skill>? skills,
    $core.Iterable<Contact>? contacts,
    $core.Iterable<Employment>? employment,
    $core.Iterable<$core.String>? tags,
  }) {
    final _result = create();
    if (title != null) {
      _result.title = title;
    }
    if (company != null) {
      _result.company = company;
    }
    if (country != null) {
      _result.country = country;
    }
    if (remote != null) {
      _result.remote = remote;
    }
    if (address != null) {
      _result.address = address;
    }
    if (descriptions != null) {
      _result.descriptions.addAll(descriptions);
    }
    if (levels != null) {
      _result.levels.addAll(levels);
    }
    if (skills != null) {
      _result.skills.addAll(skills);
    }
    if (contacts != null) {
      _result.contacts.addAll(contacts);
    }
    if (employment != null) {
      _result.employment.addAll(employment);
    }
    if (tags != null) {
      _result.tags.addAll(tags);
    }
    return _result;
  }
  factory JobData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JobData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JobData clone() => JobData()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JobData copyWith(void Function(JobData) updates) =>
      super.copyWith((message) => updates(message as JobData)) as JobData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JobData create() => JobData._();
  JobData createEmptyInstance() => create();
  static $pb.PbList<JobData> createRepeated() => $pb.PbList<JobData>();
  @$core.pragma('dart2js:noInline')
  static JobData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JobData>(create);
  static JobData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get title => $_getSZ(0);
  @$pb.TagNumber(1)
  set title($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasTitle() => $_has(0);
  @$pb.TagNumber(1)
  void clearTitle() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get company => $_getSZ(1);
  @$pb.TagNumber(2)
  set company($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCompany() => $_has(1);
  @$pb.TagNumber(2)
  void clearCompany() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get country => $_getSZ(2);
  @$pb.TagNumber(3)
  set country($core.String v) {
    $_setString(2, v);
  }

  @$pb.TagNumber(3)
  $core.bool hasCountry() => $_has(2);
  @$pb.TagNumber(3)
  void clearCountry() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get remote => $_getBF(3);
  @$pb.TagNumber(4)
  set remote($core.bool v) {
    $_setBool(3, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasRemote() => $_has(3);
  @$pb.TagNumber(4)
  void clearRemote() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get address => $_getSZ(4);
  @$pb.TagNumber(5)
  set address($core.String v) {
    $_setString(4, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasAddress() => $_has(4);
  @$pb.TagNumber(5)
  void clearAddress() => clearField(5);

  @$pb.TagNumber(6)
  $core.Map<$core.String, $core.String> get descriptions => $_getMap(5);

  @$pb.TagNumber(7)
  $core.List<DeveloperLevel> get levels => $_getList(6);

  @$pb.TagNumber(8)
  $core.List<Skill> get skills => $_getList(7);

  @$pb.TagNumber(9)
  $core.List<Contact> get contacts => $_getList(8);

  @$pb.TagNumber(10)
  $core.List<Employment> get employment => $_getList(9);

  @$pb.TagNumber(11)
  $core.List<$core.String> get tags => $_getList(10);
}

class Skill extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Skill',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..aOM<Skill>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type',
        subBuilder: Skill.create)
    ..hasRequiredFields = false;

  Skill._() : super();
  factory Skill({
    $core.String? value,
    Skill? type,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory Skill.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Skill.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Skill clone() => Skill()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Skill copyWith(void Function(Skill) updates) =>
      super.copyWith((message) => updates(message as Skill)) as Skill; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Skill create() => Skill._();
  Skill createEmptyInstance() => create();
  static $pb.PbList<Skill> createRepeated() => $pb.PbList<Skill>();
  @$core.pragma('dart2js:noInline')
  static Skill getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Skill>(create);
  static Skill? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  Skill get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(Skill v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
  @$pb.TagNumber(2)
  Skill ensureType() => $_ensure(1);
}

class Contact extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Contact',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..e<Contact_ContactType>(
        2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: Contact_ContactType.UNKNOWN,
        valueOf: Contact_ContactType.valueOf,
        enumValues: Contact_ContactType.values)
    ..hasRequiredFields = false;

  Contact._() : super();
  factory Contact({
    $core.String? value,
    Contact_ContactType? type,
  }) {
    final _result = create();
    if (value != null) {
      _result.value = value;
    }
    if (type != null) {
      _result.type = type;
    }
    return _result;
  }
  factory Contact.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory Contact.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  Contact clone() => Contact()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  Contact copyWith(void Function(Contact) updates) =>
      super.copyWith((message) => updates(message as Contact)) as Contact; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Contact create() => Contact._();
  Contact createEmptyInstance() => create();
  static $pb.PbList<Contact> createRepeated() => $pb.PbList<Contact>();
  @$core.pragma('dart2js:noInline')
  static Contact getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Contact>(create);
  static Contact? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get value => $_getSZ(0);
  @$pb.TagNumber(1)
  set value($core.String v) {
    $_setString(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasValue() => $_has(0);
  @$pb.TagNumber(1)
  void clearValue() => clearField(1);

  @$pb.TagNumber(2)
  Contact_ContactType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(Contact_ContactType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}
