import 'package:json_annotation/json_annotation.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

import '../../feature/job/model/job.dart';
import '../../feature/resume/model/resume.dart';
import '../utils/date_util.dart';
import 'attributes.dart';

export '../../feature/job/model/job.dart';
export '../../feature/resume/model/resume.dart';
export '../utils/date_util.dart';
export 'attributes.dart';

part 'proposal.g.dart';

@immutable
@JsonSerializable(
  createFactory: false,
  createToJson: true,
)
abstract class Proposal<T extends Attribute> extends AttributesOwner<T> implements Comparable<Proposal> {
  @JsonKey(ignore: true)
  bool get isEmpty => id.isEmpty;

  @JsonKey(ignore: true)
  bool get isNotEmpty => id.isNotEmpty;

  @JsonKey(name: 'type', required: true)
  String get type;

  @JsonKey(name: 'pinned', required: false, disallowNullValue: false)
  final bool pinned;

  @JsonKey(name: 'id', required: true)
  final String id;

  @JsonKey(name: 'creator_id', required: true)
  final String creatorId;

  @JsonKey(name: 'title', required: true)
  final String title;

  @JsonKey(
    name: 'created',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime created;

  @JsonKey(
    name: 'updated',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime updated;

  const Proposal({
    required final this.id,
    required final this.creatorId,
    required final this.title,
    required final this.created,
    required final this.updated,
    final this.pinned = false,
  }) : super();

  /// Generate Class from Map<String, dynamic>
  static Proposal<Attribute> fromJson(Map<String, Object?> json) {
    final type = json['type'];
    switch (type) {
      case Job.signature:
        return Job.fromJson(json);
      case Resume.signature:
        return Resume.fromJson(json);
      case '':
      case null:
      default:
        final message = 'Unknown proposal type: "$type"';
        l.w(message);
        throw FormatException(message);
    }
  }

  /// Преобразовать в JSON хэш таблицу
  Map<String, Object?> toJson() => _$ProposalToJson(this);

  Result map<Result extends Object>({
    required final Result Function(Resume resume) resume,
    required final Result Function(Job job) job,
  });

  Result maybeMap<Result extends Object>({
    required final Result Function() orElse,
    final Result Function(Resume resume)? resume,
    final Result Function(Job job)? job,
  });

  @override
  Proposal<T> copyWith({
    String? newTitle,
    covariant Attributes<T>? newAttributes,
  });

  @override
  int compareTo(Proposal other) => created.compareTo(other.created);

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Job && id == other.id);

  @override
  @JsonKey(ignore: true)
  int get hashCode => id.hashCode;

  @override
  String toString() => 'id: $id, '
      'title: $title, '
      'created: $created, '
      'updated: $updated';
}
