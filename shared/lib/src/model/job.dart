import 'dart:collection';
import 'dart:math' as math;

import 'package:dart_jobs_shared/src/model/country.dart';
import 'package:dart_jobs_shared/src/model/enum.dart';
import 'package:dart_jobs_shared/util.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';
part 'job.g.dart';

/// Кусок коллекции работ / список с работами
@immutable
class JobsChunk extends Iterable<Job> {
  const JobsChunk({
    required final List<Job> jobs,
    final this.endOfList = false,
  }) : _jobs = jobs;

  /// Generate Class from Map<String, Object?>
  factory JobsChunk.fromJson(Map<String, Object?> json) {
    final jobs = json['jobs'];
    return JobsChunk(
      endOfList: json['end_of_list'] == true,
      jobs: jobs is Iterable<Job> ? List<Job>.of(jobs) : [],
    );
  }

  /// Это последний кусок коллекции по указаному отбору
  /// Если true - значит по указаному запросу больше нечего получать
  final bool endOfList;

  final List<Job> _jobs;

  @override
  int get length => _jobs.length;

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => <String, Object?>{
        'end_of_list': endOfList,
        'jobs': _jobs.map<Map<String, Object?>>((e) => e.toJson()).toList(),
      };

  @override
  Iterator<Job> get iterator => _jobs.iterator;

  /*
  factory JobsChunk.fromProtobuf(proto.JobsChunk proto) => JobsChunk(
        endOfList: proto.endOfList,
        jobs: proto.jobs.map<Job>(Job.fromProtobuf).toList(),
      );

  proto.JobsChunk toProtobuf() => proto.JobsChunk(
        endOfList: endOfList,
        jobs: _jobs.map<proto.Job>((e) => e.toProtobuf()).toList(),
      );

  factory JobsChunk.fromBytes(List<int> bytes) => JobsChunk.fromProtobuf(proto.JobsChunk.fromBuffer(bytes));

  List<int> toBytes() => toProtobuf().writeToBuffer();
  */
}

/// Работа
@immutable
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
// ignore: prefer_mixin
class Job with _$Job, Comparable<Job> {
  const Job._();

  /// У работы не заполнен [id]
  bool get hasNotID => id.isNegative;

  /// У работы заполнен [id]
  bool get hasID => !hasNotID;

  const factory Job({
    /// Идентификатор элемента
    @JsonKey(name: 'id') required final int id,

    /// Идентификатор создателя
    @JsonKey(name: 'creator_id') required final String creatorId,

    /// Создано
    @JsonKey(name: 'created', fromJson: DateUtil.fromJson, toJson: DateUtil.toJson) required final DateTime created,

    /// Обновлено
    @JsonKey(name: 'updated', fromJson: DateUtil.fromJson, toJson: DateUtil.toJson) required final DateTime updated,

    /// Данные работы
    @JsonKey(name: 'job_data') required final JobData data,

    /// Пометка на удаление
    /// Если false - существует
    /// Если true - помечена на удаление
    @JsonKey(name: 'deletion_mark') @Default(false) final bool deletionMark,
  }) = _Job;

  /// Generate Class from Map<String, Object?>
  factory Job.fromJson(Map<String, Object?> json) => _$JobFromJson(json);

  /// Создает работу по id (полезно при создании роута по идентификатору)
  factory Job.id(int id) => Job(
        id: id,
        creatorId: '',
        created: DateTime(0),
        updated: DateTime(0),
        data: const JobData(title: 'Empty'),
      );

  /// Сортирую от новых к старым по полю [updated]
  @override
  int compareTo(Job other) => other.updated.compareTo(updated);

  /*
  factory Job.fromProtobuf(proto.Job job) => Job(
        id: job.id,
        creatorId: job.creatorId,
        //weight: job.weight.toInt(),
        created: job.created.toDateTime().toUtc(),
        updated: job.updated.toDateTime().toUtc(),
        data: JobData.fromProtobuf(job.jobData),
        deletionMark: job.deletionMark,
      );

  proto.Job toProtobuf() => proto.Job(
        creatorId: creatorId,
        created: proto.Timestamp.fromDateTime(created.toUtc()),
        updated: proto.Timestamp.fromDateTime(updated.toUtc()),
        id: id,
        //weight: proto.Int64(weight),
        deletionMark: deletionMark,
        jobData: data.toProtobuf(),
      );

  factory Job.fromBytes(List<int> bytes) => Job.fromProtobuf(proto.Job.fromBuffer(bytes));

  List<int> toBytes() => toProtobuf().writeToBuffer();
  */
}

