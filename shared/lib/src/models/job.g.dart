// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Job _$$_JobFromJson(Map<String, dynamic> json) => _$_Job(
      weight: json['weight'] as int,
      id: json['id'] as String,
      creatorId: json['creator_id'] as String,
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
      data: JobData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_JobToJson(_$_Job instance) => <String, dynamic>{
      'weight': instance.weight,
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'data': instance.data.toJson(),
    };

_$_JobData _$$_JobDataFromJson(Map<String, dynamic> json) => _$_JobData(
      title: json['title'] as String? ?? '',
      company: json['company'] as String? ?? '',
      country: json['country'] as String? ?? '',
      remote: json['remote'] as bool? ?? true,
      address: json['address'] as String? ?? '',
      descriptions: json['descriptions'] == null
          ? const Description()
          : Description.fromJson(json['descriptions'] as Map<String, dynamic>),
      levels: (json['levels'] as List<dynamic>?)
              ?.map((e) => DeveloperLevel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DeveloperLevel>[],
      skills: (json['skills'] as List<dynamic>?)
              ?.map((e) => Skill.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Skill>[],
      contacts: (json['contacts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      employment: (json['employment'] as List<dynamic>?)
              ?.map((e) => Employment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <Employment>[],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const <String>[],
    );

Map<String, dynamic> _$$_JobDataToJson(_$_JobData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'company': instance.company,
      'country': instance.country,
      'remote': instance.remote,
      'address': instance.address,
      'descriptions': instance.descriptions.toJson(),
      'levels': instance.levels.map((e) => e.toJson()).toList(),
      'skills': instance.skills.map((e) => e.toJson()).toList(),
      'contacts': instance.contacts,
      'employment': instance.employment.map((e) => e.toJson()).toList(),
      'tags': instance.tags,
    };
