///
//  Generated code. Do not modify.
//  source: job.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields,deprecated_member_use_from_same_package

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use developerLevelDescriptor instead')
const DeveloperLevel$json = {
  '1': 'DeveloperLevel',
  '2': [
    {'1': 'INTERN', '2': 0},
    {'1': 'JUNIOR', '2': 1},
    {'1': 'MIDDLE', '2': 2},
    {'1': 'SENIOR', '2': 3},
    {'1': 'LEAD', '2': 4},
  ],
};

/// Descriptor for `DeveloperLevel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List developerLevelDescriptor = $convert.base64Decode(
    'Cg5EZXZlbG9wZXJMZXZlbBIKCgZJTlRFUk4QABIKCgZKVU5JT1IQARIKCgZNSURETEUQAhIKCgZTRU5JT1IQAxIICgRMRUFEEAQ=');
@$core.Deprecated('Use employmentDescriptor instead')
const Employment$json = {
  '1': 'Employment',
  '2': [
    {'1': 'FULL_TIME', '2': 0},
    {'1': 'PART_TIME', '2': 1},
    {'1': 'ONE_TIME', '2': 2},
    {'1': 'CONTRACT', '2': 3},
    {'1': 'OPEN_SOURCE', '2': 4},
    {'1': 'COLLABORATION', '2': 5},
  ],
};

/// Descriptor for `Employment`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List employmentDescriptor = $convert.base64Decode(
    'CgpFbXBsb3ltZW50Eg0KCUZVTExfVElNRRAAEg0KCVBBUlRfVElNRRABEgwKCE9ORV9USU1FEAISDAoIQ09OVFJBQ1QQAxIPCgtPUEVOX1NPVVJDRRAEEhEKDUNPTExBQk9SQVRJT04QBQ==');
@$core.Deprecated('Use jobFilterDescriptor instead')
const JobFilter$json = {
  '1': 'JobFilter',
  '2': [
    {'1': 'limit', '3': 1, '4': 1, '5': 13, '10': 'limit'},
    {'1': 'before', '3': 2, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'before'},
    {'1': 'after', '3': 3, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'after'},
  ],
};

/// Descriptor for `JobFilter`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jobFilterDescriptor = $convert.base64Decode(
    'CglKb2JGaWx0ZXISFAoFbGltaXQYASABKA1SBWxpbWl0EjIKBmJlZm9yZRgCIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBmJlZm9yZRIwCgVhZnRlchgDIAEoCzIaLmdvb2dsZS5wcm90b2J1Zi5UaW1lc3RhbXBSBWFmdGVy');
@$core.Deprecated('Use jobChangesDescriptor instead')
const JobChanges$json = {
  '1': 'JobChanges',
  '2': [
    {'1': 'endOfList', '3': 1, '4': 1, '5': 8, '10': 'endOfList'},
    {'1': 'list', '3': 2, '4': 3, '5': 11, '6': '.job.JobChange', '10': 'list'},
  ],
};

/// Descriptor for `JobChanges`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jobChangesDescriptor = $convert.base64Decode(
    'CgpKb2JDaGFuZ2VzEhwKCWVuZE9mTGlzdBgBIAEoCFIJZW5kT2ZMaXN0EiIKBGxpc3QYAiADKAsyDi5qb2IuSm9iQ2hhbmdlUgRsaXN0');
@$core.Deprecated('Use jobChangeDescriptor instead')
const JobChange$json = {
  '1': 'JobChange',
  '2': [
    {'1': 'exists', '3': 1, '4': 1, '5': 8, '10': 'exists'},
    {'1': 'job', '3': 2, '4': 1, '5': 11, '6': '.job.Job', '10': 'job'},
  ],
};

/// Descriptor for `JobChange`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jobChangeDescriptor =
    $convert.base64Decode('CglKb2JDaGFuZ2USFgoGZXhpc3RzGAEgASgIUgZleGlzdHMSGgoDam9iGAIgASgLMgguam9iLkpvYlIDam9i');