/// Работа / данные работы
@immutable
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class JobData with _$JobData {
  const JobData._();

  const factory JobData({
    /// Заголовок
    /// Максимальная длина - 64 символов
    /// Поле ввода
    @JsonKey(name: 'title') @Default('') final String title,

    /// Компания, например: Horns and hooves
    /// Максимальная длина - 64 символов
    /// Поле ввода
    @JsonKey(name: 'company') @Default('') final String company,

    /// Страна, например: Russia
    /// Идентификатор страны
    /// Выпадающее поле поиска
    @JsonKey(name: 'country') @Default(Countries.unknownCode) final String country,

    /// Удаленная работа?
    /// Переключатель
    @JsonKey(name: 'remote') @Default(true) final bool remote,

    /// Возможность переезда
    /// Выбор
    @JsonKey(name: 'relocation') @Default(Relocation.impossible()) final Relocation relocation,

    /// Местоположение, например: Moscow
    /// Максимальная длина - 256 символов
    /// Поле ввода
    @JsonKey(name: 'address') @Default('') final String address,

    /// Описания на различных языках
    /// Ключ - локаль, например "en" или "ru"
    /// Максимальная длина - 2600 символов для каждого значения
    /// Значение - описание
    @JsonKey(name: 'descriptions') @Default(Description()) final Description descriptions,

    /// Уровень разработчика (Developer level)
    /// Чекбоксы, Chips
    @JsonKey(name: 'levels') @Default(<DeveloperLevel>[]) final List<DeveloperLevel> levels,

    /// Навыки (Skills)
    /// Поля ввода
    @JsonKey(name: 'skills') @Default(<String>[]) final List<String> skills,

    /// Контакты для обратной связи (Contacts)
    /// Емейл, Сайт, Телефон, Различные мессенджеры
    /// Поля ввода
    @JsonKey(name: 'contacts') @Default(<String>[]) final List<String> contacts,

    /// Трудоустройство, занятость (Employment)
    /// Полный рабочий день, Частичная занятость, Одноразовая работа, Работа по контракту,
    /// Участие в опенсорс проекте, Поиск команды или сотрудничество
    /// Чекбоксы, Chips
    @JsonKey(name: 'employments') @Default(<Employment>[]) final List<Employment> employments,

    /// Тэги (Tags)
    /// Поле ввода
    @JsonKey(name: 'tags') @Default(<String>[]) final List<String> tags,
  }) = _JobData;

  Country getCountry() => Country.byCode(country);

  /// Generate Class from Map<String, Object?>
  factory JobData.fromJson(Map<String, Object?> json) => _$JobDataFromJson(json);

  /// Англоязычное описание
  String get englishDescription => descriptions.english;

  /// Русскоязычное описание
  String get russianDescription => descriptions.russian;

  /*
  factory JobData.fromProtobuf(proto.JobData proto) => JobData(
        title: proto.title,
        remote: proto.remote,
        country: proto.country,
        address: proto.address,
        company: proto.company,
        contacts: proto.contacts.map<Contact>(Contact.fromProtobuf).toList(),
        descriptions: Description(proto.descriptions),
        employment: proto.employment.map<Employment>(Employment.fromProtobuf).toList(),
        levels: proto.levels.map<DeveloperLevel>(DeveloperLevel.fromProtobuf).toList(),
        skills: proto.skills.map<Skill>(Skill.fromProtobuf).toList(),
        tags: proto.tags,
      );

  proto.JobData toProtobuf() => proto.JobData(
        title: title,
        remote: remote,
        country: country,
        address: address,
        company: company,
        contacts: contacts.map<proto.Contact>((e) => e.toProtobuf()),
        descriptions: descriptions,
        employment: employment.map<proto.Employment>((e) => e.toProtobuf()),
        levels: levels.map<proto.DeveloperLevel>((e) => e.toProtobuf()),
        skills: skills.map<proto.Skill>((e) => e.toProtobuf()),
        tags: tags,
      );

  factory JobData.fromBytes(List<int> bytes) => JobData.fromProtobuf(proto.JobData.fromBuffer(bytes));

  List<int> toBytes() => toProtobuf().writeToBuffer();
  */
}

/// Описания на различных языках
/// Ключ - локаль, например "en" или "ru"
/// Максимальная длина - 2600 символов для каждого значения
/// Значение - описание
@immutable
class Description with MapMixin<String, String> {
  final Map<String, String> _internalMap;

  const Description([Map<String, String>? data]) : _internalMap = data ?? const <String, String>{};

  factory Description.fromLanguages({
    required final String english,
    required final String russian,
  }) =>
      Description(
        <String, String>{
          'en': english,
          'ru': russian,
        },
      );

  factory Description.fromJson(Map<String, Object?> json) => Description(
        <String, String>{
          for (final e in json.entries)
            if (e.value is String) e.key: e.value.toString(),
        },
      );

  String get english => this['en'] ?? '';

  String get russian => this['ru'] ?? '';

  Map<String, String> toJson() => Map<String, String>.of(_internalMap);

  @override
  String? operator [](Object? key) => _internalMap[key];

  @override
  void operator []=(String key, String value) => _internalMap[key] = value;

  @override
  void clear() => _internalMap.clear();

  @override
  Iterable<String> get keys => _internalMap.keys;

  @override
  String? remove(Object? key) => _internalMap.remove(key);
}

/// Фильтр для отбора сообщений
/// [before] и [after] это не период,
/// это значения используемые для паджинации и запроса последних соответсвенно
@immutable
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class JobFilter with _$JobFilter {
  const JobFilter._();

  const factory JobFilter({
    /// Ожидаемое количество
    /// Если не указано - 100
    @JsonKey(name: 'limit') @Default(100) final int limit,

    /// Удаленная работа?
    @JsonKey(name: 'remote') @Default(null) final bool? remote,

    /// Страна
    @JsonKey(name: 'country') @Default(null) final String? country,

    /// Уровни разработчика
    @JsonKey(name: 'level') @Default(null) final DeveloperLevel? level,

    /// Трудоустройство
    @JsonKey(name: 'employment') @Default(null) final Employment? employment,

    /// Возможность релокации
    @JsonKey(name: 'relocation') @Default(null) final bool? relocation,
  }) = PaginateJobFilter;

  /// Generate Class from Map<String, Object?>
  factory JobFilter.fromJson(Map<String, Object?> json) => _$JobFilterFromJson(json);

  Map<String, Object?> toQueryParameters() => <String, Object?>{
        'limit': math.min(limit, 100),
        'remote': remote,
        'country': country,
        'level': level,
        'employment': employment,
        'relocation': relocation,
      };

  /// Количество включенных фильтров
  int get count {
    var i = 0;
    remote.nullOr((_) => i++);
    country.nullOr((_) => i++);
    level.nullOr((_) => i++);
    employment.nullOr((_) => i++);
    relocation.nullOr((_) => i++);
    return i;
  }
}
