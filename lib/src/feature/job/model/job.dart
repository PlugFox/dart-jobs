import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/model/proposal.dart';
import '../../../common/utils/date_util.dart';

part 'job.g.dart';

/// Работа
@immutable
@JsonSerializable(
  explicitToJson: true,
)
class Job extends Proposal<JobAttribute> {
  static const String signature = 'job';

  /// Тип
  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  /// Данные элемента
  @override
  @JsonKey(name: 'attributes', required: true)
  final JobAttributes attributes;

  const Job({
    required final String id,
    required final String creatorId,
    required final String title,
    required final DateTime created,
    required final DateTime updated,
    final bool pinned = false,
    final this.attributes = const JobAttributes.empty(),
  }) : super(
          id: id,
          creatorId: creatorId,
          title: title,
          created: created,
          updated: updated,
          pinned: pinned,
        );

  factory Job.create({
    required final String id,
    required final String creatorId,
    required final String title,
    final JobAttributes attributes = const JobAttributes.empty(),
  }) {
    final now = DateTime.now().toUtc();
    return Job(
      id: id,
      creatorId: creatorId,
      title: title,
      created: now,
      updated: now,
      attributes: attributes,
    );
  }

  /// Generate Class from Map<String, dynamic>
  factory Job.fromJson(Map<String, Object?> json) => _$JobFromJson(json);

  @override
  Map<String, Object?> toJson() => _$JobToJson(this)
    ..putIfAbsent(
      'type',
      () => type,
    );

  @override
  String toString() => 'Job(${super.toString()})';

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
  Job copyWith({
    String? newTitle,
    covariant JobAttributes? newAttributes,
  }) =>
      Job(
        id: id,
        creatorId: creatorId,
        title: newTitle ?? title,
        created: created,
        updated: DateTime.now().toUtc(),
        attributes: newAttributes ?? attributes,
      );

  @override
  Job setAttribute(covariant JobAttribute attribute) => copyWith(
        newAttributes: attributes.set(attribute),
      );
}

/// Детальное описание работы
@immutable
class JobAttributes extends Attributes<JobAttribute> {
  const JobAttributes.empty() : super.empty();

  JobAttributes(Iterable<JobAttribute> source) : super(source);

  JobAttributes._set(Attributes<JobAttribute> attributes, JobAttribute attribute) : super.set(attributes, attribute);

  JobAttributes._remove(Attributes<JobAttribute> attributes, Type type) : super.remove(attributes, type);

  @override
  JobAttributes set(JobAttribute attribute) => JobAttributes._set(this, attribute);

  @override
  JobAttributes removeByType(Type type) => JobAttributes._remove(this, type);

  /// Generate Class from List<Object?>
  factory JobAttributes.fromJson(List<Object?> json) => JobAttributes(
        json.whereType<Map<String, Object?>>().map<JobAttribute?>(JobAttribute.fromJson).whereNotNull(),
      );
}

/// Аттрибут работы
@immutable
abstract class JobAttribute extends Attribute {
  @factory
  static JobAttribute? fromJson(Map<String, Object?> json) {
    switch (json['type']) {
      case CompanyJobAttribute.signature:
        return CompanyJobAttribute.fromJson(json);
      case DescriptionJobAttribute.signature:
        return DescriptionJobAttribute.fromJson(json);
      case LocationJobAttribute.signature:
        return LocationJobAttribute.fromJson(json);
      case CoordinatesJobAttribute.signature:
        return CoordinatesJobAttribute.fromJson(json);
      case '':
      case null:
      default:
        break;
    }
    return null;
  }
}

/// Аттрибут работы - Компания (Company)
@immutable
@JsonSerializable()
class CompanyJobAttribute implements JobAttribute {
  static const String signature = 'company';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'title', required: true)
  final String title;

  const CompanyJobAttribute({
    required this.title,
  });

  factory CompanyJobAttribute.fromJson(Map<String, Object?> json) => _$CompanyJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$CompanyJobAttributeToJson(this);
}

/// Аттрибут работы - Описание (Description)
@immutable
@JsonSerializable()
class DescriptionJobAttribute implements JobAttribute {
  static const String signature = 'description';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'description', required: true)
  final String description;

  const DescriptionJobAttribute({
    required this.description,
  });

  DescriptionJobAttribute changeDescription(String newDescription) => DescriptionJobAttribute(
        description: newDescription,
      );

  factory DescriptionJobAttribute.fromJson(Map<String, Object?> json) => _$DescriptionJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$DescriptionJobAttributeToJson(this);
}

/// Аттрибут работы - Местоположение (Location)
@immutable
@JsonSerializable()
class LocationJobAttribute implements JobAttribute {
  static const String signature = 'location';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'country', required: true)
  final String country;

  @JsonKey(name: 'address', required: true)
  final String address;

  const LocationJobAttribute({
    required this.country,
    required this.address,
  });

  factory LocationJobAttribute.fromJson(Map<String, Object?> json) => _$LocationJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$LocationJobAttributeToJson(this);
}

/// Аттрибут работы - Координаты
@immutable
@JsonSerializable()
class CoordinatesJobAttribute implements JobAttribute {
  static const String signature = 'coordinates';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'latitude', required: true)
  final double latitude;

  @JsonKey(name: 'longitude', required: true)
  final double longitude;

  const CoordinatesJobAttribute({
    required final this.latitude,
    required final this.longitude,
  });

  factory CoordinatesJobAttribute.fromJson(Map<String, Object?> json) => _$CoordinatesJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$CoordinatesJobAttributeToJson(this);
}

/// TODO:
/// + Зарплатная вилка (Salary)
/// + Уровень разработчика (Developer level)
/// + Теги популярных языков, фреймвоков, пакетов
/// + Требования к разработчику
/// + Бенефиты предоставляемые компанией
/// + Контакты для обратной связи (емейл, сайт, различные мессенджеры)
/// + Возможность релокации
