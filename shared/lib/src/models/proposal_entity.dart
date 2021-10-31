import 'package:dart_jobs_shared/src/models/feed_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'proposal_entity.g.dart';

@immutable
@JsonSerializable(
  createFactory: false,
  createToJson: true,
  explicitToJson: true,
)
abstract class ProposalEntity implements FeedEntity {
  /// Не заполнена (нету id)
  @override
  @JsonKey(ignore: true)
  bool get isEmpty => id.isEmpty;

  /// Заполнена (есть id)
  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => id.isNotEmpty;

  /// Тип
  @override
  @JsonKey(name: 'type', required: true)
  String get type;

  /// Идентификатор
  @override
  @JsonKey(name: 'id', required: true)
  final String id;

  /// Идентификатор создателя
  @override
  @JsonKey(name: 'creator_id', required: true)
  final String creatorId;

  /// Создано
  @override
  @JsonKey(name: 'created', required: true)
  final DateTime created;

  /// Обновлено
  @override
  @JsonKey(name: 'updated', required: true)
  final DateTime updated;

  /// Заголовок
  @override
  @JsonKey(name: 'title', required: true)
  final String title;

  const ProposalEntity({
    required final this.id,
    required final this.creatorId,
    required final this.created,
    required final this.updated,
    required final this.title,
  }) : super();

  @override
  int compareTo(final FeedEntity other) => updated.compareTo(other.updated);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) ||
      (other is ProposalEntity &&
          type == other.type &&
          id == other.id &&
          updated == other.updated);

  @override
  @JsonKey(ignore: true)
  int get hashCode => id.hashCode;

  @override
  String toString() => 'ProposalEntity( '
      'id: $id, '
      'title: $title, '
      'created: $created, '
      'updated: $updated)';
}

/// Навык (Skill)
/// Язык, фреймвок, пакет
@immutable
abstract class Skill {
  /// Наименование
  String get title;

  // ignore: avoid_unused_constructor_parameters
  factory Skill.fromJson(final Map<String, Object?> json) =>
      throw UnimplementedError();

  Map<String, Object?> toJson();
}

/// Контакт для обратной связи (Contact)
/// Емейл, Сайт, Телефон, Различные мессенджеры
@immutable
abstract class Contact {
  /// Наименование
  String get title;

  // ignore: avoid_unused_constructor_parameters
  factory Contact.fromJson(final Map<String, Object?> json) =>
      throw UnimplementedError();

  Map<String, Object?> toJson();
}

/// Квалификация, уровень разработчика
@JsonEnum()
enum DeveloperLevel {
  /// Неизвестный / Не указан
  @JsonValue(-1)
  unknown,

  /// Стажёр
  @JsonValue(0)
  intern,

  /// Младший
  @JsonValue(1)
  junior,

  /// Средний
  @JsonValue(2)
  middle,

  /// Старший
  @JsonValue(3)
  senior,

  /// Ведущий
  @JsonValue(4)
  lead,
}

/// Тип работы (Type of work)
@JsonEnum()
enum Employment {
  /// Неизвестный / Не указан (Unknown)
  @JsonValue('unknown')
  unknown,

  /// Полный рабочий день (Full-time employment)
  @JsonValue('fullTime')
  fullTime,

  /// Частичная занятость (Part-time employment)
  @JsonValue('partTime')
  partTime,

  /// Одноразовая работа (one-time job)
  @JsonValue('oneTime')
  oneTime,

  /// Работа по контракту (Contract job)
  @JsonValue('contract')
  contract,

  /// Участие в опенсорс проекте (Open source project)
  @JsonValue('openSource')
  openSource,

  /// Поиск команды или сотрудничество (Team search or collaboration)
  @JsonValue('collaboration')
  collaboration,
}
