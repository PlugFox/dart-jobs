import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:money2/money2.dart';

import '../../../common/model/proposal.dart';

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
    final this.attributes = const JobAttributes.empty(),
  }) : super(
          id: id,
          creatorId: creatorId,
          title: title,
          created: created,
          updated: updated,
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
      case SalaryJobAttribute.signature:
        return SalaryJobAttribute.fromJson(json);
      case DeveloperLevelJobAttribute.signature:
        return DeveloperLevelJobAttribute.fromJson(json);
      case RelocationJobAttribute.signature:
        return RelocationJobAttribute.fromJson(json);
      case TagsJobAttribute.signature:
        return TagsJobAttribute.fromJson(json);
      case SkillsJobAttribute.signature:
        return SkillsJobAttribute.fromJson(json);
      case RequirementsJobAttribute.signature:
        return RequirementsJobAttribute.fromJson(json);
      case ContactsJobAttribute.signature:
        return ContactsJobAttribute.fromJson(json);
      case ContractTypeJobAttribute.signature:
        return ContractTypeJobAttribute.fromJson(json);
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
  const CompanyJobAttribute({
    required this.title,
  });

  static const String signature = 'company';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'title', required: true)
  final String title;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => title.isEmpty;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory CompanyJobAttribute.fromJson(Map<String, Object?> json) => _$CompanyJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$CompanyJobAttributeToJson(this);

  @override
  int get hashCode => title.hashCode;

  @override
  bool operator ==(Object other) => identical(other, this) || (other is CompanyJobAttribute && other.title == title);
}

/// Аттрибут работы - Описание (Description)
@immutable
@JsonSerializable()
class DescriptionJobAttribute implements JobAttribute {
  const DescriptionJobAttribute({
    required this.description,
  });

  static const DescriptionJobAttribute empty = DescriptionJobAttribute(description: '');

  static const String signature = 'description';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'description', required: true)
  final String description;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => description.isEmpty;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  DescriptionJobAttribute changeDescription(String newDescription) => DescriptionJobAttribute(
        description: newDescription,
      );

  factory DescriptionJobAttribute.fromJson(Map<String, Object?> json) => _$DescriptionJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$DescriptionJobAttributeToJson(this);

  @override
  int get hashCode => description.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is DescriptionJobAttribute && other.description == description);
}

/// Аттрибут работы - Местоположение (Location)
@immutable
@JsonSerializable()
class LocationJobAttribute implements JobAttribute {
  const LocationJobAttribute({
    required this.country,
    required this.address,
  });

  static const String signature = 'location';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'country', required: true)
  final String country;

  @JsonKey(name: 'address', required: true)
  final String address;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => country.isEmpty && address.isEmpty;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory LocationJobAttribute.fromJson(Map<String, Object?> json) => _$LocationJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$LocationJobAttributeToJson(this);

  @override
  int get hashCode => country.hashCode ^ address.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is LocationJobAttribute && other.country == country && other.address == address);
}

/// Аттрибут работы - Координаты
@immutable
@JsonSerializable()
class CoordinatesJobAttribute implements JobAttribute {
  const CoordinatesJobAttribute({
    required final this.latitude,
    required final this.longitude,
  });

  static const CoordinatesJobAttribute empty = CoordinatesJobAttribute(
    latitude: 0,
    longitude: 0,
  );

  static const String signature = 'coordinates';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'latitude', required: true)
  final double latitude;

  @JsonKey(name: 'longitude', required: true)
  final double longitude;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => latitude == 0 && longitude == 0;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory CoordinatesJobAttribute.fromJson(Map<String, Object?> json) => _$CoordinatesJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$CoordinatesJobAttributeToJson(this);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is CoordinatesJobAttribute && other.latitude == latitude && other.longitude == longitude);
}

/// Аттрибут работы - Зарплатная вилка (Salary)
/// Указывается в долларах * 100 (центы), в дальнейшем исходя из даты вакансии
/// и курса обмена можно будет указывать в произвольной валюте
@immutable
@JsonSerializable()
class SalaryJobAttribute implements JobAttribute {
  const SalaryJobAttribute({
    required final this.from,
    required final this.to,
  });

