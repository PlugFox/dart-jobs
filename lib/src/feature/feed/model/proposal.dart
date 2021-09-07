import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

import '../../../common/utils/date_util.dart';
import '../../job/model/job.dart';
import '../../resume/model/resume.dart';

export '../../job/model/job.dart';
export '../../resume/model/resume.dart';

part 'proposal.g.dart';

@immutable
@JsonSerializable(
  createFactory: false,
  createToJson: true,
)
abstract class Proposal implements Comparable<Proposal> {
  bool get isEmpty => id.isEmpty;
  bool get isNotEmpty => id.isNotEmpty;

  @JsonKey(name: 'type', required: true)
  String get type;

  @JsonKey(name: 'id', required: true)
  final String id;

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

  ProposalAttributes get attributes;

  const Proposal({
    required final this.id,
    required final this.title,
    required final this.created,
    required final this.updated,
  });

  /// Generate Class from Map<String, dynamic>
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

  Proposal copyWith({
    String? newTitle,
    covariant ProposalAttributes? newAttributes,
  });

  @override
  int compareTo(Proposal other) => created.compareTo(other.created);

  @override
  bool operator ==(Object other) => identical(this, other) || (other is Job && id == other.id);

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => 'id: $id, '
      'title: $title, '
      'created: $created, '
      'updated: $updated';
}

@immutable
abstract class ProposalAttributes<T extends ProposalAttribute> extends Iterable<T> {
  final List<T> _list;

  @literal
  const ProposalAttributes.empty() : _list = const [];

  ProposalAttributes(Iterable<T> source) : _list = List<T>.of(source, growable: false);

  @override
  Iterator<T> get iterator => _list.iterator;

  T operator [](int index) => _list[index];

  @override
  bool operator ==(Object other) =>
      identical(other, this) ||
      (other is ProposalAttributes &&
          const ListEquality<Object>().equals(
            other._list,
            _list,
          ));

  @override
  int get hashCode => _list.hashCode;

  /// Преобразовать в JSON список
  List<Map<String, Object?>?> toJson() => _list
      .map<Map<String, Object?>>((e) => e.toJson()
        ..putIfAbsent(
          'type',
          () => e.type,
        ))
      .toList();
}

@immutable
abstract class ProposalAttribute {
  String get type;

  Map<String, Object?> toJson();
}
