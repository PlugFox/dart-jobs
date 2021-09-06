import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/utils/date_util.dart';
import '../../feed/model/proposal.dart';

part 'resume.g.dart';

@immutable
@JsonSerializable()
class Resume extends Proposal {
  static const String typeRepresentation = 'resume';

  @override
  String get type => typeRepresentation;

  /// Данные элемента
  @override
  @JsonKey(
    name: 'attributes',
    required: true,
  )
  final ResumeAttributes attributes;

  const Resume({
    required String id,
    required String title,
    required DateTime created,
    required DateTime updated,
    this.attributes = const ResumeAttributes.empty(),
  }) : super(
          id: id,
          title: title,
          created: created,
          updated: updated,
        );

  factory Resume.create({
    required final String id,
    required final String title,
    final ResumeAttributes attributes = const ResumeAttributes.empty(),
  }) {
    final now = DateTime.now().toUtc();
    return Resume(
      id: id,
      title: title,
      created: now,
      updated: now,
      attributes: attributes,
    );
  }

  /// Generate Class from Map<String, dynamic>
  factory Resume.fromJson(Map<String, Object?> json) => _$ResumeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$ResumeToJson(this)
    ..putIfAbsent(
      'type',
      () => type,
    );

  @override
  String toString() => 'Resume(${super.toString()})';

  @override
  Result map<Result extends Object>({
    required final Result Function(Resume resume) resume,
    required final Result Function(Job job) job,
  }) =>
      resume(this);

  @override
  Result maybeMap<Result extends Object>({
    required Result Function() orElse,
    final Result Function(Resume resume)? resume,
    final Result Function(Job job)? job,
  }) =>
      resume == null ? orElse() : resume(this);

  @override
  Resume copyWith({
    String? newTitle,
    covariant ResumeAttributes? newAttributes,
  }) =>
      Resume(
        id: id,
        title: newTitle ?? title,
        created: created,
        updated: DateTime.now().toUtc(),
        attributes: newAttributes ?? attributes,
      );
}

/// Детальное описание резюме
@immutable
class ResumeAttributes extends ProposalAttributes<ResumeAttribute> {
  const ResumeAttributes.empty() : super.empty();

  ResumeAttributes(Iterable<ResumeAttribute> source) : super(source);

  /// Generate Class from List<Object?>
  factory ResumeAttributes.fromJson(List<Object?> json) => ResumeAttributes(
        json.whereType<Map<String, Object?>>().map<ResumeAttribute?>(ResumeAttribute.fromJson).whereNotNull(),
      );
}

/// Аттрибут работы
@immutable
abstract class ResumeAttribute extends ProposalAttribute {
  @factory
  static ResumeAttribute? fromJson(Map<String, Object?> json) {
    switch (json['type']) {
      case 'description':
        return DescriptionResumeAttribute.fromJson(json);
      case '':
      case null:
      default:
        break;
    }
    return null;
  }
}

/// Аттрибут резюме - Описание (Description)
@immutable
@JsonSerializable()
class DescriptionResumeAttribute implements ResumeAttribute {
  @override
  @JsonKey(name: 'type', required: true)
  String get type => 'description';

  @JsonKey(
    name: 'description',
    required: false,
    includeIfNull: false,
    disallowNullValue: false,
    defaultValue: null,
  )
  final String description;

  const DescriptionResumeAttribute({
    required this.description,
  });

  DescriptionResumeAttribute changeDescription(String newDescription) => DescriptionResumeAttribute(
        description: newDescription,
      );

  factory DescriptionResumeAttribute.fromJson(Map<String, Object?> json) => _$DescriptionResumeAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$DescriptionResumeAttributeToJson(this);
}
