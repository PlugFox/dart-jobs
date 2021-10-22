import 'package:dart_jobs/src/common/model/attributes.dart';
import 'package:dart_jobs/src/common/utils/date_util.dart';
import 'package:dart_jobs/src/feature/job/model/job.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

export 'package:dart_jobs/src/common/model/attributes.dart';
//export '../../feature/resume/model/resume.dart';
export 'package:dart_jobs/src/common/utils/date_util.dart';
export 'package:dart_jobs/src/feature/job/model/job.dart';

part 'proposal.g.dart';

@immutable
@JsonSerializable(
  createFactory: false,
  createToJson: true,
  explicitToJson: true,
)
abstract class Proposal<T extends Attribute> extends AttributesOwner<T> implements Comparable<Proposal> {
  /// Не заполнена (нету id)
  @JsonKey(ignore: true)
  bool get isEmpty => id.isEmpty;

  /// Заполнена (есть id)
  @JsonKey(ignore: true)
  bool get isNotEmpty => id.isNotEmpty;

  /// Тип
  @JsonKey(name: 'type', required: true)
  String get type;

  /// Идентификатор
  @JsonKey(name: 'id', required: true)
  final String id;

  /// Идентификатор создателя
  @JsonKey(name: 'creator_id', required: true)
  final String creatorId;

  /// Создано
  @JsonKey(
    name: 'created',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime created;

  /// Обновлено
  @JsonKey(
    name: 'updated',
    required: true,
    toJson: DateUtil.dateToUnixTime,
    fromJson: DateUtil.dateFromUnixTime,
  )
  final DateTime updated;

  @JsonKey(name: 'title', required: true)
  final String title;

  /// Есть описание на английском
  @JsonKey(name: 'has_english_localization', required: true)
  final bool hasEnglishLocalization;

  /// Есть описание на русском
  @JsonKey(name: 'has_russian_localization', required: true)
  final bool hasRussianLocalization;

  const Proposal({
    required final this.id,
    required final this.creatorId,
    required final this.created,
    required final this.updated,
    required final this.title,
    required final this.hasEnglishLocalization,
    required final this.hasRussianLocalization,
  }) : super();

  /// Generate Class from Map<String, dynamic>
  static Proposal<Attribute> fromJson(final Map<String, Object?> json) {
    final type = json['type'];
    switch (type) {
      case Job.signature:
        return Job.fromJson(json);
      //case Resume.signature:
      //  return Resume.fromJson(json);
      case '':
      case null:
      default:
        final message = 'Unknown proposal type: "$type"';
        l.w(message);
        throw FormatException(message);
    }
  }

  /// Преобразовать в JSON хэш таблицу
  Map<String, Object?> toJson() => _$ProposalToJson(this)..['type'] = type;

  Result map<Result extends Object>({
    //required final Result Function(Resume resume) resume,
    required final Result Function(Job job) job,
  });

  Result maybeMap<Result extends Object>({
    required final Result Function() orElse,
    //final Result Function(Resume resume)? resume,
    final Result Function(Job job)? job,
  });

  @override
  Proposal<T> copyWith({
    final String? newTitle,
    covariant final Attributes<T>? newAttributes,
  });

  @override
  int compareTo(final Proposal other) => created.compareTo(other.created);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) || (other is Job && id == other.id && updated == other.updated);

  @override
  @JsonKey(ignore: true)
  int get hashCode => id.hashCode;

  @override
  String toString() => 'id: $id, '
      'title: $title, '
      'created: $created, '
      'updated: $updated';
}
