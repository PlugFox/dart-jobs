import 'package:dart_jobs_shared/grpc.dart' as grpc;
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

  factory DeveloperLevel.fromProtobuf(grpc.DeveloperLevel proto) {
    switch (proto) {
      case grpc.DeveloperLevel.INTERN:
        return const DeveloperLevel.intern();
      case grpc.DeveloperLevel.JUNIOR:
        return const DeveloperLevel.junior();
      case grpc.DeveloperLevel.SENIOR:
        return const DeveloperLevel.senior();
      case grpc.DeveloperLevel.LEAD:
        return const DeveloperLevel.lead();
      case grpc.DeveloperLevel.MIDDLE:
      default:
        return const DeveloperLevel.middle();
    }
  }

  grpc.DeveloperLevel toProtobuf() => map<grpc.DeveloperLevel>(
        intern: (_) => grpc.DeveloperLevel.INTERN,
        junior: (_) => grpc.DeveloperLevel.JUNIOR,
        middle: (_) => grpc.DeveloperLevel.MIDDLE,
        senior: (_) => grpc.DeveloperLevel.SENIOR,
        lead: (_) => grpc.DeveloperLevel.LEAD,
      );

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

  factory Employment.fromProtobuf(grpc.Employment proto) {
    switch (proto) {
      case grpc.Employment.PART_TIME:
        return const Employment.partTime();
      case grpc.Employment.ONE_TIME:
        return const Employment.oneTime();
      case grpc.Employment.CONTRACT:
        return const Employment.contract();
      case grpc.Employment.OPEN_SOURCE:
        return const Employment.openSource();
      case grpc.Employment.COLLABORATION:
        return const Employment.collaboration();
      case grpc.Employment.FULL_TIME:
      default:
        return const Employment.fullTime();
    }
  }

  grpc.Employment toProtobuf() => map<grpc.Employment>(
        fullTime: (_) => grpc.Employment.FULL_TIME,
        partTime: (_) => grpc.Employment.PART_TIME,
        oneTime: (_) => grpc.Employment.ONE_TIME,
        contract: (_) => grpc.Employment.CONTRACT,
        openSource: (_) => grpc.Employment.OPEN_SOURCE,
        collaboration: (_) => grpc.Employment.COLLABORATION,
      );

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

  factory Skill.fromProtobuf(grpc.Skill proto) {
    switch (proto.type) {
      case grpc.Skill_SkillType.OTHER:
      default:
        return Skill.other(proto.value);
    }
  }

  grpc.Skill toProtobuf() => map<grpc.Skill>(
        other: (skill) => grpc.Skill(value: skill.value, type: grpc.Skill_SkillType.OTHER),
      );
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

  factory Contact.fromProtobuf(grpc.Contact proto) {
    switch (proto.type) {
      case grpc.Contact_ContactType.PHONE:
        return Contact.phone(proto.value);
      case grpc.Contact_ContactType.WEBSITE:
        return Contact.website(proto.value);
      case grpc.Contact_ContactType.EMAIL:
        return Contact.email(proto.value);
      case grpc.Contact_ContactType.TELEGRAM:
        return Contact.telegram(proto.value);
      case grpc.Contact_ContactType.OTHER:
      default:
        return Contact.other(proto.value);
    }
  }

  grpc.Contact toProtobuf() => map<grpc.Contact>(
        other: (contact) => grpc.Contact(type: grpc.Contact_ContactType.OTHER, value: contact.value),
        phone: (contact) => grpc.Contact(type: grpc.Contact_ContactType.PHONE, value: contact.value),
        website: (contact) => grpc.Contact(type: grpc.Contact_ContactType.WEBSITE, value: contact.value),
        email: (contact) => grpc.Contact(type: grpc.Contact_ContactType.EMAIL, value: contact.value),
        telegram: (contact) => grpc.Contact(type: grpc.Contact_ContactType.TELEGRAM, value: contact.value),
      );
}
