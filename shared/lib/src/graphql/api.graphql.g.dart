// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetJob$QueryRoot$Job$JobDescriptionEnglish
    _$GetJob$QueryRoot$Job$JobDescriptionEnglishFromJson(
            Map<String, dynamic> json) =>
        GetJob$QueryRoot$Job$JobDescriptionEnglish()
          ..description = json['description'] as String;

Map<String, dynamic> _$GetJob$QueryRoot$Job$JobDescriptionEnglishToJson(
        GetJob$QueryRoot$Job$JobDescriptionEnglish instance) =>
    <String, dynamic>{
      'description': instance.description,
    };

GetJob$QueryRoot$Job$JobDescriptionRussian
    _$GetJob$QueryRoot$Job$JobDescriptionRussianFromJson(
            Map<String, dynamic> json) =>
        GetJob$QueryRoot$Job$JobDescriptionRussian()
          ..description = json['description'] as String;

Map<String, dynamic> _$GetJob$QueryRoot$Job$JobDescriptionRussianToJson(
        GetJob$QueryRoot$Job$JobDescriptionRussian instance) =>
    <String, dynamic>{
      'description': instance.description,
    };

GetJob$QueryRoot$Job$JobSkills _$GetJob$QueryRoot$Job$JobSkillsFromJson(
        Map<String, dynamic> json) =>
    GetJob$QueryRoot$Job$JobSkills()
      ..skills = fromGraphQL$textToDartListString(json['skills'] as Object);

Map<String, dynamic> _$GetJob$QueryRoot$Job$JobSkillsToJson(
        GetJob$QueryRoot$Job$JobSkills instance) =>
    <String, dynamic>{
      'skills': fromDartListStringToGraphQL$text(instance.skills),
    };

GetJob$QueryRoot$Job$JobContacts _$GetJob$QueryRoot$Job$JobContactsFromJson(
        Map<String, dynamic> json) =>
    GetJob$QueryRoot$Job$JobContacts()
      ..contacts = fromGraphQL$textToDartListString(json['contacts'] as Object);

Map<String, dynamic> _$GetJob$QueryRoot$Job$JobContactsToJson(
        GetJob$QueryRoot$Job$JobContacts instance) =>
    <String, dynamic>{
      'contacts': fromDartListStringToGraphQL$text(instance.contacts),
    };

GetJob$QueryRoot$Job$JobTags _$GetJob$QueryRoot$Job$JobTagsFromJson(
        Map<String, dynamic> json) =>
    GetJob$QueryRoot$Job$JobTags()..tag = json['tag'] as String;

Map<String, dynamic> _$GetJob$QueryRoot$Job$JobTagsToJson(
        GetJob$QueryRoot$Job$JobTags instance) =>
    <String, dynamic>{
      'tag': instance.tag,
    };

