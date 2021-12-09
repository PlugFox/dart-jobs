// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:dart_jobs_shared/util.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/string_list.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/timestamp.dart';
part 'api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class InsertJob$MutationRoot$Job extends JsonSerializable with EquatableMixin {
  InsertJob$MutationRoot$Job();

  factory InsertJob$MutationRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$InsertJob$MutationRoot$JobFromJson(json);

  late int id;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime updated;

  late String title;

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> tags;

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> skills;

  @JsonKey(name: 'russian_description')
  late String russianDescription;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQL$levelToDartListDeveloperLevel,
      toJson: fromDartListDeveloperLevelToGraphQL$level)
  late List<DeveloperLevel> levels;

  @JsonKey(name: 'english_description')
  late String englishDescription;

  @JsonKey(
      fromJson: fromGraphQL$employmentToDartListEmployment,
      toJson: fromDartListEmploymentToGraphQL$employment)
  late List<Employment> employments;

  @JsonKey(name: 'deletion_mark')
  late bool deletionMark;

  @JsonKey(name: 'creator_id')
  late String creatorId;

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime created;

  late int country;

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> contacts;

  late String company;

  @override
  List<Object?> get props => [
        id,
        updated,
        title,
        tags,
        skills,
        russianDescription,
        remote,
        levels,
        englishDescription,
        employments,
        deletionMark,
        creatorId,
        created,
        country,
        contacts,
        company
      ];
  @override
  Map<String, dynamic> toJson() => _$InsertJob$MutationRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InsertJob$MutationRoot extends JsonSerializable with EquatableMixin {
  InsertJob$MutationRoot();

  factory InsertJob$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$InsertJob$MutationRootFromJson(json);

  @JsonKey(name: 'insert_job_one')
  InsertJob$MutationRoot$Job? insertJobOne;

  @override
  List<Object?> get props => [insertJobOne];
  @override
  Map<String, dynamic> toJson() => _$InsertJob$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class InsertJobArguments extends JsonSerializable with EquatableMixin {
  InsertJobArguments(
      {required this.title,
      required this.company,
      required this.country,
      required this.creatorId,
      required this.remote,
      required this.englishDescription,
      required this.russianDescription,
      required this.contacts,
      required this.employments,
      this.levels,
      this.skills,
      this.tags});

  @override
  factory InsertJobArguments.fromJson(Map<String, dynamic> json) =>
      _$InsertJobArgumentsFromJson(json);

  late String title;

  late String company;

  late int country;

  late String creatorId;

  late bool remote;

  late String englishDescription;

  late String russianDescription;

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

  @JsonKey(
      fromJson: fromGraphQL$textNullableToDartListNullableString,
      toJson: fromDartListNullableStringToGraphQL$textNullable)
  final List<String>? tags;

  @override
  List<Object?> get props => [
        title,
        company,
        country,
        creatorId,
        remote,
        englishDescription,
        russianDescription,
        contacts,
        employments,
        levels,
        skills,
        tags
      ];
  @override
  Map<String, dynamic> toJson() => _$InsertJobArgumentsToJson(this);
}

final INSERT_JOB_MUTATION_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.mutation,
      name: NameNode(value: 'InsertJob'),
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
            variable: VariableNode(name: NameNode(value: 'country')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'creatorId')),
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
            variable: VariableNode(name: NameNode(value: 'englishDescription')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'russianDescription')),
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
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'tags')),
            type:
                NamedTypeNode(name: NameNode(value: '_text'), isNonNull: false),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'insert_job_one'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'object'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'title'),
                        value: VariableNode(name: NameNode(value: 'title'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'company'),
                        value: VariableNode(name: NameNode(value: 'company'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'country'),
                        value: VariableNode(name: NameNode(value: 'country'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'creator_id'),
                        value:
                            VariableNode(name: NameNode(value: 'creatorId'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'remote'),
                        value: VariableNode(name: NameNode(value: 'remote'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'english_description'),
                        value: VariableNode(
                            name: NameNode(value: 'englishDescription'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'russian_description'),
                        value: VariableNode(
                            name: NameNode(value: 'russianDescription'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'contacts'),
                        value: VariableNode(name: NameNode(value: 'contacts'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'employments'),
                        value:
                            VariableNode(name: NameNode(value: 'employments'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'levels'),
                        value: VariableNode(name: NameNode(value: 'levels'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'skills'),
                        value: VariableNode(name: NameNode(value: 'skills'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'tags'),
                        value: VariableNode(name: NameNode(value: 'tags')))
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
                  name: NameNode(value: 'updated'),
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
                  name: NameNode(value: 'tags'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'skills'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'russian_description'),
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
                  name: NameNode(value: 'levels'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'english_description'),
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
                  name: NameNode(value: 'deletion_mark'),
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
                  name: NameNode(value: 'country'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'contacts'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'company'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class InsertJobMutation
    extends GraphQLQuery<InsertJob$MutationRoot, InsertJobArguments> {
  InsertJobMutation({required this.variables});

  @override
  final DocumentNode document = INSERT_JOB_MUTATION_DOCUMENT;

  @override
  final String operationName = 'InsertJob';

  @override
  final InsertJobArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  InsertJob$MutationRoot parse(Map<String, dynamic> json) =>
      InsertJob$MutationRoot.fromJson(json);
}