  static final SalaryJobAttribute unknown = SalaryJobAttribute(
    from: zeroMoney,
    to: zeroMoney,
  );

  static const String signature = 'salary';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(
    name: 'from',
    required: true,
    fromJson: _moneyFromJson,
    toJson: _moneyToJson,
  )
  final Money from;

  @JsonKey(
    name: 'to',
    required: true,
    fromJson: _moneyFromJson,
    toJson: _moneyToJson,
  )
  final Money to;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => from == zeroMoney && to == zeroMoney;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory SalaryJobAttribute.fromJson(Map<String, Object?> json) => _$SalaryJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SalaryJobAttributeToJson(this);

  static int _moneyToJson(final Money? money) => money is Money ? money.minorUnits.toInt() : 0;

  static Money _moneyFromJson(final Object? money) =>
      money is num ? Money.fromWithCurrency(money / 100, _usd) : zeroMoney;

  static final Money zeroMoney = Money.fromBigIntWitCurrency(BigInt.zero, _usd);
  static final Currency _usd = CommonCurrencies().usd;

  @override
  int get hashCode => from.minorUnits.hashCode ^ to.minorUnits.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is SalaryJobAttribute && other.from == from && other.to == to);
}

/// Аттрибут работы - Уровень разработчика (Developer level)
@immutable
@JsonSerializable()
class DeveloperLevelJobAttribute implements JobAttribute {
  const DeveloperLevelJobAttribute({
    required final this.from,
    required final this.to,
  });

  static const DeveloperLevelJobAttribute unknown = DeveloperLevelJobAttribute(
    from: DeveloperLevel.unknown,
    to: DeveloperLevel.unknown,
  );

  static const String signature = 'developer_level';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(
    name: 'from',
    required: true,
    fromJson: _levelFromJson,
    toJson: _levelToJson,
  )
  final DeveloperLevel from;

  @JsonKey(
    name: 'to',
    required: true,
    fromJson: _levelFromJson,
    toJson: _levelToJson,
  )
  final DeveloperLevel to;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => from == DeveloperLevel.unknown && to == DeveloperLevel.unknown;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory DeveloperLevelJobAttribute.fromJson(Map<String, Object?> json) => _$DeveloperLevelJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$DeveloperLevelJobAttributeToJson(this);

  static DeveloperLevel _levelFromJson(final Object? level) {
    switch (level) {
      case 'intern':
        return DeveloperLevel.intern;
      case 'junior':
        return DeveloperLevel.junior;
      case 'middle':
        return DeveloperLevel.middle;
      case 'senior':
        return DeveloperLevel.senior;
      case 'lead':
        return DeveloperLevel.lead;
      default:
        return DeveloperLevel.unknown;
    }
  }

  static String _levelToJson(final DeveloperLevel? level) {
    switch (level) {
      case DeveloperLevel.intern:
        return 'intern';
      case DeveloperLevel.junior:
        return 'junior';
      case DeveloperLevel.middle:
        return 'middle';
      case DeveloperLevel.senior:
        return 'senior';
      case DeveloperLevel.lead:
        return 'lead';
      case DeveloperLevel.unknown:
      default:
        return 'unknown';
    }
  }

  @override
  int get hashCode => from.index ^ to.index;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is DeveloperLevelJobAttribute && other.from == from && other.to == to);
}

/// Аттрибут работы - Возможность релокации (Relocation)
@immutable
@JsonSerializable()
class RelocationJobAttribute implements JobAttribute {
  const RelocationJobAttribute({
    required final this.relocation,
  });

  static const RelocationJobAttribute yes = RelocationJobAttribute(
    relocation: true,
  );

  static const RelocationJobAttribute no = RelocationJobAttribute(
    relocation: false,
  );
  static const String signature = 'relocation';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'relocation')
  final bool relocation;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => !relocation;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory RelocationJobAttribute.fromJson(Map<String, Object?> json) => _$RelocationJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$RelocationJobAttributeToJson(this);

  @override
  int get hashCode => relocation ? 1 : 0;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is RelocationJobAttribute && other.relocation == relocation);
}

