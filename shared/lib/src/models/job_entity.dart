import 'package:dart_jobs_shared/src/models/proposal_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'job_entity.g.dart';

/// Работа
@immutable
@JsonSerializable(
  createFactory: true,
  createToJson: true,
  explicitToJson: true,
)
class JobEntity extends ProposalEntity {
  /// Сигнатура работы
  static const String signature = 'job';

  /// Тип
  @override
  @JsonKey(name: 'type', required: true)
  String get type => signature;

  /// Компания, например: Horns and hooves
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'company', required: true)
  final String company;

  /// Местоположение, например: Russia
  /// Максимальная длина - 64 символов
  /// Выпадающее поле выбора
  @JsonKey(name: 'country', required: true)
  final String country;

  /// Местоположение, например: Moscow
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'address', required: true)
  final String address;

  /// Удаленная работа?
  /// Переключатель
  @JsonKey(name: 'remote', required: true)
  final bool remote;

  /// Уровень разработчика (Developer level)
  /// RangeSlider
  @JsonKey(name: 'level', required: true)
  final JobDeveloperLevel level;

  /// Тэги (Tags)
  /// Поле ввода
  @JsonKey(name: 'tags', required: true)
  final List<String> tags;

  /// Навыки (Skills)
  @JsonKey(name: 'skills', required: true)
  final List<Skill> skills;

  /// Контакты для обратной связи (Contacts)
  /// Емейл, Сайт, Телефон, Различные мессенджеры
  /// Поля ввода
  @JsonKey(name: 'contacts', required: true)
  final List<Contact> contacts;

  /// Трудоустройство (Employment)
  /// Полный рабочий день, Частичная занятость, Одноразовая работа, Работа по контракту,
  /// Участие в опенсорс проекте, Поиск команды или сотрудничество
  /// Чекбоксы
  @JsonKey(name: 'employment', required: true)
  final List<Employment> employment;

  const JobEntity({
    required final String id,
    required final String creatorId,
    required final DateTime created,
    required final DateTime updated,
    required final String title,
    required final this.company,
    required final this.country,
    required final this.remote,
    required final this.address,
    required final this.level,
    required final this.tags,
    required final this.skills,
    required final this.contacts,
    required final this.employment,
  }) : super(
          id: id,
          creatorId: creatorId,
          created: created,
          updated: updated,
          title: title,
        );

  /// Generate Class from Map<String, dynamic>
  factory JobEntity.fromJson(final Map<String, Object?> json) =>
      _$JobEntityFromJson(json);

  Map<String, Object?> toJson() => _$JobEntityToJson(this);

  @override
  String toString() => 'JobEntity(${super.toString()})';

  @factory
  JobEntity copyWith({
    required final String? newTitle,
    required final String? newCompany,
    required final String? newCountry,
    required final bool? newRemote,
    required final String? newAddress,
    required final JobDeveloperLevel? newLevel,
    required final List<String>? newTags,
    required final List<Skill>? newSkills,
    required final List<Contact>? newContacts,
    required final List<Employment>? newEmployment,
  }) =>
      JobEntity(
        id: id,
        creatorId: creatorId,
        created: created,
        updated: DateTime.now(),
        title: newTitle ?? title,
        company: newCompany ?? company,
        country: newCountry ?? country,
        remote: newRemote ?? remote,
        address: newAddress ?? address,
        level: newLevel ?? level,
        tags: newTags ?? tags,
        skills: newSkills ?? skills,
        contacts: newContacts ?? contacts,
        employment: newEmployment ?? employment,
      );
}

/// Аттрибут работы - Описание (Description)
@immutable
@JsonSerializable(
  createFactory: true,
  createToJson: true,
  explicitToJson: true,
)
class JobDescription {
  /// Описание на английском
  /// Максимальная длина - 2600 символов
  @JsonKey(name: 'en', required: true)
  final String en;

  /// Описание на русском.
  /// Максимальная длина - 2600 символов
  @JsonKey(name: 'ru', required: true)
  final String ru;

  const JobDescription({
    final this.ru = '',
    final this.en = '',
  });

  /// Generate Class from Map<String, dynamic>
  factory JobDescription.fromJson(final Map<String, Object?> json) =>
      _$JobDescriptionFromJson(json);

  Map<String, Object?> toJson() => _$JobDescriptionToJson(this);
}

/// Аттрибут работы - Уровень разработчика (Description)
@immutable
@JsonSerializable(
  createFactory: true,
  createToJson: true,
  explicitToJson: true,
)
class JobDeveloperLevel {
  /// Зарплатная вилка - оклад начиная с
  /// Указывается в долларах * 100 (центы), в дальнейшем исходя из даты вакансии
  /// и курса обмена можно будет указывать в произвольной валюте
  @JsonKey(name: 'from', required: true)
  final DeveloperLevel from;

  /// Зарплатная вилка - оклад по
  /// Указывается в долларах * 100 (центы), в дальнейшем исходя из даты вакансии
  /// и курса обмена можно будет указывать в произвольной валюте
  @JsonKey(name: 'to', required: true)
  final DeveloperLevel to;

  const JobDeveloperLevel({
    final this.from = DeveloperLevel.intern,
    final this.to = DeveloperLevel.lead,
  });

  /// Generate Class from Map<String, dynamic>
  factory JobDeveloperLevel.fromJson(final Map<String, Object?> json) =>
      _$JobDeveloperLevelFromJson(json);

  Map<String, Object?> toJson() => _$JobDeveloperLevelToJson(this);
}

/*
@immutable
@JsonSerializable(
  createFactory: true,
  createToJson: true,
  explicitToJson: true,
)
class JobSalary {
  /// Зарплатная вилка - оклад начиная с
  /// Указывается в долларах * 100 (центы), в дальнейшем исходя из даты вакансии
  /// и курса обмена можно будет указывать в произвольной валюте
  @JsonKey(
    name: 'from',
    required: true,
    fromJson: MoneyUtil.usdFromInt,
    toJson: MoneyUtil.usdToInt,
  )
  final Money from;

  /// Зарплатная вилка - оклад по
  /// Указывается в долларах * 100 (центы), в дальнейшем исходя из даты вакансии
  /// и курса обмена можно будет указывать в произвольной валюте
  @JsonKey(
    name: 'to',
    required: true,
    fromJson: MoneyUtil.usdFromInt,
    toJson: MoneyUtil.usdToInt,
  )
  final Money to;

  const JobSalary._(
    final this.from,
    final this.to,
  );

  factory JobSalary({
    final Money? from,
    final Money? to,
  }) =>
      JobSalary._(
        from ?? MoneyUtil.zeroMoney,
        to ?? MoneyUtil.zeroMoney,
      );

  /// Generate Class from Map<String, dynamic>
  factory JobSalary.fromJson(final Map<String, Object?> json) =>
      _$JobSalaryFromJson(json);

  Map<String, Object?> toJson() => _$JobSalaryToJson(this);
}
*/
