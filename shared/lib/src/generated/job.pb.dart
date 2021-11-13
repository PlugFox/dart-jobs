///
//  Generated code. Do not modify.
//  source: job.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'google/protobuf/timestamp.pb.dart' as $0;

import 'job.pbenum.dart';

export 'job.pbenum.dart';

class JobsChunk extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'JobsChunk',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..aOB(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'endOfList', protoName: 'endOfList')
    ..pc<Job>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'jobs', $pb.PbFieldType.PM,
        subBuilder: Job.create)
    ..hasRequiredFields = false;

  JobsChunk._() : super();
  factory JobsChunk({
    $core.bool? endOfList,
    $core.Iterable<Job>? jobs,
  }) {
    final _result = create();
    if (endOfList != null) {
      _result.endOfList = endOfList;
    }
    if (jobs != null) {
      _result.jobs.addAll(jobs);
    }
    return _result;
  }
  factory JobsChunk.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromBuffer(i, r);
  factory JobsChunk.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) =>
      create()..mergeFromJson(i, r);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
      'Will be removed in next major version')
  JobsChunk clone() => JobsChunk()..mergeFromMessage(this);
  @$core.Deprecated('Using this can add significant overhead to your binary. '
      'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
      'Will be removed in next major version')
  JobsChunk copyWith(void Function(JobsChunk) updates) =>
      super.copyWith((message) => updates(message as JobsChunk)) as JobsChunk; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static JobsChunk create() => JobsChunk._();
  JobsChunk createEmptyInstance() => create();
  static $pb.PbList<JobsChunk> createRepeated() => $pb.PbList<JobsChunk>();
  @$core.pragma('dart2js:noInline')
  static JobsChunk getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<JobsChunk>(create);
  static JobsChunk? _defaultInstance;

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
  $core.List<Job> get jobs => $_getList(1);
}

class Job extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Job',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id', $pb.PbFieldType.OU3)
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'creatorId', protoName: 'creatorId')
    ..aOM<$0.Timestamp>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created',
        subBuilder: $0.Timestamp.create)
    ..aOM<$0.Timestamp>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'updated',
        subBuilder: $0.Timestamp.create)
    ..aOM<JobData>(101, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'jobData',
        protoName: 'jobData', subBuilder: JobData.create)
    ..aOB(201, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'deletionMark',
        protoName: 'deletionMark')
    ..hasRequiredFields = false;

  Job._() : super();
  factory Job({
    $core.int? id,
    $core.String? creatorId,
    $0.Timestamp? created,
    $0.Timestamp? updated,
    JobData? jobData,
    $core.bool? deletionMark,
  }) {
    final _result = create();
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
    if (jobData != null) {
      _result.jobData = jobData;
    }
    if (deletionMark != null) {
      _result.deletionMark = deletionMark;
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
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) {
    $_setUnsignedInt32(0, v);
  }

  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get creatorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set creatorId($core.String v) {
    $_setString(1, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasCreatorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearCreatorId() => clearField(2);

  @$pb.TagNumber(4)
  $0.Timestamp get created => $_getN(2);
  @$pb.TagNumber(4)
  set created($0.Timestamp v) {
    setField(4, v);
  }

  @$pb.TagNumber(4)
  $core.bool hasCreated() => $_has(2);
  @$pb.TagNumber(4)
  void clearCreated() => clearField(4);
  @$pb.TagNumber(4)
  $0.Timestamp ensureCreated() => $_ensure(2);

  @$pb.TagNumber(5)
  $0.Timestamp get updated => $_getN(3);
  @$pb.TagNumber(5)
  set updated($0.Timestamp v) {
    setField(5, v);
  }

  @$pb.TagNumber(5)
  $core.bool hasUpdated() => $_has(3);
  @$pb.TagNumber(5)
  void clearUpdated() => clearField(5);
  @$pb.TagNumber(5)
  $0.Timestamp ensureUpdated() => $_ensure(3);

  @$pb.TagNumber(101)
  JobData get jobData => $_getN(4);
  @$pb.TagNumber(101)
  set jobData(JobData v) {
    setField(101, v);
  }

  @$pb.TagNumber(101)
  $core.bool hasJobData() => $_has(4);
  @$pb.TagNumber(101)
  void clearJobData() => clearField(101);
  @$pb.TagNumber(101)
  JobData ensureJobData() => $_ensure(4);

  @$pb.TagNumber(201)
  $core.bool get deletionMark => $_getBF(5);
  @$pb.TagNumber(201)
  set deletionMark($core.bool v) {
    $_setBool(5, v);
  }

  @$pb.TagNumber(201)
  $core.bool hasDeletionMark() => $_has(5);
  @$pb.TagNumber(201)
  void clearDeletionMark() => clearField(201);
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
    ..e<Skill_SkillType>(
        2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: Skill_SkillType.OTHER, valueOf: Skill_SkillType.valueOf, enumValues: Skill_SkillType.values)
    ..hasRequiredFields = false;

  Skill._() : super();
  factory Skill({
    $core.String? value,
    Skill_SkillType? type,
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
  Skill_SkillType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(Skill_SkillType v) {
    setField(2, v);
  }

  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);
}

class Contact extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(
      const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Contact',
      package: const $pb.PackageName($core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'job'),
      createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'value')
    ..e<Contact_ContactType>(
        2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE,
        defaultOrMaker: Contact_ContactType.OTHER,
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
