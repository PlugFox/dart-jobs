import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/utils/date_util.dart';
import 'proposal.dart';

part 'resume.g.dart';

@immutable
@JsonSerializable()
class Resume implements Proposal {
  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => id.isNotEmpty;

  @override
  @JsonKey(name: 'type', required: true)
  String get type => 'resume';

  /// Идентификатор
  @override
  @JsonKey(name: 'id', required: true)
  final String id;

  /// Заведено в программе (Unixtime в милисекундах)
  @override
  @JsonKey(
    name: 'created',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime created;

  /// Обновлено (Unixtime в милисекундах)
  @override
  @JsonKey(
    name: 'updated',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime updated;

  /// Данные элемента
  @JsonKey(name: 'data', required: true)
  final ResumeData data;

  const Resume({
    required this.id,
    required this.created,
    required this.updated,
    required this.data,
  });

  /// Generate Class from Map<String, dynamic>
  factory Resume.fromJson(Map<String, Object?> json) => _$ResumeFromJson(json);

  /// Преобразовать в JSON хэш таблицу
  Map<String, Object?> toJson() => _$ResumeToJson(this);

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Resume && id == other.id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Resume( '
      'id: $id, '
      'updated: $updated )';
}

/// Детальное описание работы
@immutable
@JsonSerializable()
class ResumeData {
  /// Описание, до 1024 символов
  @JsonKey(
    name: 'description',
    required: false,
    disallowNullValue: false,
  )
  final String? description;

  const ResumeData({
    final this.description = '',
  });

  factory ResumeData.fromJson(Map<String, Object?> json) => _$ResumeDataFromJson(json);

  Map<String, Object?> toJson() => _$ResumeDataToJson(this);
}
