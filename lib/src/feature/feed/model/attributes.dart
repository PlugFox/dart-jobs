import 'package:collection/collection.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AttributesOwner<T extends Attribute> {
  const AttributesOwner();
  Attributes<T> get attributes;

  T? getAttribute(String type) => attributes[type];

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
  final Map<String, T> _internal;

  @literal
  const Attributes.empty() : _internal = const {};

  Attributes(Iterable<T> source)
      : _internal = <String, T>{
          for (final a in source) a.type: a,
        };

  Attributes.of(Attributes<T> attributes) : _internal = Map<String, T>.of(attributes._internal);

  Attributes.set(Attributes<T> attributes, T attribute)
      : _internal = Map<String, T>.of(attributes._internal)
          ..update(
            attribute.type,
            (_) => attribute,
            ifAbsent: () => attribute,
          );

  Attributes.remove(Attributes<T> attributes, String type)
      : _internal = Map<String, T>.of(attributes._internal)..remove(type);

  @override
  Iterator<T> get iterator => _internal.values.iterator;

  Iterable<T> get values => _internal.values;

  T? operator [](String type) => get(type);

  T? get(String type) => _internal[type];

  Attributes<T> set(T attribute);

  Attributes<T> remove(T attribute) => removeByType(attribute.type);

  Attributes<T> removeByType(String type);

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is Attributes &&
          const MapEquality<String, Object>().equals(
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
