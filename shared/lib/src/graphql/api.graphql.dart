// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart = 2.12

import 'package:artemis/artemis.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:gql/ast.dart';
import 'package:dart_jobs_shared/util.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/employment.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/level.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/text.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/bpchar.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/relocation.dart';
import 'package:dart_jobs_shared/src/graphql/parsers/timestamp.dart';
part 'api.graphql.g.dart';

@JsonSerializable(explicitToJson: true)
class FetchRecent$QueryRoot$Job extends JsonSerializable with EquatableMixin {
  FetchRecent$QueryRoot$Job();

  factory FetchRecent$QueryRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$FetchRecent$QueryRoot$JobFromJson(json);

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
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String country;

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

  @JsonKey(name: 'is_english')
  late bool isEnglish;

  @JsonKey(name: 'is_russian')
  late bool isRussian;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        country,
        address,
        remote,
        relocation,
        employments,
        levels,
        isEnglish,
        isRussian
      ];
  @override
  Map<String, dynamic> toJson() => _$FetchRecent$QueryRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchRecent$QueryRoot extends JsonSerializable with EquatableMixin {
  FetchRecent$QueryRoot();

  factory FetchRecent$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$FetchRecent$QueryRootFromJson(json);

  late List<FetchRecent$QueryRoot$Job> job;

  @override
  List<Object?> get props => [job];
  @override
  Map<String, dynamic> toJson() => _$FetchRecent$QueryRootToJson(this);
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
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String country;

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

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> skills;

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> contacts;

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> tags;

  @JsonKey(name: 'russian_description')
  late String russianDescription;

  @JsonKey(name: 'is_russian')
  late bool isRussian;

  @JsonKey(name: 'english_description')
  late String englishDescription;

  @JsonKey(name: 'is_english')
  late bool isEnglish;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        country,
        address,
        remote,
        relocation,
        employments,
        levels,
        skills,
        contacts,
        tags,
        russianDescription,
        isRussian,
        englishDescription,
        isEnglish
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
class InsertJob$MutationRoot$Job extends JsonSerializable with EquatableMixin {
  InsertJob$MutationRoot$Job();

  factory InsertJob$MutationRoot$Job.fromJson(Map<String, dynamic> json) =>
      _$InsertJob$MutationRoot$JobFromJson(json);

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
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String country;

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

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> skills;

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> contacts;

  @JsonKey(
      fromJson: fromGraphQL$textToDartListString,
      toJson: fromDartListStringToGraphQL$text)
  late List<String> tags;

  @JsonKey(name: 'russian_description')
  late String russianDescription;

  @JsonKey(name: 'is_russian')
  late bool isRussian;

  @JsonKey(name: 'english_description')
  late String englishDescription;

  @JsonKey(name: 'is_english')
  late bool isEnglish;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        country,
        address,
        remote,
        relocation,
        employments,
        levels,
        skills,
        contacts,
        tags,
        russianDescription,
        isRussian,
        englishDescription,
        isEnglish
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
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String country;

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

  @JsonKey(name: 'is_english')
  late bool isEnglish;

  @JsonKey(name: 'is_russian')
  late bool isRussian;

  @override
  List<Object?> get props => [
        id,
        creatorId,
        created,
        updated,
        deletionMark,
        title,
        company,
        country,
        address,
        remote,
        relocation,
        employments,
        levels,
        isEnglish,
        isRussian
      ];
  @override
  Map<String, dynamic> toJson() => _$Paginate$QueryRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Paginate$QueryRoot extends JsonSerializable with EquatableMixin {
  Paginate$QueryRoot();

  factory Paginate$QueryRoot.fromJson(Map<String, dynamic> json) =>
      _$Paginate$QueryRootFromJson(json);

  late List<Paginate$QueryRoot$Job> job;

  @override
  List<Object?> get props => [job];
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

  @override
  List<Object?> get props => [id, creatorId, created, updated, deletionMark];
  @override
  Map<String, dynamic> toJson() => _$UpdateJob$MutationRoot$JobToJson(this);
}

@JsonSerializable(explicitToJson: true)
class UpdateJob$MutationRoot extends JsonSerializable with EquatableMixin {
  UpdateJob$MutationRoot();

  factory UpdateJob$MutationRoot.fromJson(Map<String, dynamic> json) =>
      _$UpdateJob$MutationRootFromJson(json);

  @JsonKey(name: 'update_job_by_pk')
  UpdateJob$MutationRoot$Job? updateJobByPk;

  @override
  List<Object?> get props => [updateJobByPk];
  @override
  Map<String, dynamic> toJson() => _$UpdateJob$MutationRootToJson(this);
}

@JsonSerializable(explicitToJson: true)
class JobSetInput extends JsonSerializable with EquatableMixin {
  JobSetInput(
      {this.address,
      this.company,
      this.contacts,
      this.country,
      this.deletionMark,
      this.employments,
      this.englishDescription,
      this.isEnglish,
      this.isRussian,
      this.levels,
      this.relocation,
      this.remote,
      this.russianDescription,
      this.skills,
      this.tags,
      this.title});

  factory JobSetInput.fromJson(Map<String, dynamic> json) =>
      _$JobSetInputFromJson(json);

  String? address;

  String? company;

  @JsonKey(
      fromJson: fromGraphQL$textNullableToDartListNullableString,
      toJson: fromDartListNullableStringToGraphQL$textNullable)
  List<String>? contacts;

  @JsonKey(
      fromJson: fromGraphQLBpcharNullableToDartStringNullable,
      toJson: fromDartStringNullableToGraphQLBpcharNullable)
  String? country;

  @JsonKey(name: 'deletion_mark')
  bool? deletionMark;

  @JsonKey(
      fromJson: fromGraphQL$employmentNullableToDartListNullableEmployment,
      toJson: fromDartListNullableEmploymentToGraphQL$employmentNullable)
  List<Employment>? employments;

  @JsonKey(name: 'english_description')
  String? englishDescription;

  @JsonKey(name: 'is_english')
  bool? isEnglish;

  @JsonKey(name: 'is_russian')
  bool? isRussian;

  @JsonKey(
      fromJson: fromGraphQL$levelNullableToDartListNullableDeveloperLevel,
      toJson: fromDartListNullableDeveloperLevelToGraphQL$levelNullable)
  List<DeveloperLevel>? levels;

  @JsonKey(
      fromJson: fromGraphQLRelocationNullableToDartRelocationNullable,
      toJson: fromDartRelocationNullableToGraphQLRelocationNullable)
  Relocation? relocation;

  bool? remote;

  @JsonKey(name: 'russian_description')
  String? russianDescription;

  @JsonKey(
      fromJson: fromGraphQL$textNullableToDartListNullableString,
      toJson: fromDartListNullableStringToGraphQL$textNullable)
  List<String>? skills;

  @JsonKey(
      fromJson: fromGraphQL$textNullableToDartListNullableString,
      toJson: fromDartListNullableStringToGraphQL$textNullable)
  List<String>? tags;

  String? title;

  @override
  List<Object?> get props => [
        address,
        company,
        contacts,
        country,
        deletionMark,
        employments,
        englishDescription,
        isEnglish,
        isRussian,
        levels,
        relocation,
        remote,
        russianDescription,
        skills,
        tags,
        title
      ];
  @override
  Map<String, dynamic> toJson() => _$JobSetInputToJson(this);
}

@JsonSerializable(explicitToJson: true)
class FetchRecentArguments extends JsonSerializable with EquatableMixin {
  FetchRecentArguments(
      {required this.after, required this.limit, required this.exclude});

  @override
  factory FetchRecentArguments.fromJson(Map<String, dynamic> json) =>
      _$FetchRecentArgumentsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime after;

  late int limit;

  late List<int> exclude;

  @override
  List<Object?> get props => [after, limit, exclude];
  @override
  Map<String, dynamic> toJson() => _$FetchRecentArgumentsToJson(this);
}

final FETCH_RECENT_QUERY_DOCUMENT = DocumentNode(definitions: [
  OperationDefinitionNode(
      type: OperationType.query,
      name: NameNode(value: 'FetchRecent'),
      variableDefinitions: [
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'after')),
            type: NamedTypeNode(
                name: NameNode(value: 'timestamp'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '100')),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'exclude')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'job'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'where'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'updated'),
                        value: ObjectValueNode(fields: [
                          ObjectFieldNode(
                              name: NameNode(value: '_gt'),
                              value:
                                  VariableNode(name: NameNode(value: 'after')))
                        ])),
                    ObjectFieldNode(
                        name: NameNode(value: 'deletion_mark'),
                        value: ObjectValueNode(fields: [
                          ObjectFieldNode(
                              name: NameNode(value: '_eq'),
                              value: BooleanValueNode(value: false))
                        ])),
                    ObjectFieldNode(
                        name: NameNode(value: 'id'),
                        value: ObjectValueNode(fields: [
                          ObjectFieldNode(
                              name: NameNode(value: '_nin'),
                              value: VariableNode(
                                  name: NameNode(value: 'exclude')))
                        ]))
                  ])),
              ArgumentNode(
                  name: NameNode(value: 'order_by'),
                  value: ListValueNode(values: [
                    ObjectValueNode(fields: [
                      ObjectFieldNode(
                          name: NameNode(value: 'updated'),
                          value: EnumValueNode(name: NameNode(value: 'asc')))
                    ])
                  ])),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit')))
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
                  name: NameNode(value: 'country'),
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
                  name: NameNode(value: 'is_english'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'is_russian'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
            ]))
      ]))
]);

