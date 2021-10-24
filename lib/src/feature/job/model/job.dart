import 'package:collection/collection.dart';
import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:dart_jobs/src/common/utils/money_util.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:money2/money2.dart';

part 'job.g.dart';

/// Работа
@immutable
@JsonSerializable(
  explicitToJson: true,
)
class Job extends Proposal<JobAttribute> {
  /// Сигнатура работы
  static const String signature = 'job';

  /// Тип
  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  /// Компания, например: Horns and hooves
  @JsonKey(name: 'company', required: true)
  final String company;

  /// Местоположение, например: Russia
  @JsonKey(name: 'country', required: true)
  final String country;

  /// Местоположение, например: Moscow
  @JsonKey(name: 'location', required: true)
  final String location;

  /// Удаленная работа?
  @JsonKey(name: 'remote', required: true)
  final bool remote;

  /// Зарплатная вилка - оклад начиная с
  /// Указывается в долларах * 100 (центы), в дальнейшем исходя из даты вакансии
  /// и курса обмена можно будет указывать в произвольной валюте
  @JsonKey(
    name: 'salary_from',
    required: true,
    fromJson: MoneyUtil.usdFromInt,
    toJson: MoneyUtil.usdToInt,
  )
  final Money salaryFrom;

  /// Зарплатная вилка - оклад по
  /// Указывается в долларах * 100 (центы), в дальнейшем исходя из даты вакансии
  /// и курса обмена можно будет указывать в произвольной валюте
  @JsonKey(
    name: 'salary_to',
    required: true,
    fromJson: MoneyUtil.usdFromInt,
    toJson: MoneyUtil.usdToInt,
  )
  final Money salaryTo;

  /// Данные элемента
  @override
  @JsonKey(name: 'attributes', ignore: true)
  final JobAttributes attributes;

  const Job._({
    required final String id,
    required final String creatorId,
    required final DateTime created,
    required final DateTime updated,
    required final String title,
    required final this.country,
    required final this.company,
    required final this.location,
    required final this.remote,
    required final this.salaryFrom,
    required final this.salaryTo,
    required final bool hasEnglishLocalization,
    required final bool hasRussianLocalization,
    required final this.attributes,
  }) : super(
          id: id,
          creatorId: creatorId,
          created: created,
          updated: updated,
          title: title,
          hasEnglishLocalization: hasEnglishLocalization,
          hasRussianLocalization: hasRussianLocalization,
        );

  factory Job({
    required final String id,
    required final String creatorId,
    required final DateTime created,
    required final DateTime updated,
    required final String title,
    final String? company,
    final String? country,
    final String? location,
    final bool? remote,
    final Money? salaryFrom,
    final Money? salaryTo,
    final JobAttributes? attributes,
  }) =>
      Job._(
        id: id,
        creatorId: creatorId,
        created: created,
        updated: updated,
        title: title,
        company: company ?? '',
        country: country ?? '',
        location: location ?? '',
        remote: remote ?? true,
        salaryFrom: salaryFrom ?? MoneyUtil.zeroMoney,
        salaryTo: salaryTo ?? MoneyUtil.zeroMoney,
        hasEnglishLocalization: attributes?.get(DescriptionJobAttribute.signature)?.isNotEmpty ?? false,
        hasRussianLocalization: attributes?.get(DescriptionRuJobAttribute.signature)?.isNotEmpty ?? false,
        attributes: attributes ?? const JobAttributes.empty(),
      );

  factory Job.create({
    required final String creatorId,
    required final String title,
    final String? company,
    final String? country,
    final String? location,
    final bool? remote,
    final Money? salaryFrom,
    final Money? salaryTo,
    final JobAttributes? attributes,
  }) {
    final now = DateTime.now().toUtc();
    return Job(
      id: '',
      creatorId: creatorId,
      created: now,
      updated: now,
      title: title,
      company: company,
      country: country,
      location: location,
      remote: remote,
      salaryFrom: salaryFrom,
      salaryTo: salaryTo,
      attributes: attributes,
    );
  }

