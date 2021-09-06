import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/utils/date_util.dart';
import '../../feed/model/proposal.dart';

part 'job.g.dart';

/// Работа
@immutable
@JsonSerializable()
class Job implements Proposal {
  static const String typeRepresentation = 'job';

  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => !isNotEmpty;

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

  /// Место работы
  @JsonKey(name: 'location', required: true)
  final ProposalLocation location;

  /// Компания
  @JsonKey(
    name: 'company',
    required: false,
    includeIfNull: false,
    disallowNullValue: false,
    defaultValue: null,
  )
  final Company? company;

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

  /// TODO: зарплатная вилка (Salary)

  /// TODO: уровень разработчика (Developer Level)

  /// Данные элемента
  @JsonKey(
    name: 'attributes',
    required: true,
    includeIfNull: false,
    defaultValue: null,
    disallowNullValue: false,
  )
  final JobAttributes? attributes;

  const Job({
    required this.id,
    required this.created,
    required this.updated,
    required this.title,
    this.location = const ProposalLocation.remote(),
    this.company,
    this.description,
    this.attributes,
  });

  /// Generate Class from Map<String, dynamic>
  factory Job.fromJson(Map<String, Object?> json) => _$JobFromJson(json);

  /// Преобразовать в JSON хэш таблицу
  @override
  Map<String, Object?> toJson() => _$JobToJson(this);

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Job && id == other.id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Job( '
      'id: $id, '
      'title: $title, '
      'created: $created, '
      'updated: $updated )';

  @override
  Result map<Result extends Object>({
    required final Result Function(Resume resume) resume,
    required final Result Function(Job job) job,
  }) =>
      job(this);

  @override
  Result maybeMap<Result extends Object>({
    required Result Function() orElse,
    final Result Function(Resume resume)? resume,
    final Result Function(Job job)? job,
  }) =>
      job == null ? orElse() : job(this);

  @override
  int compareTo(Proposal other) => created.compareTo(other.created);
}

/// Детальное описание работы
@immutable
class JobAttributes extends Iterable<JobAttribute> {
  final List<JobAttribute> _list;

  @literal
  const JobAttributes.empty() : _list = const <JobAttribute>[];

  JobAttributes(Iterable<JobAttribute> source) : _list = List<JobAttribute>.of(source, growable: false);

  @override
  Iterator<JobAttribute> get iterator => _list.iterator;

  JobAttribute operator [](int index) => _list[index];

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is JobAttributes &&
          const ListEquality<JobAttribute>().equals(
            other._list,
            _list,
          ));

  @override
  int get hashCode => _list.hashCode;

  /// Generate Class from List<Object?>
  factory JobAttributes.fromJson(List<Object?> json) => JobAttributes(
        json.whereType<Map<String, Object?>>().map<JobAttribute>(
              (e) => JobAttribute.fromJson(e),
            ),
      );

  /// Преобразовать в JSON список
  List<Object?> toJson() => _list.map<Map<String, Object?>>((e) => e.toJson()).toList();
}

/// Аттрибут работы
@immutable
abstract class JobAttribute {
  String get type;

  factory JobAttribute.fromJson(Map<String, Object?> json) {
    throw UnimplementedError('Not implemented yet "$json" to JobAttribute');
  }

  Map<String, Object?> toJson();
}
