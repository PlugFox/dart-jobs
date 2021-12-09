// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InsertJob$MutationRoot$Job _$InsertJob$MutationRoot$JobFromJson(
        Map<String, dynamic> json) =>
    InsertJob$MutationRoot$Job()
      ..id = json['id'] as int
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..title = json['title'] as String
      ..tags = (json['tags'] as List<dynamic>).map((e) => e as String).toList()
      ..skills =
          (json['skills'] as List<dynamic>).map((e) => e as String).toList()
      ..russianDescription = json['russian_description'] as String
      ..remote = json['remote'] as bool
      ..levels = (json['levels'] as List<dynamic>)
          .map((e) => DeveloperLevel.fromJson(e as Map<String, dynamic>))
          .toList()
      ..englishDescription = json['english_description'] as String
      ..employments = (json['employments'] as List<dynamic>)
          .map((e) => Employment.fromJson(e as Map<String, dynamic>))
          .toList()
      ..deletionMark = json['deletion_mark'] as bool
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..country = json['country'] as int
      ..contacts =
          (json['contacts'] as List<dynamic>).map((e) => e as String).toList()
      ..company = json['company'] as String;

Map<String, dynamic> _$InsertJob$MutationRoot$JobToJson(
        InsertJob$MutationRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'title': instance.title,
      'tags': instance.tags,
      'skills': instance.skills,
      'russian_description': instance.russianDescription,
      'remote': instance.remote,
      'levels': instance.levels.map((e) => e.toJson()).toList(),
      'english_description': instance.englishDescription,
      'employments': instance.employments.map((e) => e.toJson()).toList(),
      'deletion_mark': instance.deletionMark,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'country': instance.country,
      'contacts': instance.contacts,
      'company': instance.company,
    };

InsertJob$MutationRoot _$InsertJob$MutationRootFromJson(
        Map<String, dynamic> json) =>
    InsertJob$MutationRoot()
      ..insertJobOne = json['insert_job_one'] == null
          ? null
          : InsertJob$MutationRoot$Job.fromJson(
              json['insert_job_one'] as Map<String, dynamic>);

Map<String, dynamic> _$InsertJob$MutationRootToJson(
        InsertJob$MutationRoot instance) =>
    <String, dynamic>{
      'insert_job_one': instance.insertJobOne?.toJson(),
    };

InsertJobArguments _$InsertJobArgumentsFromJson(Map<String, dynamic> json) =>
    InsertJobArguments(
      title: json['title'] as String,
      company: json['company'] as String,
      country: json['country'] as int,
      creatorId: json['creatorId'] as String,
      remote: json['remote'] as bool,
      englishDescription: json['englishDescription'] as String,
      russianDescription: json['russianDescription'] as String,
      contacts:
          (json['contacts'] as List<dynamic>).map((e) => e as String).toList(),
      employments: (json['employments'] as List<dynamic>)
          .map((e) => Employment.fromJson(e as Map<String, dynamic>))
          .toList(),
      levels: (json['levels'] as List<dynamic>?)
          ?.map((e) => DeveloperLevel.fromJson(e as Map<String, dynamic>))
          .toList(),
      skills:
          (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
      tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$InsertJobArgumentsToJson(InsertJobArguments instance) =>
    <String, dynamic>{
      'title': instance.title,
      'company': instance.company,
      'country': instance.country,
      'creatorId': instance.creatorId,
      'remote': instance.remote,
      'englishDescription': instance.englishDescription,
      'russianDescription': instance.russianDescription,
      'contacts': instance.contacts,
      'employments': instance.employments.map((e) => e.toJson()).toList(),
      'levels': instance.levels?.map((e) => e.toJson()).toList(),
      'skills': instance.skills,
      'tags': instance.tags,
    };