  /// Generate Class from Map<String, dynamic>
  factory Job.fromJson(final Map<String, Object?> json) => _$JobFromJson(json);

  @override
  Map<String, Object?> toJson() => <String, Object?>{
        ...super.toJson(),
        ..._$JobToJson(this),
      };

  @override
  String toString() => 'Job(${super.toString()})';

  @override
  Result map<Result extends Object>({
    //required final Result Function(Resume resume) resume,
    required final Result Function(Job job) job,
  }) =>
      job(this);

  @override
  Result maybeMap<Result extends Object>({
    required final Result Function() orElse,
    //final Result Function(Resume resume)? resume,
    final Result Function(Job job)? job,
  }) =>
      job == null ? orElse() : job(this);

  @override
  Job copyWith({
    final String? newTitle,
    final String? newCompany,
    final String? newCountry,
    final String? newLocation,
    final bool? newRemote,
    final Money? newSalaryFrom,
    final Money? newSalaryTo,
    covariant final JobAttributes? newAttributes,
  }) =>
      Job(
        id: id,
        creatorId: creatorId,
        created: created,
        updated: DateTime.now().toUtc(),
        title: newTitle ?? title,
        company: newCompany ?? company,
        country: newCountry ?? country,
        location: newLocation ?? location,
        remote: newRemote ?? remote,
        salaryFrom: newSalaryFrom ?? salaryFrom,
        salaryTo: newSalaryTo ?? salaryTo,
        attributes: newAttributes ?? attributes,
      );

  @override
  Job setAttribute(covariant final JobAttribute attribute) => copyWith(
        newAttributes: attributes.set(attribute),
      );
}

/// Детальное описание работы
@immutable
class JobAttributes extends Attributes<JobAttribute> {
  const JobAttributes.empty() : super.empty();

  JobAttributes(final Iterable<JobAttribute> source) : super(source);

  JobAttributes._set(final Attributes<JobAttribute> attributes, final JobAttribute attribute)
      : super.set(attributes, attribute);

  JobAttributes._remove(final Attributes<JobAttribute> attributes, final String type) : super.remove(attributes, type);

  @override
  JobAttributes set(final JobAttribute attribute) => JobAttributes._set(this, attribute);

  @override
  JobAttributes removeByType(final String type) => JobAttributes._remove(this, type);

  /// Generate Class from List<Object?>
  factory JobAttributes.fromJson(final Map<String, Object?> json) => JobAttributes(
        (json['attributes'] as List<Object?>?)
                ?.whereType<Map<String, Object?>>()
                .map<JobAttribute?>(JobAttribute.fromJson)
                .whereNotNull() ??
            const Iterable<JobAttribute>.empty(),
      );
}

/// Аттрибут работы
@immutable
abstract class JobAttribute extends Attribute {
  @factory
  static JobAttribute? fromJson(final Map<String, Object?> json) {
    switch (json['type']) {
      case DescriptionJobAttribute.signature:
        return DescriptionJobAttribute.fromJson(json);
      case DescriptionRuJobAttribute.signature:
        return DescriptionRuJobAttribute.fromJson(json);
      case CoordinatesJobAttribute.signature:
        return CoordinatesJobAttribute.fromJson(json);
      case DeveloperLevelJobAttribute.signature:
        return DeveloperLevelJobAttribute.fromJson(json);
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

/// Аттрибут работы - Описание на латинице (Description)
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

  DescriptionRuJobAttribute changeDescription(final String newDescription) => DescriptionRuJobAttribute(
        description: newDescription,
      );

  factory DescriptionJobAttribute.fromJson(final Map<String, Object?> json) => _$DescriptionJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$DescriptionJobAttributeToJson(this);

  @override
  int get hashCode => description.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) || (other is DescriptionRuJobAttribute && other.description == description);
}

/// Аттрибут работы - Локализованное описание на русском (Description)
@immutable
@JsonSerializable()
class DescriptionRuJobAttribute implements JobAttribute {
  const DescriptionRuJobAttribute({
    required this.description,
  });

