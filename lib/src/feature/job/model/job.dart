import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/utils/date_util.dart';
import '../../feed/model/proposal.dart';

part 'job.g.dart';

/// Работа
@immutable
@JsonSerializable()
class Job extends Proposal {
  static const String typeRepresentation = 'job';

  /// Тип
  @override
  String get type => typeRepresentation;

  /// Данные элемента
  @override
  @JsonKey(
    name: 'attributes',
    required: true,
  )
  final JobAttributes attributes;

  const Job({
    required final String id,
    required final String title,
    required final DateTime created,
    required final DateTime updated,
    final this.attributes = const JobAttributes.empty(),
  }) : super(
          id: id,
          title: title,
          created: created,
          updated: updated,
        );

  factory Job.create({
    required final String id,
    required final String title,
    final JobAttributes attributes = const JobAttributes.empty(),
  }) {
    final now = DateTime.now().toUtc();
    return Job(
      id: id,
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
        title: newTitle ?? title,
        created: created,
        updated: DateTime.now().toUtc(),
        attributes: newAttributes ?? attributes,
      );
}

/// Детальное описание работы
@immutable
class JobAttributes extends ProposalAttributes<JobAttribute> {
  const JobAttributes.empty() : super.empty();

  JobAttributes(Iterable<JobAttribute> source) : super(source);

  /// Generate Class from List<Object?>
  factory JobAttributes.fromJson(List<Object?> json) => JobAttributes(
        json.whereType<Map<String, Object?>>().map<JobAttribute?>(JobAttribute.fromJson).whereNotNull(),
      );
}

/// Аттрибут работы
@immutable
abstract class JobAttribute extends ProposalAttribute {
  @factory
  static JobAttribute? fromJson(Map<String, Object?> json) {
    switch (json['type']) {
      case 'company':
        return CompanyJobAttribute.fromJson(json);
      case 'description':
        return DescriptionJobAttribute.fromJson(json);
      case 'location':
        return LocationJobAttribute.fromJson(json);
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
  @override
  @JsonKey(name: 'type', required: true)
  String get type => 'company';

  @JsonKey(name: 'title', required: true)
  final String title;

  @JsonKey(
    name: 'url',
    required: false,
    includeIfNull: false,
    disallowNullValue: false,
    defaultValue: null,
  )
  final String? url;

  @JsonKey(
    name: 'description',
    required: false,
    includeIfNull: false,
    disallowNullValue: false,
    defaultValue: null,
  )
  final String? description;

  const CompanyJobAttribute({
    required this.title,
    this.description,
    this.url,
  });

  factory CompanyJobAttribute.fromJson(Map<String, Object?> json) => _$CompanyJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$CompanyJobAttributeToJson(this);
}

/// Аттрибут работы - Описание (Description)
@immutable
@JsonSerializable()
class DescriptionJobAttribute implements JobAttribute {
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
  @override
  @JsonKey(name: 'type', required: true)
  String get type => 'location';

  @JsonKey(name: 'title', required: true)
  final String title;

  @JsonKey(
    name: 'latitude',
    required: false,
    includeIfNull: true,
    disallowNullValue: false,
    defaultValue: null,
  )
  final double? latitude;

  @JsonKey(
    name: 'longitude',
    required: false,
    includeIfNull: true,
    disallowNullValue: false,
    defaultValue: null,
  )
  final double? longitude;

  const LocationJobAttribute({
    required this.title,
    this.latitude,
    this.longitude,
  });

  LocationJobAttribute changeTitle(String newTitle) => LocationJobAttribute(
        title: newTitle,
        latitude: latitude,
        longitude: longitude,
      );

  LocationJobAttribute copyWithCoordinates({
    required double? newLatitude,
    required double? newLongitude,
  }) =>
      LocationJobAttribute(
        title: title,
        latitude: newLatitude,
        longitude: newLongitude,
      );

  factory LocationJobAttribute.fromJson(Map<String, Object?> json) => _$LocationJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$LocationJobAttributeToJson(this);
}

/// TODO: Зарплатная вилка (Salary)

/// TODO: Уровень разработчика (Developer level)
