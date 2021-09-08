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

  Map<String, Object?> toJson();
}