  static const DescriptionRuJobAttribute empty = DescriptionRuJobAttribute(description: '');

  static const String signature = 'description_ru';

  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  /// Описание на русском.
  /// Максимальная длинна - 2600
  @JsonKey(name: 'description', required: true)
  final String description;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => description.isEmpty;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  DescriptionRuJobAttribute changeDescription(final String newDescription) => DescriptionRuJobAttribute(
        description: newDescription,
      );

  factory DescriptionRuJobAttribute.fromJson(final Map<String, Object?> json) =>
      _$DescriptionRuJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$DescriptionRuJobAttributeToJson(this);

  @override
  int get hashCode => description.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) || (other is DescriptionRuJobAttribute && other.description == description);
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

  factory CoordinatesJobAttribute.fromJson(final Map<String, Object?> json) => _$CoordinatesJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$CoordinatesJobAttributeToJson(this);

  @override
  int get hashCode => latitude.hashCode ^ longitude.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) ||
      (other is CoordinatesJobAttribute && other.latitude == latitude && other.longitude == longitude);
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
  )
  final DeveloperLevel from;

  @JsonKey(
    name: 'to',
    required: true,
  )
  final DeveloperLevel to;

  @override
  @JsonKey(ignore: true)
  bool get isEmpty => from == DeveloperLevel.unknown && to == DeveloperLevel.unknown;

  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => !isEmpty;

  factory DeveloperLevelJobAttribute.fromJson(final Map<String, Object?> json) =>
      _$DeveloperLevelJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$DeveloperLevelJobAttributeToJson(this);

  @override
  int get hashCode => from.index ^ to.index;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) || (other is DeveloperLevelJobAttribute && other.from == from && other.to == to);
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

  factory TagsJobAttribute.fromJson(final Map<String, Object?> json) => _$TagsJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$TagsJobAttributeToJson(this);

  @override
  int get hashCode => tags.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) ||
      (other is TagsJobAttribute &&
          const ListEquality<String>().equals(
            other.tags,
            tags,
          ));
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

  factory SkillsJobAttribute.fromJson(final Map<String, Object?> json) => _$SkillsJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$SkillsJobAttributeToJson(this);

  @override
  int get hashCode => skills.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) ||
      (other is SkillsJobAttribute &&
          const ListEquality<Skill>().equals(
            other.skills,
            skills,
          ));
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

  RequirementsJobAttribute changeRequirements(final String newRequirements) => RequirementsJobAttribute(
        requirements: newRequirements,
      );

  factory RequirementsJobAttribute.fromJson(final Map<String, Object?> json) =>
      _$RequirementsJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$RequirementsJobAttributeToJson(this);

  @override
  int get hashCode => requirements.hashCode;

  @override
  bool operator ==(final Object other) =>
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

  factory ContactsJobAttribute.fromJson(final Map<String, Object?> json) => _$ContactsJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$ContactsJobAttributeToJson(this);

  @override
  int get hashCode => contacts.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) ||
      (other is ContactsJobAttribute &&
          const ListEquality<Contact>().equals(
            other.contacts,
            contacts,
          ));
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

  factory ContractTypeJobAttribute.fromJson(final Map<String, Object?> json) =>
      _$ContractTypeJobAttributeFromJson(json);

  @override
  Map<String, Object?> toJson() => _$ContractTypeJobAttributeToJson(this);

  @override
  int get hashCode => typesOfWork.hashCode;

  @override
  bool operator ==(final Object other) =>
      identical(other, this) ||
      (other is ContractTypeJobAttribute &&
          const ListEquality<JobType>().equals(
            other.typesOfWork,
            typesOfWork,
          ));
}
