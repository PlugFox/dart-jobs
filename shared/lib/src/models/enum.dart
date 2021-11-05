import 'package:freezed_annotation/freezed_annotation.dart';

part 'enum.freezed.dart';
part 'enum.g.dart';

/// Уровень разработчика
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class DeveloperLevel with _$DeveloperLevel {
  DeveloperLevel._();

  /// Стажёр
  @FreezedUnionValue('INTERN')
  const factory DeveloperLevel.intern() = InternDeveloperLevel;

  /// Младший
  @FreezedUnionValue('JUNIOR')
  const factory DeveloperLevel.junior() = JuniorDeveloperLevel;

  /// Средний
  @FreezedUnionValue('MIDDLE')
  const factory DeveloperLevel.middle() = MiddleDeveloperLevel;

  /// Старший
  @FreezedUnionValue('SENIOR')
  const factory DeveloperLevel.senior() = SeniorDeveloperLevel;

  /// Ведущий
  @FreezedUnionValue('LEAD')
  const factory DeveloperLevel.lead() = LeadDeveloperLevel;

  factory DeveloperLevel.fromJson(Map<String, Object?> json) => _$DeveloperLevelFromJson(json);

  static Map<String, DeveloperLevel> get values => const <String, DeveloperLevel>{
        'INTERN': InternDeveloperLevel(),
        'JUNIOR': JuniorDeveloperLevel(),
        'MIDDLE': MiddleDeveloperLevel(),
        'SENIOR': SeniorDeveloperLevel(),
        'LEAD': LeadDeveloperLevel(),
      };

  static DeveloperLevel valueOf(String name) => values[name.trim().toUpperCase()] ?? const MiddleDeveloperLevel();
}

/// Занятость
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class Employment with _$Employment {
  Employment._();

  /// Полный рабочий день (Full-time employment)
  @FreezedUnionValue('FULL_TIME')
  const factory Employment.fullTime() = FullTimeEmployment;

  /// Частичная занятость (Part-time employment)
  @FreezedUnionValue('PART_TIME')
  const factory Employment.partTime() = PartTimeEmployment;

  /// Одноразовая работа (one-time job)
  @FreezedUnionValue('ONE_TIME')
  const factory Employment.oneTime() = OneTimeEmployment;

  /// Работа по контракту (Contract job)
  @FreezedUnionValue('CONTRACT')
  const factory Employment.contract() = ContractEmployment;

  /// Участие в опенсорс проекте (Open source project)
  @FreezedUnionValue('OPEN_SOURCE')
  const factory Employment.openSource() = OpenSourceEmployment;

  /// Поиск команды или сотрудничество (Team search or collaboration)
  @FreezedUnionValue('COLLABORATION')
  const factory Employment.collaboration() = CollaborationEmployment;

  factory Employment.fromJson(Map<String, Object?> json) => _$EmploymentFromJson(json);

  static Map<String, Employment> get values => const <String, Employment>{
        'FULL_TIME': FullTimeEmployment(),
        'PART_TIME': PartTimeEmployment(),
        'ONE_TIME': OneTimeEmployment(),
        'CONTRACT': ContractEmployment(),
        'OPEN_SOURCE': OpenSourceEmployment(),
        'COLLABORATION': CollaborationEmployment(),
      };
  static Employment valueOf(String name) => values[name.trim().toUpperCase()] ?? const FullTimeEmployment();
}

/// Навык (Skill)
/// Язык, фреймвок, пакет и тп и тд
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class Skill with _$Skill {
  Skill._();

  /// Стажёр
  @FreezedUnionValue('UNKNOWN')
  const factory Skill.unknown(String value) = UnknownSkill;

  /// Младший
  @FreezedUnionValue('FRAMEWORK')
  const factory Skill.framework(String value) = FrameworkSkill;

  /// Средний
  @FreezedUnionValue('PACKAGE')
  const factory Skill.package(String value) = PackageSkill;

  factory Skill.fromJson(Map<String, Object?> json) => _$SkillFromJson(json);
}

/// Контакт для обратной связи (Contact)
/// Емейл, Сайт, Телефон, Различные мессенджеры и тп и тд
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class Contact with _$Contact {
  Contact._();

  /// Неопределено, не получено или не указано (Unknown)
  @FreezedUnionValue('UNKNOWN')
  const factory Contact.unknown(String value) = UnknownContact;

  /// Телефон
  @FreezedUnionValue('PHONE')
  const factory Contact.phone(String value) = PhoneContact;

  /// Сайт
  @FreezedUnionValue('WEBSITE')
  const factory Contact.website(String value) = WebsiteContact;

  /// Почта
  @FreezedUnionValue('EMAIL')
  const factory Contact.email(String value) = EmailContact;

  /// Телеграм
  @FreezedUnionValue('Telegram')
  const factory Contact.telegram(String value) = TelegramContact;

  factory Contact.fromJson(Map<String, Object?> json) => _$ContactFromJson(json);
}