@$core.Deprecated('Use jobDescriptor instead')
const Job$json = {
  '1': 'Job',
  '2': [
    {'1': 'weight', '3': 1, '4': 1, '5': 4, '10': 'weight'},
    {'1': 'id', '3': 2, '4': 1, '5': 9, '10': 'id'},
    {'1': 'creatorId', '3': 3, '4': 1, '5': 9, '10': 'creatorId'},
    {'1': 'created', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created'},
    {'1': 'updated', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updated'},
    {'1': 'data', '3': 101, '4': 1, '5': 11, '6': '.job.JobData', '10': 'data'},
  ],
};

/// Descriptor for `Job`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jobDescriptor = $convert.base64Decode(
    'CgNKb2ISFgoGd2VpZ2h0GAEgASgEUgZ3ZWlnaHQSDgoCaWQYAiABKAlSAmlkEhwKCWNyZWF0b3JJZBgDIAEoCVIJY3JlYXRvcklkEjQKB2NyZWF0ZWQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdjcmVhdGVkEjQKB3VwZGF0ZWQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgd1cGRhdGVkEiAKBGRhdGEYZSABKAsyDC5qb2IuSm9iRGF0YVIEZGF0YQ==');
@$core.Deprecated('Use jobDataDescriptor instead')
const JobData$json = {
  '1': 'JobData',
  '2': [
    {'1': 'title', '3': 1, '4': 1, '5': 9, '10': 'title'},
    {'1': 'company', '3': 2, '4': 1, '5': 9, '10': 'company'},
    {'1': 'country', '3': 3, '4': 1, '5': 9, '10': 'country'},
    {'1': 'remote', '3': 4, '4': 1, '5': 8, '10': 'remote'},
    {'1': 'address', '3': 5, '4': 1, '5': 9, '10': 'address'},
    {'1': 'descriptions', '3': 6, '4': 3, '5': 11, '6': '.job.JobData.DescriptionsEntry', '10': 'descriptions'},
    {'1': 'levels', '3': 7, '4': 3, '5': 14, '6': '.job.DeveloperLevel', '10': 'levels'},
    {'1': 'skills', '3': 8, '4': 3, '5': 11, '6': '.job.Skill', '10': 'skills'},
    {'1': 'contacts', '3': 9, '4': 3, '5': 11, '6': '.job.Contact', '10': 'contacts'},
    {'1': 'employment', '3': 10, '4': 3, '5': 14, '6': '.job.Employment', '10': 'employment'},
    {'1': 'tags', '3': 11, '4': 3, '5': 9, '10': 'tags'},
  ],
  '3': [JobData_DescriptionsEntry$json],
};

@$core.Deprecated('Use jobDataDescriptor instead')
const JobData_DescriptionsEntry$json = {
  '1': 'DescriptionsEntry',
  '2': [
    {'1': 'key', '3': 1, '4': 1, '5': 9, '10': 'key'},
    {'1': 'value', '3': 2, '4': 1, '5': 9, '10': 'value'},
  ],
  '7': {'7': true},
};

/// Descriptor for `JobData`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jobDataDescriptor = $convert.base64Decode(
    'CgdKb2JEYXRhEhQKBXRpdGxlGAEgASgJUgV0aXRsZRIYCgdjb21wYW55GAIgASgJUgdjb21wYW55EhgKB2NvdW50cnkYAyABKAlSB2NvdW50cnkSFgoGcmVtb3RlGAQgASgIUgZyZW1vdGUSGAoHYWRkcmVzcxgFIAEoCVIHYWRkcmVzcxJCCgxkZXNjcmlwdGlvbnMYBiADKAsyHi5qb2IuSm9iRGF0YS5EZXNjcmlwdGlvbnNFbnRyeVIMZGVzY3JpcHRpb25zEisKBmxldmVscxgHIAMoDjITLmpvYi5EZXZlbG9wZXJMZXZlbFIGbGV2ZWxzEiIKBnNraWxscxgIIAMoCzIKLmpvYi5Ta2lsbFIGc2tpbGxzEigKCGNvbnRhY3RzGAkgAygLMgwuam9iLkNvbnRhY3RSCGNvbnRhY3RzEi8KCmVtcGxveW1lbnQYCiADKA4yDy5qb2IuRW1wbG95bWVudFIKZW1wbG95bWVudBISCgR0YWdzGAsgAygJUgR0YWdzGj8KEURlc2NyaXB0aW9uc0VudHJ5EhAKA2tleRgBIAEoCVIDa2V5EhQKBXZhbHVlGAIgASgJUgV2YWx1ZToCOAE=');
@$core.Deprecated('Use skillDescriptor instead')
const Skill$json = {
  '1': 'Skill',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'type', '3': 2, '4': 1, '5': 11, '6': '.job.Skill', '10': 'type'},
  ],
  '4': [Skill_SkillType$json],
};

@$core.Deprecated('Use skillDescriptor instead')
const Skill_SkillType$json = {
  '1': 'SkillType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'FRAMEWORK', '2': 1},
    {'1': 'PACKAGE', '2': 2},
  ],
};

/// Descriptor for `Skill`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skillDescriptor = $convert.base64Decode(
    'CgVTa2lsbBIUCgV2YWx1ZRgBIAEoCVIFdmFsdWUSHgoEdHlwZRgCIAEoCzIKLmpvYi5Ta2lsbFIEdHlwZSI0CglTa2lsbFR5cGUSCwoHVU5LTk9XThAAEg0KCUZSQU1FV09SSxABEgsKB1BBQ0tBR0UQAg==');
@$core.Deprecated('Use contactDescriptor instead')
const Contact$json = {
  '1': 'Contact',
  '2': [
    {'1': 'value', '3': 1, '4': 1, '5': 9, '10': 'value'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.job.Contact.ContactType', '10': 'type'},
  ],
  '4': [Contact_ContactType$json],
};

@$core.Deprecated('Use contactDescriptor instead')
const Contact_ContactType$json = {
  '1': 'ContactType',
  '2': [
    {'1': 'UNKNOWN', '2': 0},
    {'1': 'PHONE', '2': 1},
    {'1': 'WEBSITE', '2': 2},
    {'1': 'EMAIL', '2': 3},
    {'1': 'TELEGRAM', '2': 4},
  ],
};

/// Descriptor for `Contact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactDescriptor = $convert.base64Decode(
    'CgdDb250YWN0EhQKBXZhbHVlGAEgASgJUgV2YWx1ZRIsCgR0eXBlGAIgASgOMhguam9iLkNvbnRhY3QuQ29udGFjdFR5cGVSBHR5cGUiSwoLQ29udGFjdFR5cGUSCwoHVU5LTk9XThAAEgkKBVBIT05FEAESCwoHV0VCU0lURRACEgkKBUVNQUlMEAMSDAoIVEVMRUdSQU0QBA==');
