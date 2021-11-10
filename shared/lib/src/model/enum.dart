import 'package:dart_jobs_shared/src/protobuf.dart' as proto;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'enum.freezed.dart';
part 'enum.g.dart';

/// Уровень разработчика
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class DeveloperLevel with _$DeveloperLevel {
  const DeveloperLevel._();

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

  factory DeveloperLevel.fromProtobuf(proto.DeveloperLevel? value) {
    switch (value) {
      case proto.DeveloperLevel.INTERN:
        return const DeveloperLevel.intern();
      case proto.DeveloperLevel.JUNIOR:
        return const DeveloperLevel.junior();
      case proto.DeveloperLevel.SENIOR:
        return const DeveloperLevel.senior();
      case proto.DeveloperLevel.LEAD:
        return const DeveloperLevel.lead();
      case proto.DeveloperLevel.MIDDLE:
      default:
        return const DeveloperLevel.middle();
    }
  }

  proto.DeveloperLevel toProtobuf() => map<proto.DeveloperLevel>(
        intern: (_) => proto.DeveloperLevel.INTERN,
        junior: (_) => proto.DeveloperLevel.JUNIOR,
        middle: (_) => proto.DeveloperLevel.MIDDLE,
        senior: (_) => proto.DeveloperLevel.SENIOR,
        lead: (_) => proto.DeveloperLevel.LEAD,
      );

  factory DeveloperLevel.fromBytes(int value) => DeveloperLevel.fromProtobuf(proto.DeveloperLevel.valueOf(value));

  int toBytes() => toProtobuf().value;

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
  const Employment._();

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

  factory Employment.fromProtobuf(proto.Employment? value) {
    switch (value) {
      case proto.Employment.PART_TIME:
        return const Employment.partTime();
      case proto.Employment.ONE_TIME:
        return const Employment.oneTime();
      case proto.Employment.CONTRACT:
        return const Employment.contract();
      case proto.Employment.OPEN_SOURCE:
        return const Employment.openSource();
      case proto.Employment.COLLABORATION:
        return const Employment.collaboration();
      case proto.Employment.FULL_TIME:
      default:
        return const Employment.fullTime();
    }
  }

  proto.Employment toProtobuf() => map<proto.Employment>(
        fullTime: (_) => proto.Employment.FULL_TIME,
        partTime: (_) => proto.Employment.PART_TIME,
        oneTime: (_) => proto.Employment.ONE_TIME,
        contract: (_) => proto.Employment.CONTRACT,
        openSource: (_) => proto.Employment.OPEN_SOURCE,
        collaboration: (_) => proto.Employment.COLLABORATION,
      );

  factory Employment.fromBytes(int value) => Employment.fromProtobuf(proto.Employment.valueOf(value));

  int toBytes() => toProtobuf().value;

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
  const Skill._();

  /// Неопределено, не получено или не указано (Unknown)
  @FreezedUnionValue('other')
  const factory Skill.other(String value) = OtherSkill;

  factory Skill.fromJson(Map<String, Object?> json) => _$SkillFromJson(json);

  factory Skill.fromProtobuf(proto.Skill skill) {
    switch (skill.type) {
      case proto.Skill_SkillType.OTHER:
      default:
        return Skill.other(skill.value);
    }
  }

  proto.Skill toProtobuf() => map<proto.Skill>(
        other: (skill) => proto.Skill(value: skill.value, type: proto.Skill_SkillType.OTHER),
      );

  factory Skill.fromBytes(List<int> bytes) => Skill.fromProtobuf(proto.Skill.fromBuffer(bytes));

  List<int> toBytes() => toProtobuf().writeToBuffer();
}

/// Контакт для обратной связи (Contact)
/// Емейл, Сайт, Телефон, Различные мессенджеры и тп и тд
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class Contact with _$Contact {
  const Contact._();

  /// Неопределено, не получено или не указано (Unknown)
  @FreezedUnionValue('OTHER')
  const factory Contact.other(String value) = OtherContact;

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

  factory Contact.fromProtobuf(proto.Contact contact) {
    switch (contact.type) {
      case proto.Contact_ContactType.PHONE:
        return Contact.phone(contact.value);
      case proto.Contact_ContactType.WEBSITE:
        return Contact.website(contact.value);
      case proto.Contact_ContactType.EMAIL:
        return Contact.email(contact.value);
      case proto.Contact_ContactType.TELEGRAM:
        return Contact.telegram(contact.value);
      case proto.Contact_ContactType.OTHER:
      default:
        return Contact.other(contact.value);
    }
  }

  proto.Contact toProtobuf() => map<proto.Contact>(
        other: (contact) => proto.Contact(type: proto.Contact_ContactType.OTHER, value: contact.value),
        phone: (contact) => proto.Contact(type: proto.Contact_ContactType.PHONE, value: contact.value),
        website: (contact) => proto.Contact(type: proto.Contact_ContactType.WEBSITE, value: contact.value),
        email: (contact) => proto.Contact(type: proto.Contact_ContactType.EMAIL, value: contact.value),
        telegram: (contact) => proto.Contact(type: proto.Contact_ContactType.TELEGRAM, value: contact.value),
      );

  factory Contact.fromBytes(List<int> bytes) => Contact.fromProtobuf(proto.Contact.fromBuffer(bytes));

  List<int> toBytes() => toProtobuf().writeToBuffer();
}