class FetchRecentQuery
    extends GraphQLQuery<FetchRecent$QueryRoot, FetchRecentArguments> {
  FetchRecentQuery({required this.variables});

  @override
  final DocumentNode document = FETCH_RECENT_QUERY_DOCUMENT;

  @override
  final String operationName = 'FetchRecent';

  @override
  final FetchRecentArguments variables;

  @override
  List<Object?> get props => [document, operationName, variables];
  @override
  FetchRecent$QueryRoot parse(Map<String, dynamic> json) =>
      FetchRecent$QueryRoot.fromJson(json);
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
                  name: NameNode(value: 'country'),
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
                  name: NameNode(value: 'skills'),
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
                  name: NameNode(value: 'tags'),
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
                  name: NameNode(value: 'is_russian'),
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
                  name: NameNode(value: 'is_english'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null)
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
class InsertJobArguments extends JsonSerializable with EquatableMixin {
  InsertJobArguments(
      {required this.title,
      required this.company,
      required this.country,
      required this.address,
      required this.creator_id,
      required this.remote,
      required this.relocation,
      required this.english_description,
      required this.is_english,
      required this.russian_description,
      required this.is_russian,
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

  @JsonKey(
      fromJson: fromGraphQLBpcharToDartString,
      toJson: fromDartStringToGraphQLBpchar)
  late String country;

  late String address;

  late String creator_id;

  late bool remote;

  @JsonKey(
      fromJson: fromGraphQLRelocationToDartRelocation,
      toJson: fromDartRelocationToGraphQLRelocation)
  late Relocation relocation;

  late String english_description;

  late bool is_english;

  late String russian_description;

  late bool is_russian;

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
        address,
        creator_id,
        remote,
        relocation,
        english_description,
        is_english,
        russian_description,
        is_russian,
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
            type:
                NamedTypeNode(name: NameNode(value: 'bpchar'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'address')),
            type:
                NamedTypeNode(name: NameNode(value: 'String'), isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'creator_id')),
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
            variable: VariableNode(name: NameNode(value: 'is_english')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: true),
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
            variable: VariableNode(name: NameNode(value: 'is_russian')),
            type: NamedTypeNode(
                name: NameNode(value: 'Boolean'), isNonNull: true),
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
                        name: NameNode(value: 'creator_id'),
                        value:
                            VariableNode(name: NameNode(value: 'creator_id'))),
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
                        name: NameNode(value: 'address'),
                        value: VariableNode(name: NameNode(value: 'address'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'remote'),
                        value: VariableNode(name: NameNode(value: 'remote'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'relocation'),
                        value:
                            VariableNode(name: NameNode(value: 'relocation'))),
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
                        name: NameNode(value: 'contacts'),
                        value: VariableNode(name: NameNode(value: 'contacts'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'tags'),
                        value: VariableNode(name: NameNode(value: 'tags'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'english_description'),
                        value: VariableNode(
                            name: NameNode(value: 'english_description'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'is_english'),
                        value:
                            VariableNode(name: NameNode(value: 'is_english'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'russian_description'),
                        value: VariableNode(
                            name: NameNode(value: 'russian_description'))),
                    ObjectFieldNode(
                        name: NameNode(value: 'is_russian'),
                        value:
                            VariableNode(name: NameNode(value: 'is_russian')))
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
                  name: NameNode(value: 'country'),
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
                  name: NameNode(value: 'skills'),
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
                  name: NameNode(value: 'tags'),
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
                  name: NameNode(value: 'is_russian'),
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
                  name: NameNode(value: 'is_english'),
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

@JsonSerializable(explicitToJson: true)
class PaginateArguments extends JsonSerializable with EquatableMixin {
  PaginateArguments(
      {required this.before, required this.limit, required this.exclude});

  @override
  factory PaginateArguments.fromJson(Map<String, dynamic> json) =>
      _$PaginateArgumentsFromJson(json);

  @JsonKey(
      fromJson: fromGraphQLTimestampToDartDateTime,
      toJson: fromDartDateTimeToGraphQLTimestamp)
  late DateTime before;

  late int limit;

  late List<int> exclude;

  @override
  List<Object?> get props => [before, limit, exclude];
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
            variable: VariableNode(name: NameNode(value: 'limit')),
            type: NamedTypeNode(name: NameNode(value: 'Int'), isNonNull: true),
            defaultValue: DefaultValueNode(value: IntValueNode(value: '100')),
            directives: []),
        VariableDefinitionNode(
            variable: VariableNode(name: NameNode(value: 'exclude')),
            type: ListTypeNode(
                type: NamedTypeNode(
                    name: NameNode(value: 'Int'), isNonNull: true),
                isNonNull: true),
            defaultValue: DefaultValueNode(value: null),
            directives: [])
      ],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FieldNode(
            name: NameNode(value: 'job'),
            alias: null,
            arguments: [
              ArgumentNode(
                  name: NameNode(value: 'where'),
                  value: ObjectValueNode(fields: [
                    ObjectFieldNode(
                        name: NameNode(value: 'updated'),
                        value: ObjectValueNode(fields: [
                          ObjectFieldNode(
                              name: NameNode(value: '_lt'),
                              value:
                                  VariableNode(name: NameNode(value: 'before')))
                        ])),
                    ObjectFieldNode(
                        name: NameNode(value: 'deletion_mark'),
                        value: ObjectValueNode(fields: [
                          ObjectFieldNode(
                              name: NameNode(value: '_eq'),
                              value: BooleanValueNode(value: false))
                        ])),
                    ObjectFieldNode(
                        name: NameNode(value: 'id'),
                        value: ObjectValueNode(fields: [
                          ObjectFieldNode(
                              name: NameNode(value: '_nin'),
                              value: VariableNode(
                                  name: NameNode(value: 'exclude')))
                        ]))
                  ])),
              ArgumentNode(
                  name: NameNode(value: 'order_by'),
                  value: ListValueNode(values: [
                    ObjectValueNode(fields: [
                      ObjectFieldNode(
                          name: NameNode(value: 'updated'),
                          value: EnumValueNode(name: NameNode(value: 'desc')))
                    ])
                  ])),
              ArgumentNode(
                  name: NameNode(value: 'limit'),
                  value: VariableNode(name: NameNode(value: 'limit')))
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
                  name: NameNode(value: 'country'),
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
                  name: NameNode(value: 'is_english'),
                  alias: null,
                  arguments: [],
                  directives: [],
                  selectionSet: null),
              FieldNode(
                  name: NameNode(value: 'is_russian'),
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
  UpdateJobArguments({required this.id, required this.data});

  @override
  factory UpdateJobArguments.fromJson(Map<String, dynamic> json) =>
      _$UpdateJobArgumentsFromJson(json);

  late int id;

  late JobSetInput data;

  @override
  List<Object?> get props => [id, data];
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
                  selectionSet: null)
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
