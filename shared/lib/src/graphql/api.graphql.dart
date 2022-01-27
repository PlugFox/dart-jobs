// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:dart_jobs_shared/util.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/employment.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/int_array.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/level.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/text.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/bpchar.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/relocation.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/timestamp.dart';
part 'api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class GetJob$QueryRoot$Job$JobDescriptionEnglish extends JsonSerializable
    with EquatableMixin {
  GetJob$QueryRoot$Job$JobDescriptionEnglish();

  factory GetJob$QueryRoot$Job$JobDescriptionEnglish.fromJson(
          Map<String, dynamic> json) =>
      _$GetJob$QueryRoot$Job$JobDescriptionEnglishFromJson(json);

  late String description;

  @override
  List<Object?> get props => [description];
  @override
  Map<String, dynamic> toJson() =>
      _$GetJob$QueryRoot$Job$JobDescriptionEnglishToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetJob$QueryRoot$Job$JobDescriptionRussian extends JsonSerializable
    with EquatableMixin {
  GetJob$QueryRoot$Job$JobDescriptionRussian();

  factory GetJob$QueryRoot$Job$JobDescriptionRussian.fromJson(
          Map<String, dynamic> json) =>
      _$GetJob$QueryRoot$Job$JobDescriptionRussianFromJson(json);

  late String description;

  @override
  List<Object?> get props => [description];
  @override
  Map<String, dynamic> toJson() =>
      _$GetJob$QueryRoot$Job$JobDescriptionRussianToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetJob$QueryRoot$Job$JobSkills extends JsonSerializable
    with EquatableMixin {
  GetJob$QueryRoot$Job$JobSkills();

  factory GetJob$QueryRoot$Job$JobSkills.fromJson(Map<String, dynamic> json) =>
      _$GetJob$QueryRoot$Job$JobSkillsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> skills;

  @override
  List<Object?> get props => [skills];
  @override
  Map<String, dynamic> toJson() => _$GetJob$QueryRoot$Job$JobSkillsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetJob$QueryRoot$Job$JobContacts extends JsonSerializable
    with EquatableMixin {
  GetJob$QueryRoot$Job$JobContacts();

  factory GetJob$QueryRoot$Job$JobContacts.fromJson(
          Map<String, dynamic> json) =>
      _$GetJob$QueryRoot$Job$JobContactsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> contacts;

  @override
  List<Object?> get props => [contacts];
  @override
  Map<String, dynamic> toJson() =>
      _$GetJob$QueryRoot$Job$JobContactsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetJob$QueryRoot$Job$JobTags extends JsonSerializable
    with EquatableMixin {
  GetJob$QueryRoot$Job$JobTags();

  factory GetJob$QueryRoot$Job$JobTags.fromJson(Map<String, dynamic> json) =>
      _$GetJob$QueryRoot$Job$JobTagsFromJson(json);

  late String tag;

  @override
  List<Object?> get props => [tag];
  @override
  Map<String, dynamic> toJson() => _$GetJob$QueryRoot$Job$JobTagsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetJob$QueryRoot$Job extends JsonSerializable with EquatableMixin {
  GetJob$QueryRoot$Job();

  factory GetJob$QueryRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$GetJob$QueryRoot$JobFromJson(json);

  late int id;

  @JsonKey(name: 'creator_id')
  late String creatorId;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime created;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime updated;

  @JsonKey(name: 'deletion_mark')
  late bool deletionMark;

  late String title;

  late String company;

  @JsonKey(
      name: 'country_code',
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String countryCode;

  late String address;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQLRelocationToDartRelocation,
      toJson: fromDartRelocationToGraphQLRelocation)
  late Relocation relocation;

  @JsonKey(
      fromJson: fromGraphQL$employmentToDartListEmployment,
      toJson: fromDartListEmploymentToGraphQL$employment)
  late List<Employment> employments;

  @JsonKey(
      fromJson: fromGraphQL$levelToDartListDeveloperLevel,
      toJson: fromDartListDeveloperLevelToGraphQL$level)
  late List<DeveloperLevel> levels;

  @JsonKey(name: 'description_english')
  GetJob$QueryRoot$Job$JobDescriptionEnglish? descriptionEnglish;

  @JsonKey(name: 'description_russian')
  GetJob$QueryRoot$Job$JobDescriptionRussian? descriptionRussian;

  @JsonKey(name: 'job_skills')
  GetJob$QueryRoot$Job$JobSkills? jobSkills;

  @JsonKey(name: 'job_contacts')
  GetJob$QueryRoot$Job$JobContacts? jobContacts;

  @JsonKey(name: 'job_tags')
  late List<GetJob$QueryRoot$Job$JobTags> jobTags;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        countryCode,
        address,
        remote,
        relocation,
        employments,
        levels,
        descriptionEnglish,
        descriptionRussian,
        jobSkills,
        jobContacts,
        jobTags
      ];
  @override
  Map<String, dynamic> toJson() => _$GetJob$QueryRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetJob$QueryRoot extends JsonSerializable with EquatableMixin {
  GetJob$QueryRoot();

  factory GetJob$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$GetJob$QueryRootFromJson(json);

  @JsonKey(name: 'job_by_pk')
  GetJob$QueryRoot$Job? jobByPk;

  @override
  List<Object?> get props => [jobByPk];
  @override
  Map<String, dynamic> toJson() => _$GetJob$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Paginate$QueryRoot$Job extends JsonSerializable with EquatableMixin {
  Paginate$QueryRoot$Job();

  factory Paginate$QueryRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$Paginate$QueryRoot$JobFromJson(json);

  late int id;

  @JsonKey(name: 'creator_id')
  late String creatorId;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime created;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime updated;

  @JsonKey(name: 'deletion_mark')
  late bool deletionMark;

  late String title;

  late String company;

  @JsonKey(
      name: 'country_code',
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String countryCode;

  late String address;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQLRelocationToDartRelocation,
      toJson: fromDartRelocationToGraphQLRelocation)
  late Relocation relocation;

  @JsonKey(
      fromJson: fromGraphQL$employmentToDartListEmployment,
      toJson: fromDartListEmploymentToGraphQL$employment)
  late List<Employment> employments;

  @JsonKey(
      fromJson: fromGraphQL$levelToDartListDeveloperLevel,
      toJson: fromDartListDeveloperLevelToGraphQL$level)
  late List<DeveloperLevel> levels;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        countryCode,
        address,
        remote,
        relocation,
        employments,
        levels
      ];
  @override
  Map<String, dynamic> toJson() => _$Paginate$QueryRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Paginate$QueryRoot extends JsonSerializable with EquatableMixin {
  Paginate$QueryRoot();

  factory Paginate$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Paginate$QueryRootFromJson(json);

  @JsonKey(name: 'job_paginate')
  late List<Paginate$QueryRoot$Job> jobPaginate;

  @override
  List<Object?> get props => [jobPaginate];
  @override
  Map<String, dynamic> toJson() => _$Paginate$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot$Job extends JsonSerializable with EquatableMixin {
  UpdateJob$MutationRoot$Job();

  factory UpdateJob$MutationRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$UpdateJob$MutationRoot$JobFromJson(json);

  late int id;

  @JsonKey(name: 'creator_id')
  late String creatorId;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime created;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime updated;

  @JsonKey(name: 'deletion_mark')
  late bool deletionMark;

  late String title;

  late String company;

  @JsonKey(
      name: 'country_code',
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String countryCode;

  late String address;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQLRelocationToDartRelocation,
      toJson: fromDartRelocationToGraphQLRelocation)
  late Relocation relocation;

  @JsonKey(
      fromJson: fromGraphQL$employmentToDartListEmployment,
      toJson: fromDartListEmploymentToGraphQL$employment)
  late List<Employment> employments;

  @JsonKey(
      fromJson: fromGraphQL$levelToDartListDeveloperLevel,
      toJson: fromDartListDeveloperLevelToGraphQL$level)
  late List<DeveloperLevel> levels;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        countryCode,
        address,
        remote,
        relocation,
        employments,
        levels
      ];
  @override
  Map<String, dynamic> toJson() => _$UpdateJob$MutationRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot$JobDescriptionEnglish extends JsonSerializable
    with EquatableMixin {
  UpdateJob$MutationRoot$JobDescriptionEnglish();

  factory UpdateJob$MutationRoot$JobDescriptionEnglish.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateJob$MutationRoot$JobDescriptionEnglishFromJson(json);

  late String description;

  @override
  List<Object?> get props => [description];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateJob$MutationRoot$JobDescriptionEnglishToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot$JobDescriptionRussian extends JsonSerializable
    with EquatableMixin {
  UpdateJob$MutationRoot$JobDescriptionRussian();

  factory UpdateJob$MutationRoot$JobDescriptionRussian.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateJob$MutationRoot$JobDescriptionRussianFromJson(json);

  late String description;

  @override
  List<Object?> get props => [description];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateJob$MutationRoot$JobDescriptionRussianToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot$JobContacts extends JsonSerializable
    with EquatableMixin {
  UpdateJob$MutationRoot$JobContacts();

  factory UpdateJob$MutationRoot$JobContacts.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateJob$MutationRoot$JobContactsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> contacts;

  @override
  List<Object?> get props => [contacts];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateJob$MutationRoot$JobContactsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot$JobSkills extends JsonSerializable
    with EquatableMixin {
  UpdateJob$MutationRoot$JobSkills();

  factory UpdateJob$MutationRoot$JobSkills.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateJob$MutationRoot$JobSkillsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> skills;

  @override
  List<Object?> get props => [skills];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateJob$MutationRoot$JobSkillsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot$JobTagsMutationResponse$JobTags
    extends JsonSerializable with EquatableMixin {
  UpdateJob$MutationRoot$JobTagsMutationResponse$JobTags();

  factory UpdateJob$MutationRoot$JobTagsMutationResponse$JobTags.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateJob$MutationRoot$JobTagsMutationResponse$JobTagsFromJson(json);

  late String tag;

  @override
  List<Object?> get props => [tag];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateJob$MutationRoot$JobTagsMutationResponse$JobTagsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot$JobTagsMutationResponse extends JsonSerializable
    with EquatableMixin {
  UpdateJob$MutationRoot$JobTagsMutationResponse();

  factory UpdateJob$MutationRoot$JobTagsMutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$UpdateJob$MutationRoot$JobTagsMutationResponseFromJson(json);

  late List<UpdateJob$MutationRoot$JobTagsMutationResponse$JobTags> returning;

  @override
  List<Object?> get props => [returning];
  @override
  Map<String, dynamic> toJson() =>
      _$UpdateJob$MutationRoot$JobTagsMutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot extends JsonSerializable with EquatableMixin {
  UpdateJob$MutationRoot();

  factory UpdateJob$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$UpdateJob$MutationRootFromJson(json);

  @JsonKey(name: 'update_job_by_pk')
  UpdateJob$MutationRoot$Job? updateJobByPk;

  @JsonKey(name: 'update_job_description_english_by_pk')
  UpdateJob$MutationRoot$JobDescriptionEnglish? updateJobDescriptionEnglishByPk;

  @JsonKey(name: 'update_job_description_russian_by_pk')
  UpdateJob$MutationRoot$JobDescriptionRussian? updateJobDescriptionRussianByPk;

  @JsonKey(name: 'update_job_contacts_by_pk')
  UpdateJob$MutationRoot$JobContacts? updateJobContactsByPk;

  @JsonKey(name: 'update_job_skills_by_pk')
  UpdateJob$MutationRoot$JobSkills? updateJobSkillsByPk;

  @JsonKey(name: 'update_job_tags')
  UpdateJob$MutationRoot$JobTagsMutationResponse? updateJobTags;

  @override
  List<Object?> get props => [
        updateJobByPk,
        updateJobDescriptionEnglishByPk,
        updateJobDescriptionRussianByPk,
        updateJobContactsByPk,
        updateJobSkillsByPk,
        updateJobTags
      ];
  @override
  Map<String, dynamic> toJson() => _$UpdateJob$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class JobSetInput extends JsonSerializable with EquatableMixin {
  JobSetInput(
      {this.address,
      this.company,
      this.countryCode,
      this.deletionMark,
      this.employments,
      this.levels,
      this.relocation,
      this.remote,
      this.title});

  factory JobSetInput.fromJson(Map<String, dynamic> json) =>
      _$JobSetInputFromJson(json);

  String? address;

  String? company;

  @JsonKey(
      name: 'country_code',
      fromJson: fromGraphQLBpcharNullableToDartStringNullable,
      toJson: fromDartStringNullableToGraphQLBpcharNullable)
  String? countryCode;

  @JsonKey(name: 'deletion_mark')
  bool? deletionMark;

  @JsonKey(
      fromJson: fromGraphQL$employmentNullableToDartListNullableEmployment,
      toJson: fromDartListNullableEmploymentToGraphQL$employmentNullable)
  List<Employment>? employments;

  @JsonKey(
      fromJson: fromGraphQL$levelNullableToDartListNullableDeveloperLevel,
      toJson: fromDartListNullableDeveloperLevelToGraphQL$levelNullable)
  List<DeveloperLevel>? levels;

  @JsonKey(
      fromJson: fromGraphQLRelocationNullableToDartRelocationNullable,
      toJson: fromDartRelocationNullableToGraphQLRelocationNullable)
  Relocation? relocation;

  bool? remote;

  String? title;

  @override
  List<Object?> get props => [
        address,
        company,
        countryCode,
        deletionMark,
        employments,
        levels,
        relocation,
        remote,
        title
      ];
  @override
  Map<String, dynamic> toJson() => _$JobSetInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Recent$QueryRoot$Job extends JsonSerializable with EquatableMixin {
  Recent$QueryRoot$Job();

  factory Recent$QueryRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$Recent$QueryRoot$JobFromJson(json);

  late int id;

  @JsonKey(name: 'creator_id')
  late String creatorId;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime created;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime updated;

  @JsonKey(name: 'deletion_mark')
  late bool deletionMark;

  late String title;

  late String company;

  @JsonKey(
      name: 'country_code',
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String countryCode;

  late String address;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQLRelocationToDartRelocation,
      toJson: fromDartRelocationToGraphQLRelocation)
  late Relocation relocation;

  @JsonKey(
      fromJson: fromGraphQL$employmentToDartListEmployment,
      toJson: fromDartListEmploymentToGraphQL$employment)
  late List<Employment> employments;

  @JsonKey(
      fromJson: fromGraphQL$levelToDartListDeveloperLevel,
      toJson: fromDartListDeveloperLevelToGraphQL$level)
  late List<DeveloperLevel> levels;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        countryCode,
        address,
        remote,
        relocation,
        employments,
        levels
      ];
  @override
  Map<String, dynamic> toJson() => _$Recent$QueryRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Recent$QueryRoot extends JsonSerializable with EquatableMixin {
  Recent$QueryRoot();

  factory Recent$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Recent$QueryRootFromJson(json);

  @JsonKey(name: 'job_recent')
  late List<Recent$QueryRoot$Job> jobRecent;

  @override
  List<Object?> get props => [jobRecent];
  @override
  Map<String, dynamic> toJson() => _$Recent$QueryRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteJob$MutationRoot$Job extends JsonSerializable with EquatableMixin {
  DeleteJob$MutationRoot$Job();

  factory DeleteJob$MutationRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$DeleteJob$MutationRoot$JobFromJson(json);

  late int id;

  @JsonKey(name: 'creator_id')
  late String creatorId;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime created;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime updated;

  @JsonKey(name: 'deletion_mark')
  late bool deletionMark;

  late String title;

  late String company;

  @JsonKey(
      name: 'country_code',
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String countryCode;

  late String address;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQLRelocationToDartRelocation,
      toJson: fromDartRelocationToGraphQLRelocation)
  late Relocation relocation;

  @JsonKey(
      fromJson: fromGraphQL$employmentToDartListEmployment,
      toJson: fromDartListEmploymentToGraphQL$employment)
  late List<Employment> employments;

  @JsonKey(
      fromJson: fromGraphQL$levelToDartListDeveloperLevel,
      toJson: fromDartListDeveloperLevelToGraphQL$level)
  late List<DeveloperLevel> levels;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        countryCode,
        address,
        remote,
        relocation,
        employments,
        levels
      ];
  @override
  Map<String, dynamic> toJson() => _$DeleteJob$MutationRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteJob$MutationRoot$JobDescriptionEnglish extends JsonSerializable
    with EquatableMixin {
  DeleteJob$MutationRoot$JobDescriptionEnglish();

  factory DeleteJob$MutationRoot$JobDescriptionEnglish.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteJob$MutationRoot$JobDescriptionEnglishFromJson(json);

  late String description;

  @override
  List<Object?> get props => [description];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteJob$MutationRoot$JobDescriptionEnglishToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteJob$MutationRoot$JobDescriptionRussian extends JsonSerializable
    with EquatableMixin {
  DeleteJob$MutationRoot$JobDescriptionRussian();

  factory DeleteJob$MutationRoot$JobDescriptionRussian.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteJob$MutationRoot$JobDescriptionRussianFromJson(json);

  late String description;

  @override
  List<Object?> get props => [description];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteJob$MutationRoot$JobDescriptionRussianToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteJob$MutationRoot$JobContacts extends JsonSerializable
    with EquatableMixin {
  DeleteJob$MutationRoot$JobContacts();

  factory DeleteJob$MutationRoot$JobContacts.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteJob$MutationRoot$JobContactsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> contacts;

  @override
  List<Object?> get props => [contacts];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteJob$MutationRoot$JobContactsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteJob$MutationRoot$JobSkills extends JsonSerializable
    with EquatableMixin {
  DeleteJob$MutationRoot$JobSkills();

  factory DeleteJob$MutationRoot$JobSkills.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteJob$MutationRoot$JobSkillsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> skills;

  @override
  List<Object?> get props => [skills];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteJob$MutationRoot$JobSkillsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteJob$MutationRoot$JobTagsMutationResponse$JobTags
    extends JsonSerializable with EquatableMixin {
  DeleteJob$MutationRoot$JobTagsMutationResponse$JobTags();

  factory DeleteJob$MutationRoot$JobTagsMutationResponse$JobTags.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteJob$MutationRoot$JobTagsMutationResponse$JobTagsFromJson(json);

  late String tag;

  @override
  List<Object?> get props => [tag];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteJob$MutationRoot$JobTagsMutationResponse$JobTagsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteJob$MutationRoot$JobTagsMutationResponse extends JsonSerializable
    with EquatableMixin {
  DeleteJob$MutationRoot$JobTagsMutationResponse();

  factory DeleteJob$MutationRoot$JobTagsMutationResponse.fromJson(
          Map<String, dynamic> json) =>
      _$DeleteJob$MutationRoot$JobTagsMutationResponseFromJson(json);

  late List<DeleteJob$MutationRoot$JobTagsMutationResponse$JobTags> returning;

  @override
  List<Object?> get props => [returning];
  @override
  Map<String, dynamic> toJson() =>
      _$DeleteJob$MutationRoot$JobTagsMutationResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class DeleteJob$MutationRoot extends JsonSerializable with EquatableMixin {
  DeleteJob$MutationRoot();

  factory DeleteJob$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$DeleteJob$MutationRootFromJson(json);

  @JsonKey(name: 'update_job_by_pk')
  DeleteJob$MutationRoot$Job? updateJobByPk;

  @JsonKey(name: 'update_job_description_english_by_pk')
  DeleteJob$MutationRoot$JobDescriptionEnglish? updateJobDescriptionEnglishByPk;

  @JsonKey(name: 'update_job_description_russian_by_pk')
  DeleteJob$MutationRoot$JobDescriptionRussian? updateJobDescriptionRussianByPk;

  @JsonKey(name: 'update_job_contacts_by_pk')
  DeleteJob$MutationRoot$JobContacts? updateJobContactsByPk;

  @JsonKey(name: 'update_job_skills_by_pk')
  DeleteJob$MutationRoot$JobSkills? updateJobSkillsByPk;

  @JsonKey(name: 'update_job_tags')
  DeleteJob$MutationRoot$JobTagsMutationResponse? updateJobTags;

  @override
  List<Object?> get props => [
        updateJobByPk,
        updateJobDescriptionEnglishByPk,
        updateJobDescriptionRussianByPk,
        updateJobContactsByPk,
        updateJobSkillsByPk,
        updateJobTags
      ];
  @override
  Map<String, dynamic> toJson() => _$DeleteJob$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateJob$MutationRoot$Job extends JsonSerializable with EquatableMixin {
  CreateJob$MutationRoot$Job();

  factory CreateJob$MutationRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$CreateJob$MutationRoot$JobFromJson(json);

  late int id;

  @JsonKey(name: 'creator_id')
  late String creatorId;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime created;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime updated;

  @JsonKey(name: 'deletion_mark')
  late bool deletionMark;

  late String title;

  late String company;

  @JsonKey(
      name: 'country_code',
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String countryCode;

  late String address;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQLRelocationToDartRelocation,
      toJson: fromDartRelocationToGraphQLRelocation)
  late Relocation relocation;

  @JsonKey(
      fromJson: fromGraphQL$employmentToDartListEmployment,
      toJson: fromDartListEmploymentToGraphQL$employment)
  late List<Employment> employments;

  @JsonKey(
      fromJson: fromGraphQL$levelToDartListDeveloperLevel,
      toJson: fromDartListDeveloperLevelToGraphQL$level)
  late List<DeveloperLevel> levels;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        countryCode,
        address,
        remote,
        relocation,
        employments,
        levels
      ];
  @override
  Map<String, dynamic> toJson() => _$CreateJob$MutationRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class CreateJob$MutationRoot extends JsonSerializable with EquatableMixin {
  CreateJob$MutationRoot();

  factory CreateJob$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$CreateJob$MutationRootFromJson(json);

  @JsonKey(name: 'job_create')
  late List<CreateJob$MutationRoot$Job> jobCreate;

  @override
  List<Object?> get props => [jobCreate];
  @override
  Map<String, dynamic> toJson() => _$CreateJob$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GetJobArguments extends JsonSerializable with EquatableMixin {
  GetJobArguments({required this.id});

  @override
  factory GetJobArguments.fromJson(Map<String, dynamic> json) =>
      _$GetJobArgumentsFromJson(json);

  late int id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$GetJobArgumentsToJson(this);
}

final GET_JOB_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'GetJob'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'job_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'id'),
                  value: VariableNode(name: NameNode(value: 'id')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'creator_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'created'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'updated'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'deletion_mark'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'company'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'country_code'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'address'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'remote'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'relocation'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'employments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'levels'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'description_english'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'description'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'description_russian'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'description'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'job_skills'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'skills'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'job_contacts'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'contacts'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ])),
              FieldNode(
                  name: NameNode(value: 'job_tags'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'tag'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class GetJobQuery extends GraphQLQuery<GetJob$QueryRoot, GetJobArguments> {
  GetJobQuery({required this.variables});

  @override
  final DocumentNode document = GET_JOB_QUERY_DOCUMENT;

  @override
  final String operationName = 'GetJob';

  @override
  final GetJobArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  GetJob$QueryRoot parse(Map<String, dynamic> json) =>
      GetJob$QueryRoot.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class PaginateArguments extends JsonSerializable with EquatableMixin {
  PaginateArguments(
      {required this.before,
      required this.exclude,
      this.remote,
      this.country,
      this.level,
      this.employment,
      this.relocation,
      required this.limit});

  @override
  factory PaginateArguments.fromJson(Map<String, dynamic> json) =>
      _$PaginateArgumentsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime before;

  @JsonKey(
      fromJson: fromGraphQL$int4ToDartListint,
      toJson: fromDartListintToGraphQL$int4)
  late List<int> exclude;

  final bool? remote;

  final String? country;

  @JsonKey(
      fromJson: fromGraphQLLevelNullableToDartDeveloperLevelNullable,
      toJson: fromDartDeveloperLevelNullableToGraphQLLevelNullable)
  final DeveloperLevel? level;

  @JsonKey(
      fromJson: fromGraphQLEmploymentNullableToDartEmploymentNullable,
      toJson: fromDartEmploymentNullableToGraphQLEmploymentNullable)
  final Employment? employment;

  final bool? relocation;

  late int limit;

  @override
  List<Object?> get props =>
      [before, exclude, remote, country, level, employment, relocation, limit];
  @override
  Map<String, dynamic> toJson() => _$PaginateArgumentsToJson(this);
}

final PAGINATE_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Paginate'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'before')),
            type: NamedTypeNode(
                name: NameNode(value: 'timestamp'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'exclude')),
            type:
                NamedTypeNode(name: NameNode(value: '_int4'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'remote')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'country')),
            type: NamedTypeNode(
                name: NameNode(value: 'String'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'level')),
            type:
                NamedTypeNode(name: NameNode(value: 'level'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'employment')),
            type: NamedTypeNode(
                name: NameNode(value: 'employment'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'relocation')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '100')),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'job_paginate'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'args'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_before'),
                        value: VariableNode(name: NameNode(value: 'before'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_limit'),
                        value: VariableNode(name: NameNode(value: 'limit'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_exclude'),
                        value: VariableNode(name: NameNode(value: 'exclude'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_remote'),
                        value: VariableNode(name: NameNode(value: 'remote'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_country_code'),
                        value: VariableNode(name: NameNode(value: 'country'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_level'),
                        value: VariableNode(name: NameNode(value: 'level'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_employment'),
                        value:
                            VariableNode(name: NameNode(value: 'employment'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_relocation'),
                        value:
                            VariableNode(name: NameNode(value: 'relocation')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'creator_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'created'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'updated'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'deletion_mark'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'company'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'country_code'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'address'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'remote'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'relocation'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'employments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'levels'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class PaginateQuery
    extends GraphQLQuery<Paginate$QueryRoot, PaginateArguments> {
  PaginateQuery({required this.variables});

  @override
  final DocumentNode document = PAGINATE_QUERY_DOCUMENT;

  @override
  final String operationName = 'Paginate';

  @override
  final PaginateArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Paginate$QueryRoot parse(Map<String, dynamic> json) =>
      Paginate$QueryRoot.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class UpdateJobArguments extends JsonSerializable with EquatableMixin {
  UpdateJobArguments(
      {required this.id,
      required this.data,
      required this.description_english,
      required this.description_russian,
      this.contacts,
      this.skills});

  @override
  factory UpdateJobArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateJobArgumentsFromJson(json);

  late int id;

  late JobSetInput data;

  late String description_english;

  late String description_russian;

  @JsonKey(
      fromJson: fromGraphQL$textNullableToDartListNullableString,
      toJson: fromDartListNullableStringToGraphQL$textNullable)
  final List<String>? contacts;

  @JsonKey(
      fromJson: fromGraphQL$textNullableToDartListNullableString,
      toJson: fromDartListNullableStringToGraphQL$textNullable)
  final List<String>? skills;

  @override
  List<Object?> get props =>
      [id, data, description_english, description_russian, contacts, skills];
  @override
  Map<String, dynamic> toJson() => _$UpdateJobArgumentsToJson(this);
}

final UPDATE_JOB_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'UpdateJob'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'data')),
            type: NamedTypeNode(
                name: NameNode(value: 'job_set_input'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable:
                VariableNode(name: NameNode(value: 'description_english')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable:
                VariableNode(name: NameNode(value: 'description_russian')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'contacts')),
            type:
                NamedTypeNode(name: NameNode(value: '_text'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'skills')),
            type:
                NamedTypeNode(name: NameNode(value: '_text'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'update_job_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: VariableNode(name: NameNode(value: 'data')))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'creator_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'created'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'updated'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'deletion_mark'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'company'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'country_code'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'address'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'remote'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'relocation'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'employments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'levels'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_description_english_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'description'),
                        value: VariableNode(
                            name: NameNode(value: 'description_english')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'description'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_description_russian_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'description'),
                        value: VariableNode(
                            name: NameNode(value: 'description_russian')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'description'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_contacts_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'contacts'),
                        value: VariableNode(name: NameNode(value: 'contacts')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'contacts'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_skills_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'skills'),
                        value: VariableNode(name: NameNode(value: 'skills')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'skills'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_tags'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'where'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: ObjectValueNode(fields: [
                          ObjectFieldNode(
                              name: NameNode(value: '_eq'),
                              value: VariableNode(name: NameNode(value: 'id')))
                        ]))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'tag'),
                        value: StringValueNode(value: '', isBlock: false))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'returning'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'tag'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class UpdateJobMutation
    extends GraphQLQuery<UpdateJob$MutationRoot, UpdateJobArguments> {
  UpdateJobMutation({required this.variables});

  @override
  final DocumentNode document = UPDATE_JOB_MUTATION_DOCUMENT;

  @override
  final String operationName = 'UpdateJob';

  @override
  final UpdateJobArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  UpdateJob$MutationRoot parse(Map<String, dynamic> json) =>
      UpdateJob$MutationRoot.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class RecentArguments extends JsonSerializable with EquatableMixin {
  RecentArguments(
      {required this.after,
      required this.exclude,
      this.remote,
      this.country,
      this.level,
      this.employment,
      this.relocation,
      required this.limit});

  @override
  factory RecentArguments.fromJson(Map<String, dynamic> json) =>
      _$RecentArgumentsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime after;

  @JsonKey(
      fromJson: fromGraphQL$int4ToDartListint,
      toJson: fromDartListintToGraphQL$int4)
  late List<int> exclude;

  final bool? remote;

  final String? country;

  @JsonKey(
      fromJson: fromGraphQLLevelNullableToDartDeveloperLevelNullable,
      toJson: fromDartDeveloperLevelNullableToGraphQLLevelNullable)
  final DeveloperLevel? level;

  @JsonKey(
      fromJson: fromGraphQLEmploymentNullableToDartEmploymentNullable,
      toJson: fromDartEmploymentNullableToGraphQLEmploymentNullable)
  final Employment? employment;

  final bool? relocation;

  late int limit;

  @override
  List<Object?> get props =>
      [after, exclude, remote, country, level, employment, relocation, limit];
  @override
  Map<String, dynamic> toJson() => _$RecentArgumentsToJson(this);
}

final RECENT_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'Recent'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'after')),
            type: NamedTypeNode(
                name: NameNode(value: 'timestamp'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'exclude')),
            type:
                NamedTypeNode(name: NameNode(value: '_int4'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'remote')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'country')),
            type: NamedTypeNode(
                name: NameNode(value: 'String'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'level')),
            type:
                NamedTypeNode(name: NameNode(value: 'level'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'employment')),
            type: NamedTypeNode(
                name: NameNode(value: 'employment'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'relocation')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '100')),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'job_recent'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'args'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_after'),
                        value: VariableNode(name: NameNode(value: 'after'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_limit'),
                        value: VariableNode(name: NameNode(value: 'limit'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_exclude'),
                        value: VariableNode(name: NameNode(value: 'exclude'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_remote'),
                        value: VariableNode(name: NameNode(value: 'remote'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_country_code'),
                        value: VariableNode(name: NameNode(value: 'country'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_level'),
                        value: VariableNode(name: NameNode(value: 'level'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_employment'),
                        value:
                            VariableNode(name: NameNode(value: 'employment'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'filter_relocation'),
                        value:
                            VariableNode(name: NameNode(value: 'relocation')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'creator_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'created'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'updated'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'deletion_mark'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'company'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'country_code'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'address'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'remote'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'relocation'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'employments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'levels'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class RecentQuery extends GraphQLQuery<Recent$QueryRoot, RecentArguments> {
  RecentQuery({required this.variables});

  @override
  final DocumentNode document = RECENT_QUERY_DOCUMENT;

  @override
  final String operationName = 'Recent';

  @override
  final RecentArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  Recent$QueryRoot parse(Map<String, dynamic> json) =>
      Recent$QueryRoot.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class DeleteJobArguments extends JsonSerializable with EquatableMixin {
  DeleteJobArguments({required this.id});

  @override
  factory DeleteJobArguments.fromJson(Map<String, dynamic> json) =>
      _$DeleteJobArgumentsFromJson(json);

  late int id;

  @override
  List<Object?> get props => [id];
  @override
  Map<String, dynamic> toJson() => _$DeleteJobArgumentsToJson(this);
}

final DELETE_JOB_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'DeleteJob'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'id')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'update_job_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'deletion_mark'),
                        value: BooleanValueNode(value: true)),
                    ObjectFieldNode(
                        name: NameNode(value: 'address'),
                        value: StringValueNode(value: '', isBlock: false)),
                    ObjectFieldNode(
                        name: NameNode(value: 'levels'),
                        value: StringValueNode(value: '{}', isBlock: false)),
                    ObjectFieldNode(
                        name: NameNode(value: 'employments'),
                        value: StringValueNode(value: '{}', isBlock: false))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'creator_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'created'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'updated'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'deletion_mark'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'company'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'country_code'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'address'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'remote'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'relocation'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'employments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'levels'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_description_english_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'description'),
                        value: StringValueNode(value: '', isBlock: false))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'description'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_description_russian_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'description'),
                        value: StringValueNode(value: '', isBlock: false))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'description'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_contacts_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'contacts'),
                        value: StringValueNode(value: '{}', isBlock: false))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'contacts'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_skills_by_pk'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'pk_columns'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: VariableNode(name: NameNode(value: 'id')))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'skills'),
                        value: StringValueNode(value: '{}', isBlock: false))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'skills'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ])),
        FieldNode(
            name: NameNode(value: 'update_job_tags'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'where'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'job_id'),
                        value: ObjectValueNode(fields: [
                          ObjectFieldNode(
                              name: NameNode(value: '_eq'),
                              value: VariableNode(name: NameNode(value: 'id')))
                        ]))
                  ])),
              ArgumentNode(
                  name: NameNode(value: '_set'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'tag'),
                        value: StringValueNode(value: '', isBlock: false))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'returning'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: SelectionSetNode(selections: [
                    FieldNode(
                        name: NameNode(value: 'tag'),
                        alias: null,
                        arguments: [],
                        directives: [],
                        selectionSet: null)
                  ]))
            ]))
      ]))
]);

class DeleteJobMutation
    extends GraphQLQuery<DeleteJob$MutationRoot, DeleteJobArguments> {
  DeleteJobMutation({required this.variables});

  @override
  final DocumentNode document = DELETE_JOB_MUTATION_DOCUMENT;

  @override
  final String operationName = 'DeleteJob';

  @override
  final DeleteJobArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  DeleteJob$MutationRoot parse(Map<String, dynamic> json) =>
      DeleteJob$MutationRoot.fromJson(json);
}

@JsonSerializable(explicitToJson: true)
class CreateJobArguments extends JsonSerializable with EquatableMixin {
  CreateJobArguments(
      {required this.title,
      required this.company,
      required this.country_code,
      required this.address,
      required this.remote,
      required this.relocation,
      required this.english_description,
      required this.russian_description,
      required this.contacts,
      required this.employments,
      this.levels,
      this.skills});

  @override
  factory CreateJobArguments.fromJson(Map<String, dynamic> json) =>
      _$CreateJobArgumentsFromJson(json);

  late String title;

  late String company;

  late String country_code;

  late String address;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQLRelocationToDartRelocation,
      toJson: fromDartRelocationToGraphQLRelocation)
  late Relocation relocation;

  late String english_description;

  late String russian_description;

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> contacts;

  @JsonKey(
      fromJson: fromGraphQL$employmentToDartListEmployment,
      toJson: fromDartListEmploymentToGraphQL$employment)
  late List<Employment> employments;

  @JsonKey(
      fromJson: fromGraphQL$levelNullableToDartListNullableDeveloperLevel,
      toJson: fromDartListNullableDeveloperLevelToGraphQL$levelNullable)
  final List<DeveloperLevel>? levels;

  @JsonKey(
      fromJson: fromGraphQL$textNullableToDartListNullableString,
      toJson: fromDartListNullableStringToGraphQL$textNullable)
  final List<String>? skills;

  @override
  List<Object?> get props => [
        title,
        company,
        country_code,
        address,
        remote,
        relocation,
        english_description,
        russian_description,
        contacts,
        employments,
        levels,
        skills
      ];
  @override
  Map<String, dynamic> toJson() => _$CreateJobArgumentsToJson(this);
}

final CREATE_JOB_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'CreateJob'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'title')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'company')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'country_code')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'address')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'remote')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'relocation')),
            type: NamedTypeNode(
                name: NameNode(value: 'relocation'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable:
                VariableNode(name: NameNode(value: 'english_description')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable:
                VariableNode(name: NameNode(value: 'russian_description')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'contacts')),
            type:
                NamedTypeNode(name: NameNode(value: '_text'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'employments')),
            type: NamedTypeNode(
                name: NameNode(value: '_employment'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'levels')),
            type: NamedTypeNode(
                name: NameNode(value: '_level'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'skills')),
            type:
                NamedTypeNode(name: NameNode(value: '_text'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'job_create'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'args'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'new_title'),
                        value: VariableNode(name: NameNode(value: 'title'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_company'),
                        value: VariableNode(name: NameNode(value: 'company'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_country_code'),
                        value: VariableNode(
                            name: NameNode(value: 'country_code'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_address'),
                        value: VariableNode(name: NameNode(value: 'address'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_remote'),
                        value: VariableNode(name: NameNode(value: 'remote'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_relocation'),
                        value:
                            VariableNode(name: NameNode(value: 'relocation'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_employments'),
                        value:
                            VariableNode(name: NameNode(value: 'employments'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_levels'),
                        value: VariableNode(name: NameNode(value: 'levels'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_english_description'),
                        value: VariableNode(
                            name: NameNode(value: 'english_description'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_russian_description'),
                        value: VariableNode(
                            name: NameNode(value: 'russian_description'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_skills'),
                        value: VariableNode(name: NameNode(value: 'skills'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'new_contacts'),
                        value: VariableNode(name: NameNode(value: 'contacts')))
                  ]))
            ],
            directives: [],
            selectionSet: SelectionSetNode(selections: [
              FieldNode(
                  name: NameNode(value: 'id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'creator_id'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'created'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'updated'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'deletion_mark'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'title'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'company'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'country_code'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'address'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'remote'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'relocation'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'employments'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'levels'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class CreateJobMutation
    extends GraphQLQuery<CreateJob$MutationRoot, CreateJobArguments> {
  CreateJobMutation({required this.variables});

  @override
  final DocumentNode document = CREATE_JOB_MUTATION_DOCUMENT;

  @override
  final String operationName = 'CreateJob';

  @override
  final CreateJobArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  CreateJob$MutationRoot parse(Map<String, dynamic> json) =>
      CreateJob$MutationRoot.fromJson(json);
}
