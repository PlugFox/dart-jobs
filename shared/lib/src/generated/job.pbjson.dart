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
    {'1': 'MIDDLE', '2': 0},
    {'1': 'INTERN', '2': 1},
    {'1': 'JUNIOR', '2': 2},
    {'1': 'SENIOR', '2': 3},
    {'1': 'LEAD', '2': 4},
  ],
};

/// Descriptor for `DeveloperLevel`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List developerLevelDescriptor = $convert.base64Decode(
    'Cg5EZXZlbG9wZXJMZXZlbBIKCgZNSURETEUQABIKCgZJTlRFUk4QARIKCgZKVU5JT1IQAhIKCgZTRU5JT1IQAxIICgRMRUFEEAQ=');
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
@$core.Deprecated('Use jobsChunkDescriptor instead')
const JobsChunk$json = {
  '1': 'JobsChunk',
  '2': [
    {'1': 'endOfList', '3': 1, '4': 1, '5': 8, '10': 'endOfList'},
    {'1': 'jobs', '3': 2, '4': 3, '5': 11, '6': '.job.Job', '10': 'jobs'},
  ],
};

/// Descriptor for `JobsChunk`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jobsChunkDescriptor = $convert
    .base64Decode('CglKb2JzQ2h1bmsSHAoJZW5kT2ZMaXN0GAEgASgIUgllbmRPZkxpc3QSHAoEam9icxgCIAMoCzIILmpvYi5Kb2JSBGpvYnM=');
@$core.Deprecated('Use jobDescriptor instead')
const Job$json = {
  '1': 'Job',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 13, '10': 'id'},
    {'1': 'creatorId', '3': 2, '4': 1, '5': 9, '10': 'creatorId'},
    {'1': 'created', '3': 4, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'created'},
    {'1': 'updated', '3': 5, '4': 1, '5': 11, '6': '.google.protobuf.Timestamp', '10': 'updated'},
    {'1': 'jobData', '3': 101, '4': 1, '5': 11, '6': '.job.JobData', '10': 'jobData'},
    {'1': 'deletionMark', '3': 201, '4': 1, '5': 8, '10': 'deletionMark'},
  ],
  '9': [
    {'1': 3, '2': 4},
    {'1': 6, '2': 101},
    {'1': 102, '2': 201},
  ],
};

/// Descriptor for `Job`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List jobDescriptor = $convert.base64Decode(
    'CgNKb2ISDgoCaWQYASABKA1SAmlkEhwKCWNyZWF0b3JJZBgCIAEoCVIJY3JlYXRvcklkEjQKB2NyZWF0ZWQYBCABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgdjcmVhdGVkEjQKB3VwZGF0ZWQYBSABKAsyGi5nb29nbGUucHJvdG9idWYuVGltZXN0YW1wUgd1cGRhdGVkEiYKB2pvYkRhdGEYZSABKAsyDC5qb2IuSm9iRGF0YVIHam9iRGF0YRIjCgxkZWxldGlvbk1hcmsYyQEgASgIUgxkZWxldGlvbk1hcmtKBAgDEARKBAgGEGVKBQhmEMkB');
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
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.job.Skill.SkillType', '10': 'type'},
  ],
  '4': [Skill_SkillType$json],
};

@$core.Deprecated('Use skillDescriptor instead')
const Skill_SkillType$json = {
  '1': 'SkillType',
  '2': [
    {'1': 'OTHER', '2': 0},
  ],
};

/// Descriptor for `Skill`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List skillDescriptor = $convert.base64Decode(
    'CgVTa2lsbBIUCgV2YWx1ZRgBIAEoCVIFdmFsdWUSKAoEdHlwZRgCIAEoDjIULmpvYi5Ta2lsbC5Ta2lsbFR5cGVSBHR5cGUiFgoJU2tpbGxUeXBlEgkKBU9USEVSEAA=');
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
    {'1': 'OTHER', '2': 0},
    {'1': 'PHONE', '2': 1},
    {'1': 'WEBSITE', '2': 2},
    {'1': 'EMAIL', '2': 3},
    {'1': 'TELEGRAM', '2': 4},
  ],
};

/// Descriptor for `Contact`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List contactDescriptor = $convert.base64Decode(
    'CgdDb250YWN0EhQKBXZhbHVlGAEgASgJUgV2YWx1ZRIsCgR0eXBlGAIgASgOMhguam9iLkNvbnRhY3QuQ29udGFjdFR5cGVSBHR5cGUiSQoLQ29udGFjdFR5cGUSCQoFT1RIRVIQABIJCgVQSE9ORRABEgsKB1dFQlNJVEUQAhIJCgVFTUFJTBADEgwKCFRFTEVHUkFNEAQ=');
