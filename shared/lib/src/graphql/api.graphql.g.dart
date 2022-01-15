// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=2.12

part of 'api.graphql.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchRecent$QueryRoot$Job _$FetchRecent$QueryRoot$JobFromJson(
        Map<String, dynamic> json) =>
    FetchRecent$QueryRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool
      ..title = json['title'] as String
      ..company = json['company'] as String
      ..country = fromGraphQLBpcharToDartString(json['country'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object)
      ..isEnglish = json['is_english'] as bool
      ..isRussian = json['is_russian'] as bool;

Map<String, dynamic> _$FetchRecent$QueryRoot$JobToJson(
        FetchRecent$QueryRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
      'title': instance.title,
      'company': instance.company,
      'country': fromDartStringToGraphQLBpchar(instance.country),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
      'is_english': instance.isEnglish,
      'is_russian': instance.isRussian,
    };

FetchRecent$QueryRoot _$FetchRecent$QueryRootFromJson(
        Map<String, dynamic> json) =>
    FetchRecent$QueryRoot()
      ..job = (json['job'] as List<dynamic>)
          .map((e) =>
              FetchRecent$QueryRoot$Job.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$FetchRecent$QueryRootToJson(
        FetchRecent$QueryRoot instance) =>
    <String, dynamic>{
      'job': instance.job.map((e) => e.toJson()).toList(),
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
      ..country = fromGraphQLBpcharToDartString(json['country'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object)
      ..skills = fromGraphQL$textToDartListString(json['skills'] as Object)
      ..contacts = fromGraphQL$textToDartListString(json['contacts'] as Object)
      ..tags = fromGraphQL$textToDartListString(json['tags'] as Object)
      ..russianDescription = json['russian_description'] as String
      ..isRussian = json['is_russian'] as bool
      ..englishDescription = json['english_description'] as String
      ..isEnglish = json['is_english'] as bool;

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
      'country': fromDartStringToGraphQLBpchar(instance.country),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
      'skills': fromDartListStringToGraphQL$text(instance.skills),
      'contacts': fromDartListStringToGraphQL$text(instance.contacts),
      'tags': fromDartListStringToGraphQL$text(instance.tags),
      'russian_description': instance.russianDescription,
      'is_russian': instance.isRussian,
      'english_description': instance.englishDescription,
      'is_english': instance.isEnglish,
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

InsertJob$MutationRoot$Job _$InsertJob$MutationRoot$JobFromJson(
        Map<String, dynamic> json) =>
    InsertJob$MutationRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool
      ..title = json['title'] as String
      ..company = json['company'] as String
      ..country = fromGraphQLBpcharToDartString(json['country'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object)
      ..skills = fromGraphQL$textToDartListString(json['skills'] as Object)
      ..contacts = fromGraphQL$textToDartListString(json['contacts'] as Object)
      ..tags = fromGraphQL$textToDartListString(json['tags'] as Object)
      ..russianDescription = json['russian_description'] as String
      ..isRussian = json['is_russian'] as bool
      ..englishDescription = json['english_description'] as String
      ..isEnglish = json['is_english'] as bool;

Map<String, dynamic> _$InsertJob$MutationRoot$JobToJson(
        InsertJob$MutationRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
      'title': instance.title,
      'company': instance.company,
      'country': fromDartStringToGraphQLBpchar(instance.country),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
      'skills': fromDartListStringToGraphQL$text(instance.skills),
      'contacts': fromDartListStringToGraphQL$text(instance.contacts),
      'tags': fromDartListStringToGraphQL$text(instance.tags),
      'russian_description': instance.russianDescription,
      'is_russian': instance.isRussian,
      'english_description': instance.englishDescription,
      'is_english': instance.isEnglish,
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
      ..country = fromGraphQLBpcharToDartString(json['country'] as String)
      ..address = json['address'] as String
      ..remote = json['remote'] as bool
      ..relocation =
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String)
      ..employments = fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object)
      ..levels =
          fromGraphQL$levelToDartListDeveloperLevel(json['levels'] as Object)
      ..isEnglish = json['is_english'] as bool
      ..isRussian = json['is_russian'] as bool;

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
      'country': fromDartStringToGraphQLBpchar(instance.country),
      'address': instance.address,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListDeveloperLevelToGraphQL$level(instance.levels),
      'is_english': instance.isEnglish,
      'is_russian': instance.isRussian,
    };

Paginate$QueryRoot _$Paginate$QueryRootFromJson(Map<String, dynamic> json) =>
    Paginate$QueryRoot()
      ..job = (json['job'] as List<dynamic>)
          .map(
              (e) => Paginate$QueryRoot$Job.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$Paginate$QueryRootToJson(Paginate$QueryRoot instance) =>
    <String, dynamic>{
      'job': instance.job.map((e) => e.toJson()).toList(),
    };

UpdateJob$MutationRoot$Job _$UpdateJob$MutationRoot$JobFromJson(
        Map<String, dynamic> json) =>
    UpdateJob$MutationRoot$Job()
      ..id = json['id'] as int
      ..creatorId = json['creator_id'] as String
      ..created = fromGraphQLTimestampToDartDateTime(json['created'] as String)
      ..updated = fromGraphQLTimestampToDartDateTime(json['updated'] as String)
      ..deletionMark = json['deletion_mark'] as bool;

Map<String, dynamic> _$UpdateJob$MutationRoot$JobToJson(
        UpdateJob$MutationRoot$Job instance) =>
    <String, dynamic>{
      'id': instance.id,
      'creator_id': instance.creatorId,
      'created': fromDartDateTimeToGraphQLTimestamp(instance.created),
      'updated': fromDartDateTimeToGraphQLTimestamp(instance.updated),
      'deletion_mark': instance.deletionMark,
    };

UpdateJob$MutationRoot _$UpdateJob$MutationRootFromJson(
        Map<String, dynamic> json) =>
    UpdateJob$MutationRoot()
      ..updateJobByPk = json['update_job_by_pk'] == null
          ? null
          : UpdateJob$MutationRoot$Job.fromJson(
              json['update_job_by_pk'] as Map<String, dynamic>);

Map<String, dynamic> _$UpdateJob$MutationRootToJson(
        UpdateJob$MutationRoot instance) =>
    <String, dynamic>{
      'update_job_by_pk': instance.updateJobByPk?.toJson(),
    };

JobSetInput _$JobSetInputFromJson(Map<String, dynamic> json) => JobSetInput(
      address: json['address'] as String?,
      company: json['company'] as String?,
      contacts:
          fromGraphQL$textNullableToDartListNullableString(json['contacts']),
      country: fromGraphQLBpcharNullableToDartStringNullable(
          json['country'] as String?),
      deletionMark: json['deletion_mark'] as bool?,
      employments: fromGraphQL$employmentNullableToDartListNullableEmployment(
          json['employments']),
      englishDescription: json['english_description'] as String?,
      isEnglish: json['is_english'] as bool?,
      isRussian: json['is_russian'] as bool?,
      levels: fromGraphQL$levelNullableToDartListNullableDeveloperLevel(
          json['levels']),
      relocation: fromGraphQLRelocationNullableToDartRelocationNullable(
          json['relocation'] as String?),
      remote: json['remote'] as bool?,
      russianDescription: json['russian_description'] as String?,
      skills: fromGraphQL$textNullableToDartListNullableString(json['skills']),
      tags: fromGraphQL$textNullableToDartListNullableString(json['tags']),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$JobSetInputToJson(JobSetInput instance) =>
    <String, dynamic>{
      'address': instance.address,
      'company': instance.company,
      'contacts':
          fromDartListNullableStringToGraphQL$textNullable(instance.contacts),
      'country':
          fromDartStringNullableToGraphQLBpcharNullable(instance.country),
      'deletion_mark': instance.deletionMark,
      'employments': fromDartListNullableEmploymentToGraphQL$employmentNullable(
          instance.employments),
      'english_description': instance.englishDescription,
      'is_english': instance.isEnglish,
      'is_russian': instance.isRussian,
      'levels': fromDartListNullableDeveloperLevelToGraphQL$levelNullable(
          instance.levels),
      'relocation': fromDartRelocationNullableToGraphQLRelocationNullable(
          instance.relocation),
      'remote': instance.remote,
      'russian_description': instance.russianDescription,
      'skills':
          fromDartListNullableStringToGraphQL$textNullable(instance.skills),
      'tags': fromDartListNullableStringToGraphQL$textNullable(instance.tags),
      'title': instance.title,
    };

FetchRecentArguments _$FetchRecentArgumentsFromJson(
        Map<String, dynamic> json) =>
    FetchRecentArguments(
      after: fromGraphQLTimestampToDartDateTime(json['after'] as String),
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$FetchRecentArgumentsToJson(
        FetchRecentArguments instance) =>
    <String, dynamic>{
      'after': fromDartDateTimeToGraphQLTimestamp(instance.after),
      'limit': instance.limit,
    };

GetJobArguments _$GetJobArgumentsFromJson(Map<String, dynamic> json) =>
    GetJobArguments(
      id: json['id'] as int,
    );

Map<String, dynamic> _$GetJobArgumentsToJson(GetJobArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

InsertJobArguments _$InsertJobArgumentsFromJson(Map<String, dynamic> json) =>
    InsertJobArguments(
      title: json['title'] as String,
      company: json['company'] as String,
      country: fromGraphQLBpcharToDartString(json['country'] as String),
      address: json['address'] as String,
      creator_id: json['creator_id'] as String,
      remote: json['remote'] as bool,
      relocation:
          fromGraphQLRelocationToDartRelocation(json['relocation'] as String),
      english_description: json['english_description'] as String,
      is_english: json['is_english'] as bool,
      russian_description: json['russian_description'] as String,
      is_russian: json['is_russian'] as bool,
      contacts: fromGraphQL$textToDartListString(json['contacts'] as Object),
      employments: fromGraphQL$employmentToDartListEmployment(
          json['employments'] as Object),
      levels: fromGraphQL$levelNullableToDartListNullableDeveloperLevel(
          json['levels']),
      skills: fromGraphQL$textNullableToDartListNullableString(json['skills']),
      tags: fromGraphQL$textNullableToDartListNullableString(json['tags']),
    );

Map<String, dynamic> _$InsertJobArgumentsToJson(InsertJobArguments instance) =>
    <String, dynamic>{
      'title': instance.title,
      'company': instance.company,
      'country': fromDartStringToGraphQLBpchar(instance.country),
      'address': instance.address,
      'creator_id': instance.creator_id,
      'remote': instance.remote,
      'relocation': fromDartRelocationToGraphQLRelocation(instance.relocation),
      'english_description': instance.english_description,
      'is_english': instance.is_english,
      'russian_description': instance.russian_description,
      'is_russian': instance.is_russian,
      'contacts': fromDartListStringToGraphQL$text(instance.contacts),
      'employments':
          fromDartListEmploymentToGraphQL$employment(instance.employments),
      'levels': fromDartListNullableDeveloperLevelToGraphQL$levelNullable(
          instance.levels),
      'skills':
          fromDartListNullableStringToGraphQL$textNullable(instance.skills),
      'tags': fromDartListNullableStringToGraphQL$textNullable(instance.tags),
    };

PaginateArguments _$PaginateArgumentsFromJson(Map<String, dynamic> json) =>
    PaginateArguments(
      before: fromGraphQLTimestampToDartDateTime(json['before'] as String),
      limit: json['limit'] as int,
    );

Map<String, dynamic> _$PaginateArgumentsToJson(PaginateArguments instance) =>
    <String, dynamic>{
      'before': fromDartDateTimeToGraphQLTimestamp(instance.before),
      'limit': instance.limit,
    };

UpdateJobArguments _$UpdateJobArgumentsFromJson(Map<String, dynamic> json) =>
    UpdateJobArguments(
      id: json['id'] as int,
      data: JobSetInput.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UpdateJobArgumentsToJson(UpdateJobArguments instance) =>
    <String, dynamic>{
      'id': instance.id,
      'data': instance.data.toJson(),
    };