/// Аттрибут работы - Тэги (Tags)
@immutable
@JsonSerializable()
class TagsJobAttribute implements JobAttribute {
  const TagsJobAttribute({
    required final this.tags,
  });

  static const TagsJobAttribute empty = TagsJobAttribute(
    tags: <String>[],
  );
  static const String signature = 'tags';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'tags')
  final List<String> tags;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => tags.isEmpty;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory TagsJobAttribute.fromJson(Map<String, Object?> json) => _$TagsJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$TagsJobAttributeToJson(this);

  @override
  int get hashCode => tags.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is TagsJobAttribute && const ListEquality<String>().equals(other.tags, tags));
}

/// Аттрибут работы - Навыки (Skills)
/// Языки, фреймвоки, пакеты
@immutable
@JsonSerializable()
class SkillsJobAttribute implements JobAttribute {
  const SkillsJobAttribute({
    required final this.skills,
  });

  static const SkillsJobAttribute empty = SkillsJobAttribute(
    skills: <Skill>[],
  );
  static const String signature = 'skills';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'skills')
  final List<Skill> skills;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => skills.isEmpty;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory SkillsJobAttribute.fromJson(Map<String, Object?> json) => _$SkillsJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SkillsJobAttributeToJson(this);

  @override
  int get hashCode => skills.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is SkillsJobAttribute && const ListEquality<Skill>().equals(other.skills, skills));
}

/// Аттрибут работы - Требования к разработчику (Requirements)
@immutable
@JsonSerializable()
class RequirementsJobAttribute implements JobAttribute {
  const RequirementsJobAttribute({
    required this.requirements,
  });

  static const RequirementsJobAttribute empty = RequirementsJobAttribute(requirements: '');

  static const String signature = 'requirements';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'requirements', required: true)
  final String requirements;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => requirements.isEmpty;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  RequirementsJobAttribute changeRequirements(String newRequirements) => RequirementsJobAttribute(
        requirements: newRequirements,
      );

  factory RequirementsJobAttribute.fromJson(Map<String, Object?> json) => _$RequirementsJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$RequirementsJobAttributeToJson(this);

  @override
  int get hashCode => requirements.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) || (other is RequirementsJobAttribute && other.requirements == requirements);
}

/// Аттрибут работы - Контакты для обратной связи (Contacts)
/// Емейл, Сайт, Телефон, Различные мессенджеры
@immutable
@JsonSerializable()
class ContactsJobAttribute implements JobAttribute {
  const ContactsJobAttribute({
    required this.contacts,
  });

  static const ContactsJobAttribute empty = ContactsJobAttribute(contacts: <Contact>[]);

  static const String signature = 'contacts';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'contacts', required: true)
  final List<Contact> contacts;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => contacts.isEmpty;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory ContactsJobAttribute.fromJson(Map<String, Object?> json) => _$ContactsJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$ContactsJobAttributeToJson(this);

  @override
  int get hashCode => contacts.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is ContactsJobAttribute && const ListEquality<Contact>().equals(other.contacts, contacts));
}

/// Виды работы
/// Полный рабочий день, Частичная занятость, Одноразовая работа, Работа по контракту,
/// Участие в опенсорс проекте, Поиск команды или сотрудничество
@immutable
@JsonSerializable()
class ContractTypeJobAttribute implements JobAttribute {
  const ContractTypeJobAttribute({
    required this.typesOfWork,
  });

  static const ContractTypeJobAttribute empty = ContractTypeJobAttribute(typesOfWork: <JobType>[]);

  static const String signature = 'contract_type';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  @JsonKey(name: 'types_of_work', required: true)
  final List<JobType> typesOfWork;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => typesOfWork.isEmpty || (typesOfWork.length == 1 && typesOfWork[0] == JobType.unknown);

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory ContractTypeJobAttribute.fromJson(Map<String, Object?> json) => _$ContractTypeJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$ContractTypeJobAttributeToJson(this);

  @override
  int get hashCode => typesOfWork.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is ContractTypeJobAttribute && const ListEquality<JobType>().equals(other.typesOfWork, typesOfWork));
}
