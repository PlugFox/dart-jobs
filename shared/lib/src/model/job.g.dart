// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Job _$$_JobFromJson(Map<String, dynamic> json) => _$_Job(
      id: json['id'] as int,
      creatorId: json['creator_id'] as String,
      created: DateUtil.fromJson(json['created'] as Object),
      updated: DateUtil.fromJson(json['updated'] as Object),
      data: JobData.fromJson(json['job_data'] as Map<String, dynamic>),
      deletionMark: json['deletion_mark'] as bool? ?? false,
    );

Map<String, dynamic> _$$_JobToJson(_$_Job instance) => <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': DateUtil.toJson(instance.created),
      'updated': DateUtil.toJson(instance.updated),
      'job_data': instance.data.toJson(),
      'deletion_mark': instance.deletionMark,
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
      levels:
          (json['levels'] as List<dynamic>?)?.map((e) => DeveloperLevel.fromJson(e as Map<String, dynamic>)).toList() ??
              const <DeveloperLevel>[],
      skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
      contacts: (json['contacts'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
      employment:
          (json['employment'] as List<dynamic>?)?.map((e) => Employment.fromJson(e as Map<String, dynamic>)).toList() ??
              const <Employment>[],
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ?? const <String>[],
    );

Map<String, dynamic> _$$_JobDataToJson(_$_JobData instance) => <String, dynamic>{
      'title': instance.title,
      'company': instance.company,
      'country': instance.country,
      'remote': instance.remote,
      'address': instance.address,
      'descriptions': instance.descriptions.toJson(),
      'levels': instance.levels.map((e) => e.toJson()).toList(),
      'skills': instance.skills,
      'contacts': instance.contacts,
      'employment': instance.employment.map((e) => e.toJson()).toList(),
      'tags': instance.tags,
    };

_$PaginateJobFilter _$$PaginateJobFilterFromJson(Map<String, dynamic> json) => _$PaginateJobFilter(
      limit: json['limit'] as int? ?? 100,
    );

Map<String, dynamic> _$$PaginateJobFilterToJson(_$PaginateJobFilter instance) => <String, dynamic>{
      'limit': instance.limit,
    };
