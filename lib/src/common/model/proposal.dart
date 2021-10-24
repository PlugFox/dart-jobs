import 'package:dart_jobs/src/common/model/attributes.dart';
import 'package:dart_jobs/src/common/utils/date_util.dart';
import 'package:dart_jobs/src/feature/feed/model/feed_entity.dart';
import 'package:dart_jobs/src/feature/job/model/job.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';

export 'package:dart_jobs/src/common/model/attributes.dart';
export 'package:dart_jobs/src/common/utils/date_util.dart';
export 'package:dart_jobs/src/feature/job/model/job.dart';

part 'proposal.g.dart';

@immutable
@JsonSerializable(
  createFactory: false,
  createToJson: true,
  explicitToJson: true,
)
abstract class Proposal<T extends Attribute> extends AttributesOwner<T> implements FeedEntity {
  /// Не заполнена (нету id)
  @override
  @JsonKey(ignore: true)
  bool get isEmpty => id.isEmpty;

  /// Заполнена (есть id)
  @override
  @JsonKey(ignore: true)
  bool get isNotEmpty => id.isNotEmpty;

  /// Тип
  @override
  @JsonKey(name: 'type', required: true)
  String get type;

  /// Идентификатор
  @override
  @JsonKey(name: 'id', required: true)
  final String id;

  /// Идентификатор создателя
  @override
  @JsonKey(name: 'creator_id', required: true)
  final String creatorId;

  /// Создано
  @override
  @JsonKey(
    name: 'created',
    required: true,
    toJson: DateUtil.toTimestamp,
    fromJson: DateUtil.fromTimestamp,
  )
  final DateTime created;

  /// Обновлено
  @override
  @JsonKey(
    name: 'updated',
    required: true,
    toJson: DateUtil.toTimestamp,
    fromJson: DateUtil.fromTimestamp,
  )
  final DateTime updated;

  /// Заголовок
  @override
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
  int compareTo(final FeedEntity other) => updated.compareTo(other.updated);

  @override
  bool operator ==(final Object other) =>
      identical(this, other) || (other is Job && id == other.id && updated == other.updated);

  @override
  @JsonKey(ignore: true)
  int get hashCode => id.hashCode;

  @override
  String toString() => 'Proposal( '
      'id: $id, '
      'title: $title, '
      'created: $created, '
      'updated: $updated)';
}
