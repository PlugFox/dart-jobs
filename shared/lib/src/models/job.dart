import 'dart:collection';

import 'package:dart_jobs_shared/src/models/enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'job.freezed.dart';
part 'job.g.dart';

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class Job with _$Job {
  const factory Job({
    /// Вес элемента (влияет на сортировку)
    @JsonKey(name: 'weight') required final int weight,

    /// Идентификатор элемента
    @JsonKey(name: 'id') required final String id,

    /// Идентификатор создателя
    @JsonKey(name: 'creator_id') required final String creatorId,

    /// Создано
    @JsonKey(name: 'created') required final DateTime created,

    /// Обновлено
    @JsonKey(name: 'updated') required final DateTime updated,

    /// Данные работы
    @JsonKey(name: 'data') required final JobData data,
  }) = _Job;

  /// Generate Class from Map<String, dynamic>
  factory Job.fromJson(Map<String, Object?> json) => _$JobFromJson(json);
}

@Freezed(unionKey: 'type', unionValueCase: FreezedUnionCase.snake)
class JobData with _$JobData {
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
