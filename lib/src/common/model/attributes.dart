import 'package:collection/collection.dart';
import 'package:dart_jobs/src/common/utils/date_util.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AttributesOwner<T extends Attribute> {
  const AttributesOwner();

  /// Коллекция аттрибутов
  Attributes<T> get attributes;

  /// Получить аттрибут по типу
  R? getAttribute<R extends T>(final String type) {
    final attribute = attributes[type];
    if (attribute is R) return attribute;
    return null;
  }

  /// Заменить аттрибуты новыми
  AttributesOwner<T> copyWith({
    covariant final Attributes<T>? newAttributes,
  });

  /// Установить аттрибут
  AttributesOwner<T> setAttribute(covariant final T attribute) => copyWith(
        newAttributes: attributes.set(attribute),
      );

  /// Удалить аттрибут
  AttributesOwner<T> removeAttribute(covariant final T attribute) => copyWith(
        newAttributes: attributes.remove(attribute),
      );
}

@immutable
abstract class Attributes<T extends Attribute> extends Iterable<T> {
  /// type : Attribute
  final Map<String, T> _internal;

  /// Пустая коллекция аттрибутов
  @literal
  const Attributes.empty() : _internal = const {};

  /// Создать коллекцию аттрибутов на основании другой коллекции аттрибутов
  Attributes(final Iterable<T> source)
      : assert(
          () {
            final set = <String>{};
            for (final e in source) {
              if (!set.add(e.type)) {
                l.w('В коллекции аттрибутов дублируется тип ${e.type}');
                return false;
              }
            }
            return true;
          }(),
          'Коллекция не должна содержать идентичных элементов',
        ),
        _internal = <String, T>{
          for (final a in source) a.type: a,
        };

  /// Создать коллекцию аттрибутов на основании других аттрибутов
  Attributes.of(final Attributes<T> attributes) : _internal = Map<String, T>.of(attributes._internal);

  /// Добавить/Обновить аттрибут
  Attributes.set(final Attributes<T> attributes, final T attribute)
      : _internal = Map<String, T>.of(attributes._internal)
          ..update(
            attribute.type,
            (final _) => attribute,
            ifAbsent: () => attribute,
          );

  /// Исключить аттрибут из списка
  Attributes.remove(final Attributes<T> attributes, final String type)
      : _internal = Map<String, T>.of(attributes._internal)..remove(type);

  @override
  Iterator<T> get iterator => _internal.values.iterator;

  /// Получить аттрибуты
  Iterable<T> get values => _internal.values;

  @override
  bool get isEmpty => _internal.values.where((final e) => e.isNotEmpty).isEmpty;

  @override
  bool get isNotEmpty => _internal.values.any((final e) => e.isNotEmpty);

  @override
  int get length => _internal.length;

  /// Содержит ли аттрибут указаного типа
  bool containsAttribute(final String type) => _internal.containsKey(type);

  /// Получить аттрибут по типу
  T? operator [](final String type) => get(type);

  /// Получить аттрибут по типу
  T? get(final String type) => _internal[type];

  /// Добавить/Обновить аттрибут
  Attributes<T> set(final T attribute);

  /// Удалить аттрибут
  Attributes<T> remove(final T attribute) => removeByType(attribute.type);

  /// Удалить аттрибут по типу
  Attributes<T> removeByType(final String type);

  @override
  bool operator ==(final Object other) =>
      identical(other, this) ||
      (other is Attributes &&
          const MapEquality<String, Object>().equals(
            other._internal,
            _internal,
          ));

  @override
  int get hashCode => _internal.hashCode;

  /// Преобразовать в JSON объект с вложенным списком аттрибутов
  /// [ownerId]   - идентификатор владельца коллекции, для ограничения доступа в Firebase
  /// [creatorId] - идентификатор владельца, для ограничения доступа в Firebase
  Map<String, Object?> toJson({required final String parentId, required final String creatorId}) => <String, Object?>{
        'parent_id': parentId,
        'creator_id': creatorId,
        'updated': DateUtil.dateToUnixTime(DateTime.now()),
        'attributes': _internal.values
            .where((final v) => v.isNotEmpty)
            .map<Map<String, Object?>>((final e) => e.toJson()..['type'] = e.type)
            .toList(growable: false),
      };
}

@immutable
abstract class Attribute {
  String get type;

  bool get isEmpty;

  bool get isNotEmpty => !isEmpty;

  const Attribute();

  @protected
  Map<String, Object?> toJson();
}

/// Квалификация, уровень разработчика
enum DeveloperLevel {
  /// Неизвестный / Не указан
  unknown,

  /// Стажёр
  intern,

  /// Младший
  junior,

  /// Средний
  middle,

  /// Старший
  senior,

  /// Ведущий
  lead,
}

/// Навык (Skill)
/// Язык, фреймвок, пакет
@immutable
abstract class Skill {
  /// Наименование
  String get title;

  // ignore: avoid_unused_constructor_parameters
  factory Skill.fromJson(final Map<String, Object?> json) => throw UnimplementedError();

  Map<String, Object?> toJson();
}

/// Контакт для обратной связи (Contact)
/// Емейл, Сайт, Телефон, Различные мессенджеры
@immutable
abstract class Contact {
  /// Наименование
  String get title;

  // ignore: avoid_unused_constructor_parameters
  factory Contact.fromJson(final Map<String, Object?> json) => throw UnimplementedError();

  Map<String, Object?> toJson();
}

/// Тип работы (Type of work)
enum JobType {
  /// Неизвестный / Не указан (Unknown)
  unknown,

  /// Полный рабочий день (Full-time employment)
  fullTime,

  /// Частичная занятость (Part-time employment)
  partTime,

  /// Одноразовая работа (one-time job)
  oneTime,

  /// Работа по контракту (Contract job)
  contract,

  /// Участие в опенсорс проекте (Open source project)
  openSource,

  /// Поиск команды или сотрудничество (Team search or collaboration)
  collaboration,
}
