import 'dart:collection';

import 'package:dart_jobs_shared/src/models/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';
part 'job.g.dart';

/// Кусок коллекции работ / список с работами
@immutable
class JobsChunk extends Iterable<Job> {
  /// Это последний кусок коллекции по указаному отбору
  /// Если true - значит по указаному запросу больше нечего получать
  final bool endOfList;

  final List<Job> _jobs;

  const JobsChunk({
    required final List<Job> jobs,
    final this.endOfList = false,
  }) : _jobs = jobs;

  /// Generate Map<String, Object?> from class
  Map<String, Object?> toJson() => <String, Object?>{
        'end_of_list': endOfList,
        'jobs': _jobs.map<Map<String, Object?>>((e) => e.toJson()).toList(),
      };

  /// Generate Class from Map<String, Object?>
  factory JobsChunk.fromJson(Map<String, Object?> json) {
    final jobs = json['jobs'];
    return JobsChunk(
      endOfList: json['end_of_list'] == true,
      jobs: jobs is Iterable<Job> ? List<Job>.of(jobs) : [],
    );
  }

  @override
  Iterator<Job> get iterator => _jobs.iterator;
}

/// Работа
@immutable
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class Job with _$Job {
  const Job._();

  const factory Job({
    /// Идентификатор элемента
    @JsonKey(name: 'id') required final String id,

    /// Идентификатор создателя
    @JsonKey(name: 'creator_id') required final String creatorId,

    /// Вес элемента (влияет на сортировку)
    @JsonKey(name: 'weight') required final int weight,

    /// Создано
    @JsonKey(name: 'created') required final DateTime created,

    /// Обновлено
    @JsonKey(name: 'updated') required final DateTime updated,

    /// Данные работы
    @JsonKey(name: 'data') required final JobData data,

    /// Пометка на удаление
    /// Если false - существует
    /// Если true - помечена на удаление
    @JsonKey(name: 'deletion_mark') @Default(false) final bool deletionMark,
  }) = _Job;

  /// Generate Class from Map<String, dynamic>
  factory Job.fromJson(Map<String, Object?> json) => _$JobFromJson(json);
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
    /// Максимальная длина - 64 символов
    /// Выпадающее поле выбора
    @JsonKey(name: 'country') @Default('') final String country,

    /// Удаленная работа?
    /// Переключатель
    @JsonKey(name: 'remote') @Default(true) final bool remote,

    /// Местоположение, например: Moscow
    /// Максимальная длина - 64 символов
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
    @JsonKey(name: 'skills') @Default(<Skill>[]) final List<Skill> skills,

    /// Контакты для обратной связи (Contacts)
    /// Емейл, Сайт, Телефон, Различные мессенджеры
    /// Поля ввода
    @JsonKey(name: 'contacts') @Default(<String>[]) final List<String> contacts,

    /// Трудоустройство, занятость (Employment)
    /// Полный рабочий день, Частичная занятость, Одноразовая работа, Работа по контракту,
    /// Участие в опенсорс проекте, Поиск команды или сотрудничество
    /// Чекбоксы, Chips
    @JsonKey(name: 'employment') @Default(<Employment>[]) final List<Employment> employment,

    /// Тэги (Tags)
    /// Поле ввода
    @JsonKey(name: 'tags') @Default(<String>[]) final List<String> tags,
  }) = _JobData;

  /// Generate Class from Map<String, dynamic>
  factory JobData.fromJson(Map<String, Object?> json) => _$JobDataFromJson(json);
}

/// Описания на различных языках
/// Ключ - локаль, например "en" или "ru"
/// Максимальная длина - 2600 символов для каждого значения
/// Значение - описание
@immutable
class Description with MapMixin<String, String> {
  final Map<String, String> _internalMap;

  const Description([Map<String, String>? data]) : _internalMap = data ?? const <String, String>{};

  factory Description.fromJson(Map<String, Object?> json) => Description(
        <String, String>{
          for (final e in json.entries)
            if (e.value is String) e.key: e.value.toString(),
        },
      );

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
@immutable
@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class JobFilter with _$JobFilter {
  const JobFilter._();

  const factory JobFilter({
    /// Включать в выборку с пометкой на удаление
    /// false - только существующие
    /// true - существующие и помеченные на удаленние
    @JsonKey(name: 'deletion_mark_included') @Default(false) final bool deletionMarkIncluded,

    /// Ожидаемое количество
    /// Если не указано - 100
    @JsonKey(name: 'limit') @Default(100) final int limit,

    /// Создано до
    @JsonKey(name: 'before') final DateTime? before,

    /// Создано после
    @JsonKey(name: 'after') final DateTime? after,
  }) = _JobFilter;

  /// Generate Class from Map<String, dynamic>
  factory JobFilter.fromJson(Map<String, Object?> json) => _$JobFilterFromJson(json);
}
