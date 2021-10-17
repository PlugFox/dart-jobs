import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AttributesOwner<T extends Attribute> {
  const AttributesOwner();
  Attributes<T> get attributes;

  R? getAttribute<R extends Attribute>() {
    final attribute = attributes[R];
    if (attribute is R) return attribute;
    return null;
  }

  AttributesOwner<T> copyWith({
    covariant Attributes<T>? newAttributes,
  });

  AttributesOwner<T> setAttribute(covariant T attribute) => copyWith(
        newAttributes: attributes.set(attribute),
      );

  AttributesOwner<T> removeAttribute(covariant T attribute) => copyWith(
        newAttributes: attributes.remove(attribute),
      );
}

// Возможно стоит заменить с реализации хэштаблицы на Expando
// https://gist.github.com/PlugFox/21de83918e2228f3ea5d288c136fc716
@immutable
abstract class Attributes<T extends Attribute> extends Iterable<T> {
  final Map<Type, T> _internal;

  @literal
  const Attributes.empty() : _internal = const {};

  Attributes(Iterable<T> source)
      : _internal = <Type, T>{
          for (final a in source) a.runtimeType: a,
        };

  Attributes.of(Attributes<T> attributes) : _internal = Map<Type, T>.of(attributes._internal);

  Attributes.set(Attributes<T> attributes, T attribute)
      : _internal = Map<Type, T>.of(attributes._internal)
          ..update(
            attribute.runtimeType,
            (_) => attribute,
            ifAbsent: () => attribute,
          );

  Attributes.remove(Attributes<T> attributes, Type type)
      : _internal = Map<Type, T>.of(attributes._internal)..remove(type);

  @override
  Iterator<T> get iterator => _internal.values.iterator;

  Iterable<T> get values => _internal.values;

  T? operator [](Type type) => get(type);

  T? get(Type type) => _internal[type];

  Attributes<T> set(T attribute);

  Attributes<T> remove(T attribute) => removeByType(attribute.runtimeType);

  Attributes<T> removeByType(Type type);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is Attributes &&
          const MapEquality<Type, Object>().equals(
            other._internal,
            _internal,
          ));

  @override
  int get hashCode => _internal.hashCode;

  /// Преобразовать в JSON список
  List<Map<String, Object?>?> toJson() => _internal.values
      .where((v) => v.isNotEmpty)
      .map<Map<String, Object?>>((e) => e.toJson()
        ..putIfAbsent(
          'type',
          () => e.type,
        ))
      .toList();
}

@immutable
abstract class Attribute {
  String get type;

  bool get isEmpty;
  bool get isNotEmpty => !isEmpty;

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
  factory Skill.fromJson(Map<String, Object?> json) => throw UnimplementedError();

  Map<String, Object?> toJson();
}

/// Контакт для обратной связи (Contact)
/// Емейл, Сайт, Телефон, Различные мессенджеры
@immutable
abstract class Contact {
  /// Наименование
  String get title;

  // ignore: avoid_unused_constructor_parameters
  factory Contact.fromJson(Map<String, Object?> json) => throw UnimplementedError();

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