GetJob$QueryRoot$Job _$GetJob$QueryRoot$JobFromJson(
        Map<String, dynamic> json) =>
    GetJob$QueryRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool
      ..title = json['title'] as String
      ..company = json['company'] as String
      ..countryCode =
          fromGraphQLBpcharToDartString(json['country_code'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object)
      ..descriptionEnglish = json['description_english'] == null
          ? null
          : GetJob$QueryRoot$Job$JobDescriptionEnglish.fromJson(
              json['description_english'] as Map<String, dynamic>)
      ..descriptionRussian = json['description_russian'] == null
          ? null
          : GetJob$QueryRoot$Job$JobDescriptionRussian.fromJson(
              json['description_russian'] as Map<String, dynamic>)
      ..jobSkills = json['job_skills'] == null
          ? null
          : GetJob$QueryRoot$Job$JobSkills.fromJson(
              json['job_skills'] as Map<String, dynamic>)
      ..jobContacts = json['job_contacts'] == null
          ? null
          : GetJob$QueryRoot$Job$JobContacts.fromJson(
              json['job_contacts'] as Map<String, dynamic>)
      ..jobTags = (json['job_tags'] as List<dynamic>)
          .map((e) =>
              GetJob$QueryRoot$Job$JobTags.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$GetJob$QueryRoot$JobToJson(
        GetJob$QueryRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
      'title': instance.title,
      'company': instance.company,
      'country_code': fromDartStringToGraphQLBpchar(instance.countryCode),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
      'description_english': instance.descriptionEnglish?.toJson(),
      'description_russian': instance.descriptionRussian?.toJson(),
      'job_skills': instance.jobSkills?.toJson(),
      'job_contacts': instance.jobContacts?.toJson(),
      'job_tags': instance.jobTags.map((e) => e.toJson()).toList(),
    };

GetJob$QueryRoot _$GetJob$QueryRootFromJson(Map<String, dynamic> json) =>
    GetJob$QueryRoot()
      ..jobByPk = json['job_by_pk'] == null
          ? null
          : GetJob$QueryRoot$Job.fromJson(
              json['job_by_pk'] as Map<String, dynamic>);

Map<String, dynamic> _$GetJob$QueryRootToJson(GetJob$QueryRoot instance) =>
    <String, dynamic>{
      'job_by_pk': instance.jobByPk?.toJson(),
    };

Paginate$QueryRoot$Job _$Paginate$QueryRoot$JobFromJson(
        Map<String, dynamic> json) =>
    Paginate$QueryRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool
      ..title = json['title'] as String
      ..company = json['company'] as String
      ..countryCode =
          fromGraphQLBpcharToDartString(json['country_code'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object);

Map<String, dynamic> _$Paginate$QueryRoot$JobToJson(
        Paginate$QueryRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
      'title': instance.title,
      'company': instance.company,
      'country_code': fromDartStringToGraphQLBpchar(instance.countryCode),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
    };

Paginate$QueryRoot _$Paginate$QueryRootFromJson(Map<String, dynamic> json) =>
    Paginate$QueryRoot()
      ..jobPaginate = (json['job_paginate'] as List<dynamic>)
          .map(
              (e) => Paginate$QueryRoot$Job.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$Paginate$QueryRootToJson(Paginate$QueryRoot instance) =>
    <String, dynamic>{
      'job_paginate': instance.jobPaginate.map((e) => e.toJson()).toList(),
    };

UpdateJob$MutationRoot$Job _$UpdateJob$MutationRoot$JobFromJson(
        Map<String, dynamic> json) =>
    UpdateJob$MutationRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool
      ..title = json['title'] as String
      ..company = json['company'] as String
      ..countryCode =
          fromGraphQLBpcharToDartString(json['country_code'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object);

Map<String, dynamic> _$UpdateJob$MutationRoot$JobToJson(
        UpdateJob$MutationRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
      'title': instance.title,
      'company': instance.company,
      'country_code': fromDartStringToGraphQLBpchar(instance.countryCode),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
    };

UpdateJob$MutationRoot$JobDescriptionEnglish
    _$UpdateJob$MutationRoot$JobDescriptionEnglishFromJson(
            Map<String, dynamic> json) =>
        UpdateJob$MutationRoot$JobDescriptionEnglish()
          ..description = json['description'] as String;

Map<String, dynamic> _$UpdateJob$MutationRoot$JobDescriptionEnglishToJson(
        UpdateJob$MutationRoot$JobDescriptionEnglish instance) =>
    <String, dynamic>{
      'description': instance.description,
    };

UpdateJob$MutationRoot$JobDescriptionRussian
    _$UpdateJob$MutationRoot$JobDescriptionRussianFromJson(
            Map<String, dynamic> json) =>
        UpdateJob$MutationRoot$JobDescriptionRussian()
          ..description = json['description'] as String;

Map<String, dynamic> _$UpdateJob$MutationRoot$JobDescriptionRussianToJson(
        UpdateJob$MutationRoot$JobDescriptionRussian instance) =>
    <String, dynamic>{
      'description': instance.description,
    };

UpdateJob$MutationRoot$JobContacts _$UpdateJob$MutationRoot$JobContactsFromJson(
        Map<String, dynamic> json) =>
    UpdateJob$MutationRoot$JobContacts()
      ..contacts = fromGraphQL$textToDartListString(json['contacts'] as Object);

Map<String, dynamic> _$UpdateJob$MutationRoot$JobContactsToJson(
        UpdateJob$MutationRoot$JobContacts instance) =>
    <String, dynamic>{
      'contacts': fromDartListStringToGraphQL$text(instance.contacts),
    };

UpdateJob$MutationRoot$JobSkills _$UpdateJob$MutationRoot$JobSkillsFromJson(
        Map<String, dynamic> json) =>
    UpdateJob$MutationRoot$JobSkills()
      ..skills = fromGraphQL$textToDartListString(json['skills'] as Object);

Map<String, dynamic> _$UpdateJob$MutationRoot$JobSkillsToJson(
        UpdateJob$MutationRoot$JobSkills instance) =>
    <String, dynamic>{
      'skills': fromDartListStringToGraphQL$text(instance.skills),
    };

UpdateJob$MutationRoot$JobTagsMutationResponse$JobTags
    _$UpdateJob$MutationRoot$JobTagsMutationResponse$JobTagsFromJson(
            Map<String, dynamic> json) =>
        UpdateJob$MutationRoot$JobTagsMutationResponse$JobTags()
          ..tag = json['tag'] as String;

Map<String, dynamic>
    _$UpdateJob$MutationRoot$JobTagsMutationResponse$JobTagsToJson(
            UpdateJob$MutationRoot$JobTagsMutationResponse$JobTags instance) =>
        <String, dynamic>{
          'tag': instance.tag,
        };

UpdateJob$MutationRoot$JobTagsMutationResponse
    _$UpdateJob$MutationRoot$JobTagsMutationResponseFromJson(
            Map<String, dynamic> json) =>
        UpdateJob$MutationRoot$JobTagsMutationResponse()
          ..returning = (json['returning'] as List<dynamic>)
              .map((e) => UpdateJob$MutationRoot$JobTagsMutationResponse$JobTags
                  .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$UpdateJob$MutationRoot$JobTagsMutationResponseToJson(
        UpdateJob$MutationRoot$JobTagsMutationResponse instance) =>
    <String, dynamic>{
      'returning': instance.returning.map((e) => e.toJson()).toList(),
    };

UpdateJob$MutationRoot _$UpdateJob$MutationRootFromJson(
        Map<String, dynamic> json) =>
    UpdateJob$MutationRoot()
      ..updateJobByPk = json['update_job_by_pk'] == null
          ? null
          : UpdateJob$MutationRoot$Job.fromJson(
              json['update_job_by_pk'] as Map<String, dynamic>)
      ..updateJobDescriptionEnglishByPk =
          json['update_job_description_english_by_pk'] == null
              ? null
              : UpdateJob$MutationRoot$JobDescriptionEnglish.fromJson(
                  json['update_job_description_english_by_pk']
                      as Map<String, dynamic>)
      ..updateJobDescriptionRussianByPk =
          json['update_job_description_russian_by_pk'] == null
              ? null
              : UpdateJob$MutationRoot$JobDescriptionRussian.fromJson(
                  json['update_job_description_russian_by_pk']
                      as Map<String, dynamic>)
      ..updateJobContactsByPk = json['update_job_contacts_by_pk'] == null
          ? null
          : UpdateJob$MutationRoot$JobContacts.fromJson(
              json['update_job_contacts_by_pk'] as Map<String, dynamic>)
      ..updateJobSkillsByPk = json['update_job_skills_by_pk'] == null
          ? null
          : UpdateJob$MutationRoot$JobSkills.fromJson(
              json['update_job_skills_by_pk'] as Map<String, dynamic>)
      ..updateJobTags = json['update_job_tags'] == null
          ? null
          : UpdateJob$MutationRoot$JobTagsMutationResponse.fromJson(
              json['update_job_tags'] as Map<String, dynamic>);

Map<String, dynamic> _$UpdateJob$MutationRootToJson(
        UpdateJob$MutationRoot instance) =>
    <String, dynamic>{
      'update_job_by_pk': instance.updateJobByPk?.toJson(),
      'update_job_description_english_by_pk':
          instance.updateJobDescriptionEnglishByPk?.toJson(),
      'update_job_description_russian_by_pk':
          instance.updateJobDescriptionRussianByPk?.toJson(),
      'update_job_contacts_by_pk': instance.updateJobContactsByPk?.toJson(),
      'update_job_skills_by_pk': instance.updateJobSkillsByPk?.toJson(),
      'update_job_tags': instance.updateJobTags?.toJson(),
    };

JobSetInput _$JobSetInputFromJson(Map<String, dynamic> json) => JobSetInput(
      address: json['address'] as String?,
      company: json['company'] as String?,
      countryCode: fromGraphQLBpcharNullableToDartStringNullable(
          json['country_code'] as String?),
      deletionMark: json['deletion_mark'] as bool?,
      employments: fromGraphQL$employmentNullableToDartListNullableEmployment(
          json['employments']),
      levels: fromGraphQL$levelNullableToDartListNullableDeveloperLevel(
          json['levels']),
      relocation: fromGraphQLRelocationNullableToDartRelocationNullable(
          json['relocation'] as String?),
      remote: json['remote'] as bool?,
      title: json['title'] as String?,
    );

Map<String, dynamic> _$JobSetInputToJson(JobSetInput instance) =>
    <String, dynamic>{
      'address': instance.address,
      'company': instance.company,
      'country_code':
          fromDartStringNullableToGraphQLBpcharNullable(instance.countryCode),
      'deletion_mark': instance.deletionMark,
      'employments': fromDartListNullableEmploymentToGraphQL$employmentNullable(
          instance.employments),
      'levels': fromDartListNullableDeveloperLevelToGraphQL$levelNullable(
          instance.levels),
      'relocation': fromDartRelocationNullableToGraphQLRelocationNullable(
          instance.relocation),
      'remote': instance.remote,
      'title': instance.title,
    };

Recent$QueryRoot$Job _$Recent$QueryRoot$JobFromJson(
        Map<String, dynamic> json) =>
    Recent$QueryRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool
      ..title = json['title'] as String
      ..company = json['company'] as String
      ..countryCode =
          fromGraphQLBpcharToDartString(json['country_code'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object);

Map<String, dynamic> _$Recent$QueryRoot$JobToJson(
        Recent$QueryRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
      'title': instance.title,
      'company': instance.company,
      'country_code': fromDartStringToGraphQLBpchar(instance.countryCode),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
    };

Recent$QueryRoot _$Recent$QueryRootFromJson(Map<String, dynamic> json) =>
    Recent$QueryRoot()
      ..jobRecent = (json['job_recent'] as List<dynamic>)
          .map((e) => Recent$QueryRoot$Job.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$Recent$QueryRootToJson(Recent$QueryRoot instance) =>
    <String, dynamic>{
      'job_recent': instance.jobRecent.map((e) => e.toJson()).toList(),
    };

DeleteJob$MutationRoot$Job _$DeleteJob$MutationRoot$JobFromJson(
        Map<String, dynamic> json) =>
    DeleteJob$MutationRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool
      ..title = json['title'] as String
      ..company = json['company'] as String
      ..countryCode =
          fromGraphQLBpcharToDartString(json['country_code'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object);

Map<String, dynamic> _$DeleteJob$MutationRoot$JobToJson(
        DeleteJob$MutationRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
      'title': instance.title,
      'company': instance.company,
      'country_code': fromDartStringToGraphQLBpchar(instance.countryCode),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
    };

DeleteJob$MutationRoot$JobDescriptionEnglish
    _$DeleteJob$MutationRoot$JobDescriptionEnglishFromJson(
            Map<String, dynamic> json) =>
        DeleteJob$MutationRoot$JobDescriptionEnglish()
          ..description = json['description'] as String;

Map<String, dynamic> _$DeleteJob$MutationRoot$JobDescriptionEnglishToJson(
        DeleteJob$MutationRoot$JobDescriptionEnglish instance) =>
    <String, dynamic>{
      'description': instance.description,
    };

DeleteJob$MutationRoot$JobDescriptionRussian
    _$DeleteJob$MutationRoot$JobDescriptionRussianFromJson(
            Map<String, dynamic> json) =>
        DeleteJob$MutationRoot$JobDescriptionRussian()
          ..description = json['description'] as String;

Map<String, dynamic> _$DeleteJob$MutationRoot$JobDescriptionRussianToJson(
        DeleteJob$MutationRoot$JobDescriptionRussian instance) =>
    <String, dynamic>{
      'description': instance.description,
    };

DeleteJob$MutationRoot$JobContacts _$DeleteJob$MutationRoot$JobContactsFromJson(
        Map<String, dynamic> json) =>
    DeleteJob$MutationRoot$JobContacts()
      ..contacts = fromGraphQL$textToDartListString(json['contacts'] as Object);

Map<String, dynamic> _$DeleteJob$MutationRoot$JobContactsToJson(
        DeleteJob$MutationRoot$JobContacts instance) =>
    <String, dynamic>{
      'contacts': fromDartListStringToGraphQL$text(instance.contacts),
    };

DeleteJob$MutationRoot$JobSkills _$DeleteJob$MutationRoot$JobSkillsFromJson(
        Map<String, dynamic> json) =>
    DeleteJob$MutationRoot$JobSkills()
      ..skills = fromGraphQL$textToDartListString(json['skills'] as Object);

Map<String, dynamic> _$DeleteJob$MutationRoot$JobSkillsToJson(
        DeleteJob$MutationRoot$JobSkills instance) =>
    <String, dynamic>{
      'skills': fromDartListStringToGraphQL$text(instance.skills),
    };

DeleteJob$MutationRoot$JobTagsMutationResponse$JobTags
    _$DeleteJob$MutationRoot$JobTagsMutationResponse$JobTagsFromJson(
            Map<String, dynamic> json) =>
        DeleteJob$MutationRoot$JobTagsMutationResponse$JobTags()
          ..tag = json['tag'] as String;

Map<String, dynamic>
    _$DeleteJob$MutationRoot$JobTagsMutationResponse$JobTagsToJson(
            DeleteJob$MutationRoot$JobTagsMutationResponse$JobTags instance) =>
        <String, dynamic>{
          'tag': instance.tag,
        };

DeleteJob$MutationRoot$JobTagsMutationResponse
    _$DeleteJob$MutationRoot$JobTagsMutationResponseFromJson(
            Map<String, dynamic> json) =>
        DeleteJob$MutationRoot$JobTagsMutationResponse()
          ..returning = (json['returning'] as List<dynamic>)
              .map((e) => DeleteJob$MutationRoot$JobTagsMutationResponse$JobTags
                  .fromJson(e as Map<String, dynamic>))
              .toList();

Map<String, dynamic> _$DeleteJob$MutationRoot$JobTagsMutationResponseToJson(
        DeleteJob$MutationRoot$JobTagsMutationResponse instance) =>
    <String, dynamic>{
      'returning': instance.returning.map((e) => e.toJson()).toList(),
    };

DeleteJob$MutationRoot _$DeleteJob$MutationRootFromJson(
        Map<String, dynamic> json) =>
    DeleteJob$MutationRoot()
      ..updateJobByPk = json['update_job_by_pk'] == null
          ? null
          : DeleteJob$MutationRoot$Job.fromJson(
              json['update_job_by_pk'] as Map<String, dynamic>)
      ..updateJobDescriptionEnglishByPk =
          json['update_job_description_english_by_pk'] == null
              ? null
              : DeleteJob$MutationRoot$JobDescriptionEnglish.fromJson(
                  json['update_job_description_english_by_pk']
                      as Map<String, dynamic>)
      ..updateJobDescriptionRussianByPk =
          json['update_job_description_russian_by_pk'] == null
              ? null
              : DeleteJob$MutationRoot$JobDescriptionRussian.fromJson(
                  json['update_job_description_russian_by_pk']
                      as Map<String, dynamic>)
      ..updateJobContactsByPk = json['update_job_contacts_by_pk'] == null
          ? null
          : DeleteJob$MutationRoot$JobContacts.fromJson(
              json['update_job_contacts_by_pk'] as Map<String, dynamic>)
      ..updateJobSkillsByPk = json['update_job_skills_by_pk'] == null
          ? null
          : DeleteJob$MutationRoot$JobSkills.fromJson(
              json['update_job_skills_by_pk'] as Map<String, dynamic>)
      ..updateJobTags = json['update_job_tags'] == null
          ? null
          : DeleteJob$MutationRoot$JobTagsMutationResponse.fromJson(
              json['update_job_tags'] as Map<String, dynamic>);

Map<String, dynamic> _$DeleteJob$MutationRootToJson(
        DeleteJob$MutationRoot instance) =>
    <String, dynamic>{
      'update_job_by_pk': instance.updateJobByPk?.toJson(),
      'update_job_description_english_by_pk':
          instance.updateJobDescriptionEnglishByPk?.toJson(),
      'update_job_description_russian_by_pk':
          instance.updateJobDescriptionRussianByPk?.toJson(),
      'update_job_contacts_by_pk': instance.updateJobContactsByPk?.toJson(),
      'update_job_skills_by_pk': instance.updateJobSkillsByPk?.toJson(),
      'update_job_tags': instance.updateJobTags?.toJson(),
    };

CreateJob$MutationRoot$Job _$CreateJob$MutationRoot$JobFromJson(
        Map<String, dynamic> json) =>
    CreateJob$MutationRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool
      ..title = json['title'] as String
      ..company = json['company'] as String
      ..countryCode =
          fromGraphQLBpcharToDartString(json['country_code'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object);

Map<String, dynamic> _$CreateJob$MutationRoot$JobToJson(
        CreateJob$MutationRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
      'title': instance.title,
      'company': instance.company,
      'country_code': fromDartStringToGraphQLBpchar(instance.countryCode),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
    };

CreateJob$MutationRoot _$CreateJob$MutationRootFromJson(
        Map<String, dynamic> json) =>
    CreateJob$MutationRoot()
      ..jobCreate = (json['job_create'] as List<dynamic>)
          .map((e) =>
              CreateJob$MutationRoot$Job.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$CreateJob$MutationRootToJson(
        CreateJob$MutationRoot instance) =>
    <String, dynamic>{
      'job_create': instance.jobCreate.map((e) => e.toJson()).toList(),
    };

GetJobArguments _$GetJobArgumentsFromJson(Map<String, dynamic> json) =>
    GetJobArguments(
      id: json['id'] as int,
    );

Map<String, dynamic> _$GetJobArgumentsToJson(GetJobArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

PaginateArguments _$PaginateArgumentsFromJson(Map<String, dynamic> json) =>
    PaginateArguments(
      before: fromGraphQLTimestampToDartDateTime(json['before'] as String),
      exclude: fromGraphQL$int4ToDartListint(json['exclude'] as Object),
      remote: json['remote'] as bool?,
      country: json['country'] as String?,
      level: fromGraphQLLevelNullableToDartDeveloperLevelNullable(
          json['level'] as String?),
      employment: fromGraphQLEmploymentNullableToDartEmploymentNullable(
          json['employment'] as String?),
      relocation: json['relocation'] as bool?,
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$PaginateArgumentsToJson(PaginateArguments instance) =>
    <String, dynamic>{
      'before': fromDartDateTimeToGraphQLTimestamp(instance.before),
      'exclude': fromDartListintToGraphQL$int4(instance.exclude),
      'remote': instance.remote,
      'country': instance.country,
      'level':
          fromDartDeveloperLevelNullableToGraphQLLevelNullable(instance.level),
      'employment': fromDartEmploymentNullableToGraphQLEmploymentNullable(
          instance.employment),
      'relocation': instance.relocation,
      'limit': instance.limit,
    };

UpdateJobArguments _$UpdateJobArgumentsFromJson(Map<String, dynamic> json) =>
    UpdateJobArguments(
      id: json['id'] as int,
      data: JobSetInput.fromJson(json['data'] as Map<String, dynamic>),
      description_english: json['description_english'] as String,
      description_russian: json['description_russian'] as String,
      contacts:
          fromGraphQL$textNullableToDartListNullableString(json['contacts']),
      skills: fromGraphQL$textNullableToDartListNullableString(json['skills']),
    );

Map<String, dynamic> _$UpdateJobArgumentsToJson(UpdateJobArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data.toJson(),
      'description_english': instance.description_english,
      'description_russian': instance.description_russian,
      'contacts':
          fromDartListNullableStringToGraphQL$textNullable(instance.contacts),
      'skills':
          fromDartListNullableStringToGraphQL$textNullable(instance.skills),
    };

RecentArguments _$RecentArgumentsFromJson(Map<String, dynamic> json) =>
    RecentArguments(
      after: fromGraphQLTimestampToDartDateTime(json['after'] as String),
      exclude: fromGraphQL$int4ToDartListint(json['exclude'] as Object),
      remote: json['remote'] as bool?,
      country: json['country'] as String?,
      level: fromGraphQLLevelNullableToDartDeveloperLevelNullable(
          json['level'] as String?),
      employment: fromGraphQLEmploymentNullableToDartEmploymentNullable(
          json['employment'] as String?),
      relocation: json['relocation'] as bool?,
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$RecentArgumentsToJson(RecentArguments instance) =>
    <String, dynamic>{
      'after': fromDartDateTimeToGraphQLTimestamp(instance.after),
      'exclude': fromDartListintToGraphQL$int4(instance.exclude),
      'remote': instance.remote,
      'country': instance.country,
      'level':
          fromDartDeveloperLevelNullableToGraphQLLevelNullable(instance.level),
      'employment': fromDartEmploymentNullableToGraphQLEmploymentNullable(
          instance.employment),
      'relocation': instance.relocation,
      'limit': instance.limit,
    };

DeleteJobArguments _$DeleteJobArgumentsFromJson(Map<String, dynamic> json) =>
    DeleteJobArguments(
      id: json['id'] as int,
    );

Map<String, dynamic> _$DeleteJobArgumentsToJson(DeleteJobArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

CreateJobArguments _$CreateJobArgumentsFromJson(Map<String, dynamic> json) =>
    CreateJobArguments(
      title: json['title'] as String,
      company: json['company'] as String,
      country_code: json['country_code'] as String,
      address: json['address'] as String,
      remote: json['remote'] as bool,
      relocation:
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String),
      english_description: json['english_description'] as String,
      russian_description: json['russian_description'] as String,
      contacts: fromGraphQL$textToDartListString(json['contacts'] as Object),
      employments: fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object),
      levels: fromGraphQL$levelNullableToDartListNullableDeveloperLevel(
          json['levels']),
      skills: fromGraphQL$textNullableToDartListNullableString(json['skills']),
    );

Map<String, dynamic> _$CreateJobArgumentsToJson(CreateJobArguments instance) =>
    <String, dynamic>{
      'title': instance.title,
      'company': instance.company,
      'country_code': instance.country_code,
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'english_description': instance.english_description,
      'russian_description': instance.russian_description,
      'contacts': fromDartListStringToGraphQL$text(instance.contacts),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListNullableDeveloperLevelToGraphQL$levelNullable(
          instance.levels),
      'skills':
          fromDartListNullableStringToGraphQL$textNullable(instance.skills),
    };
