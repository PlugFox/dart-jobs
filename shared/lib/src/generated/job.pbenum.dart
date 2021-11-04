///
//  Generated code. Do not modify.
//  source: job.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class DeveloperLevel extends $pb.ProtobufEnum {
  static const DeveloperLevel INTERN =
      DeveloperLevel._(0, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'INTERN');
  static const DeveloperLevel JUNIOR =
      DeveloperLevel._(1, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'JUNIOR');
  static const DeveloperLevel MIDDLE =
      DeveloperLevel._(2, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MIDDLE');
  static const DeveloperLevel SENIOR =
      DeveloperLevel._(3, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SENIOR');
  static const DeveloperLevel LEAD =
      DeveloperLevel._(4, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'LEAD');

  static const $core.List<DeveloperLevel> values = <DeveloperLevel>[
    INTERN,
    JUNIOR,
    MIDDLE,
    SENIOR,
    LEAD,
  ];

  static final $core.Map<$core.int, DeveloperLevel> _byValue = $pb.ProtobufEnum.initByValue(values);
  static DeveloperLevel? valueOf($core.int value) => _byValue[value];

  const DeveloperLevel._($core.int v, $core.String n) : super(v, n);
}

class Employment extends $pb.ProtobufEnum {
  static const Employment FULL_TIME =
      Employment._(0, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FULL_TIME');
  static const Employment PART_TIME =
      Employment._(1, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PART_TIME');
  static const Employment ONE_TIME =
      Employment._(2, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ONE_TIME');
  static const Employment CONTRACT =
      Employment._(3, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CONTRACT');
  static const Employment OPEN_SOURCE =
      Employment._(4, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OPEN_SOURCE');
  static const Employment COLLABORATION =
      Employment._(5, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'COLLABORATION');

  static const $core.List<Employment> values = <Employment>[
    FULL_TIME,
    PART_TIME,
    ONE_TIME,
    CONTRACT,
    OPEN_SOURCE,
    COLLABORATION,
  ];

  static final $core.Map<$core.int, Employment> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Employment? valueOf($core.int value) => _byValue[value];

  const Employment._($core.int v, $core.String n) : super(v, n);
}

class Skill_SkillType extends $pb.ProtobufEnum {
  static const Skill_SkillType UNKNOWN =
      Skill_SkillType._(0, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const Skill_SkillType FRAMEWORK =
      Skill_SkillType._(1, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FRAMEWORK');
  static const Skill_SkillType PACKAGE =
      Skill_SkillType._(2, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PACKAGE');

  static const $core.List<Skill_SkillType> values = <Skill_SkillType>[
    UNKNOWN,
    FRAMEWORK,
    PACKAGE,
  ];

  static final $core.Map<$core.int, Skill_SkillType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Skill_SkillType? valueOf($core.int value) => _byValue[value];

  const Skill_SkillType._($core.int v, $core.String n) : super(v, n);
}

class Contact_ContactType extends $pb.ProtobufEnum {
  static const Contact_ContactType UNKNOWN =
      Contact_ContactType._(0, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'UNKNOWN');
  static const Contact_ContactType PHONE =
      Contact_ContactType._(1, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PHONE');
  static const Contact_ContactType SITE =
      Contact_ContactType._(2, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'SITE');
  static const Contact_ContactType EMAIL =
      Contact_ContactType._(3, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'EMAIL');
  static const Contact_ContactType TELEGRAM =
      Contact_ContactType._(4, $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TELEGRAM');

  static const $core.List<Contact_ContactType> values = <Contact_ContactType>[
    UNKNOWN,
    PHONE,
    SITE,
    EMAIL,
    TELEGRAM,
  ];

  static final $core.Map<$core.int, Contact_ContactType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Contact_ContactType? valueOf($core.int value) => _byValue[value];

  const Contact_ContactType._($core.int v, $core.String n) : super(v, n);
}
