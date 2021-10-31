import 'package:meta/meta.dart';

@immutable
abstract class FeedEntity implements Comparable<FeedEntity> {
  /// Не заполнена (нету id)
  bool get isEmpty => id.isEmpty;

  /// Заполнена (есть id)
  bool get isNotEmpty => id.isNotEmpty;

  /// Тип
  String get type;

  /// Идентификатор
  String get id;

  /// Идентификатор создателя
  String get creatorId;

  /// Создано
  DateTime get created;

  /// Обновлено
  DateTime get updated;

  /// Заголовок
  String get title;

  @override
  int compareTo(final FeedEntity other) => updated.compareTo(other.updated);

  @override
  String toString() => 'FeedEntity( '
      'id: $id, '
      'title: $title, '
      'created: $created, '
      'updated: $updated)';
}
