import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/utils/date_util.dart';
import '../../job/model/job.dart';
import '../../resume/model/resume.dart';

export '../../job/model/job.dart';
export '../../resume/model/resume.dart';

part 'proposal.g.dart';

@immutable
abstract class Proposal implements Comparable<Proposal> {
  String get type;
  String get id;
  String get title;
  DateTime get created;
  DateTime get updated;
  String? get description;

  factory Proposal.fromJson(Map<String, Object?> json) {
    final type = json['type']?.toString();
    switch (type) {
      case Job.typeRepresentation:
        return Job.fromJson(json);
      case Resume.typeRepresentation:
        return Resume.fromJson(json);
      case '':
      case null:
      default:
        throw FormatException('Unknown proposal type: "$type"');
    }
  }

  Map<String, Object?> toJson();

  Result map<Result extends Object>({
    required final Result Function(Resume resume) resume,
    required final Result Function(Job job) job,
  });

  Result maybeMap<Result extends Object>({
    required final Result Function() orElse,
    final Result Function(Resume resume)? resume,
    final Result Function(Job job)? job,
  });
}

@immutable
@JsonSerializable()
class ProposalLocation {
  static const String remoteTitle = 'remote';

  bool get isRemote => title == remoteTitle;

  @JsonKey(name: 'title', required: true)
  final String title;

  @JsonKey(
    name: 'latitude',
    required: false,
    includeIfNull: false,
    disallowNullValue: false,
    defaultValue: null,
  )
  final double? latitude;

  @JsonKey(
    name: 'longitude',
    required: false,
    includeIfNull: false,
    disallowNullValue: false,
    defaultValue: null,
  )
  final double? longitude;

  const ProposalLocation({
    required this.title,
    this.latitude,
    this.longitude,
  });

  const ProposalLocation.remote()
      : title = remoteTitle,
        latitude = null,
        longitude = null;

  factory ProposalLocation.fromJson(Map<String, Object?> json) => _$ProposalLocationFromJson(json);

  Map<String, Object?> toJson() => _$ProposalLocationToJson(this);
}

/// Компания
@immutable
@JsonSerializable()
class Company {
  /// Идентификатор
  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'title', required: true)
  final String title;

  /// Заведено в программе (Unixtime в милисекундах)
  @JsonKey(
    name: 'created',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime created;

  /// Обновлено (Unixtime в милисекундах)
  @JsonKey(
    name: 'updated',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime updated;

  /// Описание, до 1024 символов
  @JsonKey(
    name: 'description',
    required: false,
    includeIfNull: true,
    disallowNullValue: false,
    defaultValue: null,
  )
  final String? description;

  const Company({
    required this.id,
    required this.created,
    required this.updated,
    required this.title,
    this.description,
  });

  factory Company.fromJson(Map<String, Object?> json) => _$CompanyFromJson(json);

  Map<String, Object?> toJson() => _$CompanyToJson(this);
}
