import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/utils/date_util.dart';
import '../../feed/model/proposal.dart';

part 'job.g.dart';

/// Работа
@immutable
@JsonSerializable()
class Job implements Proposal {
  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => !isNotEmpty;
  bool get hasData => data != null;
  bool get hasNotData => !hasData;

  @override
  @JsonKey(name: 'type', required: true)
  String get type => 'job';

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
  @JsonKey(
    name: 'data',
    required: true,
    includeIfNull: true,
    defaultValue: null,
    disallowNullValue: false,
  )
  final JobData? data;

  const Job({
    required this.id,
    required this.created,
    required this.updated,
    required this.data,
  });

  /// Generate Class from Map<String, dynamic>
  factory Job.fromJson(Map<String, Object?> json) => _$JobFromJson(json);

  /// Преобразовать в JSON хэш таблицу
  Map<String, Object?> toJson() => _$JobToJson(this);

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Job && id == other.id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Job( '
      'id: $id, '
      'updated: $updated )';
}

/// Детальное описание работы
@immutable
@JsonSerializable()
class JobData {
  /// Описание, до 1024 символов
  @JsonKey(
    name: 'description',
    required: false,
    disallowNullValue: false,
  )
  final String? description;

  const JobData({
    final this.description = '',
  });

  factory JobData.fromJson(Map<String, Object?> json) => _$JobDataFromJson(json);

  Map<String, Object?> toJson() => _$JobDataToJson(this);
}
