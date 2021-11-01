// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JobEntity _$JobEntityFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'creator_id',
      'created',
      'updated',
      'title',
      'company',
      'country',
      'address',
      'remote',
      'level',
      'tags',
      'skills',
      'contacts',
      'employment'
    ],
  );
  return JobEntity(
    id: json['id'] as String,
    creatorId: json['creator_id'] as String,
    created: DateTime.parse(json['created'] as String),
    updated: DateTime.parse(json['updated'] as String),
    title: json['title'] as String,
    company: json['company'] as String,
    country: json['country'] as String,
    remote: json['remote'] as bool,
    address: json['address'] as String,
    level: JobDeveloperLevel.fromJson(json['level'] as Map<String, dynamic>),
    tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    skills: (json['skills'] as List<dynamic>)
        .map((e) => Skill.fromJson(e as Map<String, dynamic>))
        .toList(),
    contacts: (json['contacts'] as List<dynamic>)
        .map((e) => Contact.fromJson(e as Map<String, dynamic>))
        .toList(),
    employment: (json['employment'] as List<dynamic>)
        .map((e) => $enumDecode(_$EmploymentEnumMap, e))
        .toList(),
  );
}

Map<String, dynamic> _$JobEntityToJson(JobEntity instance) => <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'title': instance.title,
      'company': instance.company,
      'country': instance.country,
      'address': instance.address,
      'remote': instance.remote,
      'level': instance.level.toJson(),
      'tags': instance.tags,
      'skills': instance.skills.map((e) => e.toJson()).toList(),
      'contacts': instance.contacts.map((e) => e.toJson()).toList(),
      'employment':
          instance.employment.map((e) => _$EmploymentEnumMap[e]).toList(),
    };

const _$EmploymentEnumMap = {
  Employment.unknown: 'unknown',
  Employment.fullTime: 'fullTime',
  Employment.partTime: 'partTime',
  Employment.oneTime: 'oneTime',
  Employment.contract: 'contract',
  Employment.openSource: 'openSource',
  Employment.collaboration: 'collaboration',
};

JobDescription _$JobDescriptionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['en', 'ru'],
  );
  return JobDescription(
    ru: json['ru'] as String? ?? '',
    en: json['en'] as String? ?? '',
  );
}

Map<String, dynamic> _$JobDescriptionToJson(JobDescription instance) =>
    <String, dynamic>{
      'en': instance.en,
      'ru': instance.ru,
    };

JobDeveloperLevel _$JobDeveloperLevelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['from', 'to'],
  );
  return JobDeveloperLevel(
    from: $enumDecodeNullable(_$DeveloperLevelEnumMap, json['from']) ??
        DeveloperLevel.intern,
    to: $enumDecodeNullable(_$DeveloperLevelEnumMap, json['to']) ??
        DeveloperLevel.lead,
  );
}

Map<String, dynamic> _$JobDeveloperLevelToJson(JobDeveloperLevel instance) =>
    <String, dynamic>{
      'from': _$DeveloperLevelEnumMap[instance.from],
      'to': _$DeveloperLevelEnumMap[instance.to],
    };

const _$DeveloperLevelEnumMap = {
  DeveloperLevel.unknown: -1,
  DeveloperLevel.intern: 0,
  DeveloperLevel.junior: 1,
  DeveloperLevel.middle: 2,
  DeveloperLevel.senior: 3,
  DeveloperLevel.lead: 4,
};
