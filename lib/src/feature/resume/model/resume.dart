import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/utils/date_util.dart';
import '../../feed/model/proposal.dart';

part 'resume.g.dart';

@immutable
@JsonSerializable()
class Resume implements Proposal {
  static const String typeRepresentation = 'resume';

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => id.isNotEmpty;

  @override
  @JsonKey(name: 'type', required: true)
  String get type => typeRepresentation;

  /// Идентификатор
  @override
  @JsonKey(name: 'id', required: true)
  final String id;

  @override
  @JsonKey(name: 'title', required: true)
  final String title;

  /// Заведено в программе (Unixtime в милисекундах)
  @override
  @JsonKey(
    name: 'created',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime created;

  /// Обновлено (Unixtime в милисекундах)
  @override
  @JsonKey(
    name: 'updated',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime updated;

  /// Описание, до 1024 символов
  @override
  @JsonKey(
    name: 'description',
    required: false,
    includeIfNull: false,
    disallowNullValue: false,
    defaultValue: null,
  )
  final String? description;

  /// Данные элемента
  @JsonKey(
    name: 'attributes',
    required: true,
    includeIfNull: false,
    defaultValue: null,
    disallowNullValue: false,
  )
  final ResumeAttributes? attributes;

  const Resume({
    required this.id,
    required this.title,
    required this.created,
    required this.updated,
    this.description,
    this.attributes,
  });

  /// Generate Class from Map<String, dynamic>
  factory Resume.fromJson(Map<String, Object?> json) => _$ResumeFromJson(json);

  /// Преобразовать в JSON хэш таблицу
  @override
  Map<String, Object?> toJson() => _$ResumeToJson(this);

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Resume && id == other.id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Resume( '
      'id: $id, '
      'title: $title, '
      'created: $created, '
      'updated: $updated )';

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
  int compareTo(Proposal other) => created.compareTo(other.created);
}

/// Детальное описание резюме
@immutable
class ResumeAttributes extends Iterable<ResumeAttribute> {
  final List<ResumeAttribute> _list;

  @literal
  const ResumeAttributes.empty() : _list = const <ResumeAttribute>[];

  ResumeAttributes(Iterable<ResumeAttribute> source) : _list = List<ResumeAttribute>.of(source, growable: false);

  @override
  Iterator<ResumeAttribute> get iterator => _list.iterator;

  ResumeAttribute operator [](int index) => _list[index];

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is ResumeAttributes &&
          const ListEquality<ResumeAttribute>().equals(
            other._list,
            _list,
          ));

  @override
  int get hashCode => _list.hashCode;

  /// Generate Class from List<Object?>
  factory ResumeAttributes.fromJson(List<Object?> json) => ResumeAttributes(
        json.whereType<Map<String, Object?>>().map<ResumeAttribute>(
              (e) => ResumeAttribute.fromJson(e),
            ),
      );

  /// Преобразовать в JSON список
  List<Object?> toJson() => _list.map<Map<String, Object?>>((e) => e.toJson()).toList();
}

/// Аттрибут работы
@immutable
abstract class ResumeAttribute {
  String get type;

  factory ResumeAttribute.fromJson(Map<String, Object?> json) {
    throw UnimplementedError('Not implemented yet "$json" to ResumeAttribute');
  }

  Map<String, Object?> toJson();
}
