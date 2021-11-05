// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'job.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Job _$JobFromJson(Map<String, dynamic> json) {
  return _Job.fromJson(json);
}

/// @nodoc
class _$JobTearOff {
  const _$JobTearOff();

  _Job call(
      {@JsonKey(name: 'id') required String id,
      @JsonKey(name: 'creator_id') required String creatorId,
      @JsonKey(name: 'weight') required int weight,
      @JsonKey(name: 'created') required DateTime created,
      @JsonKey(name: 'updated') required DateTime updated,
      @JsonKey(name: 'data') required JobData data,
      @JsonKey(name: 'deletion_mark') bool deletionMark = false}) {
    return _Job(
      id: id,
      creatorId: creatorId,
      weight: weight,
      created: created,
      updated: updated,
      data: data,
      deletionMark: deletionMark,
    );
  }

  Job fromJson(Map<String, Object?> json) {
    return Job.fromJson(json);
  }
}

/// @nodoc
const $Job = _$JobTearOff();

/// @nodoc
mixin _$Job {
  /// Идентификатор элемента
  @JsonKey(name: 'id')
  String get id => throw _privateConstructorUsedError;

  /// Идентификатор создателя
  @JsonKey(name: 'creator_id')
  String get creatorId => throw _privateConstructorUsedError;

  /// Вес элемента (влияет на сортировку)
  @JsonKey(name: 'weight')
  int get weight => throw _privateConstructorUsedError;

  /// Создано
  @JsonKey(name: 'created')
  DateTime get created => throw _privateConstructorUsedError;

  /// Обновлено
  @JsonKey(name: 'updated')
  DateTime get updated => throw _privateConstructorUsedError;

  /// Данные работы
  @JsonKey(name: 'data')
  JobData get data => throw _privateConstructorUsedError;

  /// Пометка на удаление
  /// Если false - существует
  /// Если true - помечена на удаление
  @JsonKey(name: 'deletion_mark')
  bool get deletionMark => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobCopyWith<Job> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobCopyWith<$Res> {
  factory $JobCopyWith(Job value, $Res Function(Job) then) =
      _$JobCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'creator_id') String creatorId,
      @JsonKey(name: 'weight') int weight,
      @JsonKey(name: 'created') DateTime created,
      @JsonKey(name: 'updated') DateTime updated,
      @JsonKey(name: 'data') JobData data,
      @JsonKey(name: 'deletion_mark') bool deletionMark});

  $JobDataCopyWith<$Res> get data;
}

/// @nodoc
class _$JobCopyWithImpl<$Res> implements $JobCopyWith<$Res> {
  _$JobCopyWithImpl(this._value, this._then);

  final Job _value;
  // ignore: unused_field
  final $Res Function(Job) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? creatorId = freezed,
    Object? weight = freezed,
    Object? created = freezed,
    Object? updated = freezed,
    Object? data = freezed,
    Object? deletionMark = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: creatorId == freezed
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated: updated == freezed
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as JobData,
      deletionMark: deletionMark == freezed
          ? _value.deletionMark
          : deletionMark // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $JobDataCopyWith<$Res> get data {
    return $JobDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value));
    });
  }
}

/// @nodoc
abstract class _$JobCopyWith<$Res> implements $JobCopyWith<$Res> {
  factory _$JobCopyWith(_Job value, $Res Function(_Job) then) =
      __$JobCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id') String id,
      @JsonKey(name: 'creator_id') String creatorId,
      @JsonKey(name: 'weight') int weight,
      @JsonKey(name: 'created') DateTime created,
      @JsonKey(name: 'updated') DateTime updated,
      @JsonKey(name: 'data') JobData data,
      @JsonKey(name: 'deletion_mark') bool deletionMark});

  @override
  $JobDataCopyWith<$Res> get data;
}

/// @nodoc
class __$JobCopyWithImpl<$Res> extends _$JobCopyWithImpl<$Res>
    implements _$JobCopyWith<$Res> {
  __$JobCopyWithImpl(_Job _value, $Res Function(_Job) _then)
      : super(_value, (v) => _then(v as _Job));

  @override
  _Job get _value => super._value as _Job;

  @override
  $Res call({
    Object? id = freezed,
    Object? creatorId = freezed,
    Object? weight = freezed,
    Object? created = freezed,
    Object? updated = freezed,
    Object? data = freezed,
    Object? deletionMark = freezed,
  }) {
    return _then(_Job(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      creatorId: creatorId == freezed
          ? _value.creatorId
          : creatorId // ignore: cast_nullable_to_non_nullable
              as String,
      weight: weight == freezed
          ? _value.weight
          : weight // ignore: cast_nullable_to_non_nullable
              as int,
      created: created == freezed
          ? _value.created
          : created // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updated: updated == freezed
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as JobData,
      deletionMark: deletionMark == freezed
          ? _value.deletionMark
          : deletionMark // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Job extends _Job {
  const _$_Job(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'creator_id') required this.creatorId,
      @JsonKey(name: 'weight') required this.weight,
      @JsonKey(name: 'created') required this.created,
      @JsonKey(name: 'updated') required this.updated,
      @JsonKey(name: 'data') required this.data,
      @JsonKey(name: 'deletion_mark') this.deletionMark = false})
      : super._();

  factory _$_Job.fromJson(Map<String, dynamic> json) => _$$_JobFromJson(json);

  @override

  /// Идентификатор элемента
  @JsonKey(name: 'id')
  final String id;
  @override

  /// Идентификатор создателя
  @JsonKey(name: 'creator_id')
  final String creatorId;
  @override

  /// Вес элемента (влияет на сортировку)
  @JsonKey(name: 'weight')
  final int weight;
  @override

  /// Создано
  @JsonKey(name: 'created')
  final DateTime created;
  @override

  /// Обновлено
  @JsonKey(name: 'updated')
  final DateTime updated;
  @override

  /// Данные работы
  @JsonKey(name: 'data')
  final JobData data;
  @override

  /// Пометка на удаление
  /// Если false - существует
  /// Если true - помечена на удаление
  @JsonKey(name: 'deletion_mark')
  final bool deletionMark;

  @override
  String toString() {
    return 'Job(id: $id, creatorId: $creatorId, weight: $weight, created: $created, updated: $updated, data: $data, deletionMark: $deletionMark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Job &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.creatorId, creatorId) ||
                other.creatorId == creatorId) &&
            (identical(other.weight, weight) || other.weight == weight) &&
            (identical(other.created, created) || other.created == created) &&
            (identical(other.updated, updated) || other.updated == updated) &&
            (identical(other.data, data) || other.data == data) &&
            (identical(other.deletionMark, deletionMark) ||
                other.deletionMark == deletionMark));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, id, creatorId, weight, created, updated, data, deletionMark);

  @JsonKey(ignore: true)
  @override
  _$JobCopyWith<_Job> get copyWith =>
      __$JobCopyWithImpl<_Job>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobToJson(this);
  }
}

abstract class _Job extends Job {
  const factory _Job(
      {@JsonKey(name: 'id') required String id,
      @JsonKey(name: 'creator_id') required String creatorId,
      @JsonKey(name: 'weight') required int weight,
      @JsonKey(name: 'created') required DateTime created,
      @JsonKey(name: 'updated') required DateTime updated,
      @JsonKey(name: 'data') required JobData data,
      @JsonKey(name: 'deletion_mark') bool deletionMark}) = _$_Job;
  const _Job._() : super._();

  factory _Job.fromJson(Map<String, dynamic> json) = _$_Job.fromJson;

  @override

  /// Идентификатор элемента
  @JsonKey(name: 'id')
  String get id;
  @override

  /// Идентификатор создателя
  @JsonKey(name: 'creator_id')
  String get creatorId;
  @override

  /// Вес элемента (влияет на сортировку)
  @JsonKey(name: 'weight')
  int get weight;
  @override

  /// Создано
  @JsonKey(name: 'created')
  DateTime get created;
  @override

  /// Обновлено
  @JsonKey(name: 'updated')
  DateTime get updated;
  @override

  /// Данные работы
  @JsonKey(name: 'data')
  JobData get data;
  @override

  /// Пометка на удаление
  /// Если false - существует
  /// Если true - помечена на удаление
  @JsonKey(name: 'deletion_mark')
  bool get deletionMark;
  @override
  @JsonKey(ignore: true)
  _$JobCopyWith<_Job> get copyWith => throw _privateConstructorUsedError;
}

JobData _$JobDataFromJson(Map<String, dynamic> json) {
  return _JobData.fromJson(json);
}

/// @nodoc
class _$JobDataTearOff {
  const _$JobDataTearOff();

  _JobData call(
      {@JsonKey(name: 'title')
          String title = '',
      @JsonKey(name: 'company')
          String company = '',
      @JsonKey(name: 'country')
          String country = '',
      @JsonKey(name: 'remote')
          bool remote = true,
      @JsonKey(name: 'address')
          String address = '',
      @JsonKey(name: 'descriptions')
          Description descriptions = const Description(),
      @JsonKey(name: 'levels')
          List<DeveloperLevel> levels = const <DeveloperLevel>[],
      @JsonKey(name: 'skills')
          List<Skill> skills = const <Skill>[],
      @JsonKey(name: 'contacts')
          List<String> contacts = const <String>[],
      @JsonKey(name: 'employment')
          List<Employment> employment = const <Employment>[],
      @JsonKey(name: 'tags')
          List<String> tags = const <String>[]}) {
    return _JobData(
      title: title,
      company: company,
      country: country,
      remote: remote,
      address: address,
      descriptions: descriptions,
      levels: levels,
      skills: skills,
      contacts: contacts,
      employment: employment,
      tags: tags,
    );
  }

  JobData fromJson(Map<String, Object?> json) {
    return JobData.fromJson(json);
  }
}

/// @nodoc
const $JobData = _$JobDataTearOff();

/// @nodoc
mixin _$JobData {
  /// Заголовок
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;

  /// Компания, например: Horns and hooves
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'company')
  String get company => throw _privateConstructorUsedError;

  /// Страна, например: Russia
  /// Максимальная длина - 64 символов
  /// Выпадающее поле выбора
  @JsonKey(name: 'country')
  String get country => throw _privateConstructorUsedError;

  /// Удаленная работа?
  /// Переключатель
  @JsonKey(name: 'remote')
  bool get remote => throw _privateConstructorUsedError;

  /// Местоположение, например: Moscow
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'address')
  String get address => throw _privateConstructorUsedError;

  /// Описания на различных языках
  /// Ключ - локаль, например "en" или "ru"
  /// Максимальная длина - 2600 символов для каждого значения
  /// Значение - описание
  @JsonKey(name: 'descriptions')
  Description get descriptions => throw _privateConstructorUsedError;

  /// Уровень разработчика (Developer level)
  /// Чекбоксы, Chips
  @JsonKey(name: 'levels')
  List<DeveloperLevel> get levels => throw _privateConstructorUsedError;

  /// Навыки (Skills)
  /// Поля ввода
  @JsonKey(name: 'skills')
  List<Skill> get skills => throw _privateConstructorUsedError;

  /// Контакты для обратной связи (Contacts)
  /// Емейл, Сайт, Телефон, Различные мессенджеры
  /// Поля ввода
  @JsonKey(name: 'contacts')
  List<String> get contacts => throw _privateConstructorUsedError;

  /// Трудоустройство, занятость (Employment)
  /// Полный рабочий день, Частичная занятость, Одноразовая работа, Работа по контракту,
  /// Участие в опенсорс проекте, Поиск команды или сотрудничество
  /// Чекбоксы, Chips
  @JsonKey(name: 'employment')
  List<Employment> get employment => throw _privateConstructorUsedError;

  /// Тэги (Tags)
  /// Поле ввода
  @JsonKey(name: 'tags')
  List<String> get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobDataCopyWith<JobData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobDataCopyWith<$Res> {
  factory $JobDataCopyWith(JobData value, $Res Function(JobData) then) =
      _$JobDataCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'title') String title,
      @JsonKey(name: 'company') String company,
      @JsonKey(name: 'country') String country,
      @JsonKey(name: 'remote') bool remote,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'descriptions') Description descriptions,
      @JsonKey(name: 'levels') List<DeveloperLevel> levels,
      @JsonKey(name: 'skills') List<Skill> skills,
      @JsonKey(name: 'contacts') List<String> contacts,
      @JsonKey(name: 'employment') List<Employment> employment,
      @JsonKey(name: 'tags') List<String> tags});
}

/// @nodoc
class _$JobDataCopyWithImpl<$Res> implements $JobDataCopyWith<$Res> {
  _$JobDataCopyWithImpl(this._value, this._then);

  final JobData _value;
  // ignore: unused_field
  final $Res Function(JobData) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? company = freezed,
    Object? country = freezed,
    Object? remote = freezed,
    Object? address = freezed,
    Object? descriptions = freezed,
    Object? levels = freezed,
    Object? skills = freezed,
    Object? contacts = freezed,
    Object? employment = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      company: company == freezed
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      remote: remote == freezed
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as bool,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      descriptions: descriptions == freezed
          ? _value.descriptions
          : descriptions // ignore: cast_nullable_to_non_nullable
              as Description,
      levels: levels == freezed
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<DeveloperLevel>,
      skills: skills == freezed
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      contacts: contacts == freezed
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      employment: employment == freezed
          ? _value.employment
          : employment // ignore: cast_nullable_to_non_nullable
              as List<Employment>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$JobDataCopyWith<$Res> implements $JobDataCopyWith<$Res> {
  factory _$JobDataCopyWith(_JobData value, $Res Function(_JobData) then) =
      __$JobDataCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'title') String title,
      @JsonKey(name: 'company') String company,
      @JsonKey(name: 'country') String country,
      @JsonKey(name: 'remote') bool remote,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'descriptions') Description descriptions,
      @JsonKey(name: 'levels') List<DeveloperLevel> levels,
      @JsonKey(name: 'skills') List<Skill> skills,
      @JsonKey(name: 'contacts') List<String> contacts,
      @JsonKey(name: 'employment') List<Employment> employment,
      @JsonKey(name: 'tags') List<String> tags});
}

/// @nodoc
class __$JobDataCopyWithImpl<$Res> extends _$JobDataCopyWithImpl<$Res>
    implements _$JobDataCopyWith<$Res> {
  __$JobDataCopyWithImpl(_JobData _value, $Res Function(_JobData) _then)
      : super(_value, (v) => _then(v as _JobData));

  @override
  _JobData get _value => super._value as _JobData;

  @override
  $Res call({
    Object? title = freezed,
    Object? company = freezed,
    Object? country = freezed,
    Object? remote = freezed,
    Object? address = freezed,
    Object? descriptions = freezed,
    Object? levels = freezed,
    Object? skills = freezed,
    Object? contacts = freezed,
    Object? employment = freezed,
    Object? tags = freezed,
  }) {
    return _then(_JobData(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      company: company == freezed
          ? _value.company
          : company // ignore: cast_nullable_to_non_nullable
              as String,
      country: country == freezed
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      remote: remote == freezed
          ? _value.remote
          : remote // ignore: cast_nullable_to_non_nullable
              as bool,
      address: address == freezed
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      descriptions: descriptions == freezed
          ? _value.descriptions
          : descriptions // ignore: cast_nullable_to_non_nullable
              as Description,
      levels: levels == freezed
          ? _value.levels
          : levels // ignore: cast_nullable_to_non_nullable
              as List<DeveloperLevel>,
      skills: skills == freezed
          ? _value.skills
          : skills // ignore: cast_nullable_to_non_nullable
              as List<Skill>,
      contacts: contacts == freezed
          ? _value.contacts
          : contacts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      employment: employment == freezed
          ? _value.employment
          : employment // ignore: cast_nullable_to_non_nullable
              as List<Employment>,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JobData extends _JobData {
  const _$_JobData(
      {@JsonKey(name: 'title') this.title = '',
      @JsonKey(name: 'company') this.company = '',
      @JsonKey(name: 'country') this.country = '',
      @JsonKey(name: 'remote') this.remote = true,
      @JsonKey(name: 'address') this.address = '',
      @JsonKey(name: 'descriptions') this.descriptions = const Description(),
      @JsonKey(name: 'levels') this.levels = const <DeveloperLevel>[],
      @JsonKey(name: 'skills') this.skills = const <Skill>[],
      @JsonKey(name: 'contacts') this.contacts = const <String>[],
      @JsonKey(name: 'employment') this.employment = const <Employment>[],
      @JsonKey(name: 'tags') this.tags = const <String>[]})
      : super._();

  factory _$_JobData.fromJson(Map<String, dynamic> json) =>
      _$$_JobDataFromJson(json);

  @override

  /// Заголовок
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'title')
  final String title;
  @override

  /// Компания, например: Horns and hooves
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'company')
  final String company;
  @override

  /// Страна, например: Russia
  /// Максимальная длина - 64 символов
  /// Выпадающее поле выбора
  @JsonKey(name: 'country')
  final String country;
  @override

  /// Удаленная работа?
  /// Переключатель
  @JsonKey(name: 'remote')
  final bool remote;
  @override

  /// Местоположение, например: Moscow
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'address')
  final String address;
  @override

  /// Описания на различных языках
  /// Ключ - локаль, например "en" или "ru"
  /// Максимальная длина - 2600 символов для каждого значения
  /// Значение - описание
  @JsonKey(name: 'descriptions')
  final Description descriptions;
  @override

  /// Уровень разработчика (Developer level)
  /// Чекбоксы, Chips
  @JsonKey(name: 'levels')
  final List<DeveloperLevel> levels;
  @override

  /// Навыки (Skills)
  /// Поля ввода
  @JsonKey(name: 'skills')
  final List<Skill> skills;
  @override

  /// Контакты для обратной связи (Contacts)
  /// Емейл, Сайт, Телефон, Различные мессенджеры
  /// Поля ввода
  @JsonKey(name: 'contacts')
  final List<String> contacts;
  @override

  /// Трудоустройство, занятость (Employment)
  /// Полный рабочий день, Частичная занятость, Одноразовая работа, Работа по контракту,
  /// Участие в опенсорс проекте, Поиск команды или сотрудничество
  /// Чекбоксы, Chips
  @JsonKey(name: 'employment')
  final List<Employment> employment;
  @override

  /// Тэги (Tags)
  /// Поле ввода
  @JsonKey(name: 'tags')
  final List<String> tags;

  @override
  String toString() {
    return 'JobData(title: $title, company: $company, country: $country, remote: $remote, address: $address, descriptions: $descriptions, levels: $levels, skills: $skills, contacts: $contacts, employment: $employment, tags: $tags)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JobData &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.company, company) || other.company == company) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.remote, remote) || other.remote == remote) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.descriptions, descriptions) ||
                other.descriptions == descriptions) &&
            const DeepCollectionEquality().equals(other.levels, levels) &&
            const DeepCollectionEquality().equals(other.skills, skills) &&
            const DeepCollectionEquality().equals(other.contacts, contacts) &&
            const DeepCollectionEquality()
                .equals(other.employment, employment) &&
            const DeepCollectionEquality().equals(other.tags, tags));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      company,
      country,
      remote,
      address,
      descriptions,
      const DeepCollectionEquality().hash(levels),
      const DeepCollectionEquality().hash(skills),
      const DeepCollectionEquality().hash(contacts),
      const DeepCollectionEquality().hash(employment),
      const DeepCollectionEquality().hash(tags));

  @JsonKey(ignore: true)
  @override
  _$JobDataCopyWith<_JobData> get copyWith =>
      __$JobDataCopyWithImpl<_JobData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobDataToJson(this);
  }
}

abstract class _JobData extends JobData {
  const factory _JobData(
      {@JsonKey(name: 'title') String title,
      @JsonKey(name: 'company') String company,
      @JsonKey(name: 'country') String country,
      @JsonKey(name: 'remote') bool remote,
      @JsonKey(name: 'address') String address,
      @JsonKey(name: 'descriptions') Description descriptions,
      @JsonKey(name: 'levels') List<DeveloperLevel> levels,
      @JsonKey(name: 'skills') List<Skill> skills,
      @JsonKey(name: 'contacts') List<String> contacts,
      @JsonKey(name: 'employment') List<Employment> employment,
      @JsonKey(name: 'tags') List<String> tags}) = _$_JobData;
  const _JobData._() : super._();

  factory _JobData.fromJson(Map<String, dynamic> json) = _$_JobData.fromJson;

  @override

  /// Заголовок
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'title')
  String get title;
  @override

  /// Компания, например: Horns and hooves
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'company')
  String get company;
  @override

  /// Страна, например: Russia
  /// Максимальная длина - 64 символов
  /// Выпадающее поле выбора
  @JsonKey(name: 'country')
  String get country;
  @override

  /// Удаленная работа?
  /// Переключатель
  @JsonKey(name: 'remote')
  bool get remote;
  @override

  /// Местоположение, например: Moscow
  /// Максимальная длина - 64 символов
  /// Поле ввода
  @JsonKey(name: 'address')
  String get address;
  @override

  /// Описания на различных языках
  /// Ключ - локаль, например "en" или "ru"
  /// Максимальная длина - 2600 символов для каждого значения
  /// Значение - описание
  @JsonKey(name: 'descriptions')
  Description get descriptions;
  @override

  /// Уровень разработчика (Developer level)
  /// Чекбоксы, Chips
  @JsonKey(name: 'levels')
  List<DeveloperLevel> get levels;
  @override

  /// Навыки (Skills)
  /// Поля ввода
  @JsonKey(name: 'skills')
  List<Skill> get skills;
  @override

  /// Контакты для обратной связи (Contacts)
  /// Емейл, Сайт, Телефон, Различные мессенджеры
  /// Поля ввода
  @JsonKey(name: 'contacts')
  List<String> get contacts;
  @override

  /// Трудоустройство, занятость (Employment)
  /// Полный рабочий день, Частичная занятость, Одноразовая работа, Работа по контракту,
  /// Участие в опенсорс проекте, Поиск команды или сотрудничество
  /// Чекбоксы, Chips
  @JsonKey(name: 'employment')
  List<Employment> get employment;
  @override

  /// Тэги (Tags)
  /// Поле ввода
  @JsonKey(name: 'tags')
  List<String> get tags;
  @override
  @JsonKey(ignore: true)
  _$JobDataCopyWith<_JobData> get copyWith =>
      throw _privateConstructorUsedError;
}

JobFilter _$JobFilterFromJson(Map<String, dynamic> json) {
  return _JobFilter.fromJson(json);
}

/// @nodoc
class _$JobFilterTearOff {
  const _$JobFilterTearOff();

  _JobFilter call(
      {@JsonKey(name: 'deletion_mark_included')
          bool deletionMarkIncluded = false,
      @JsonKey(name: 'limit')
          int limit = 100,
      @JsonKey(name: 'before')
          DateTime? before,
      @JsonKey(name: 'after')
          DateTime? after}) {
    return _JobFilter(
      deletionMarkIncluded: deletionMarkIncluded,
      limit: limit,
      before: before,
      after: after,
    );
  }

  JobFilter fromJson(Map<String, Object?> json) {
    return JobFilter.fromJson(json);
  }
}

/// @nodoc
const $JobFilter = _$JobFilterTearOff();

/// @nodoc
mixin _$JobFilter {
  /// Включать в выборку с пометкой на удаление
  /// false - только существующие
  /// true - существующие и помеченные на удаленние
  @JsonKey(name: 'deletion_mark_included')
  bool get deletionMarkIncluded => throw _privateConstructorUsedError;

  /// Ожидаемое количество
  /// Если не указано - 100
  @JsonKey(name: 'limit')
  int get limit => throw _privateConstructorUsedError;

  /// Создано до
  @JsonKey(name: 'before')
  DateTime? get before => throw _privateConstructorUsedError;

  /// Создано после
  @JsonKey(name: 'after')
  DateTime? get after => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JobFilterCopyWith<JobFilter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JobFilterCopyWith<$Res> {
  factory $JobFilterCopyWith(JobFilter value, $Res Function(JobFilter) then) =
      _$JobFilterCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'deletion_mark_included') bool deletionMarkIncluded,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'before') DateTime? before,
      @JsonKey(name: 'after') DateTime? after});
}

/// @nodoc
class _$JobFilterCopyWithImpl<$Res> implements $JobFilterCopyWith<$Res> {
  _$JobFilterCopyWithImpl(this._value, this._then);

  final JobFilter _value;
  // ignore: unused_field
  final $Res Function(JobFilter) _then;

  @override
  $Res call({
    Object? deletionMarkIncluded = freezed,
    Object? limit = freezed,
    Object? before = freezed,
    Object? after = freezed,
  }) {
    return _then(_value.copyWith(
      deletionMarkIncluded: deletionMarkIncluded == freezed
          ? _value.deletionMarkIncluded
          : deletionMarkIncluded // ignore: cast_nullable_to_non_nullable
              as bool,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      before: before == freezed
          ? _value.before
          : before // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      after: after == freezed
          ? _value.after
          : after // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$JobFilterCopyWith<$Res> implements $JobFilterCopyWith<$Res> {
  factory _$JobFilterCopyWith(
          _JobFilter value, $Res Function(_JobFilter) then) =
      __$JobFilterCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'deletion_mark_included') bool deletionMarkIncluded,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'before') DateTime? before,
      @JsonKey(name: 'after') DateTime? after});
}

/// @nodoc
class __$JobFilterCopyWithImpl<$Res> extends _$JobFilterCopyWithImpl<$Res>
    implements _$JobFilterCopyWith<$Res> {
  __$JobFilterCopyWithImpl(_JobFilter _value, $Res Function(_JobFilter) _then)
      : super(_value, (v) => _then(v as _JobFilter));

  @override
  _JobFilter get _value => super._value as _JobFilter;

  @override
  $Res call({
    Object? deletionMarkIncluded = freezed,
    Object? limit = freezed,
    Object? before = freezed,
    Object? after = freezed,
  }) {
    return _then(_JobFilter(
      deletionMarkIncluded: deletionMarkIncluded == freezed
          ? _value.deletionMarkIncluded
          : deletionMarkIncluded // ignore: cast_nullable_to_non_nullable
              as bool,
      limit: limit == freezed
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
      before: before == freezed
          ? _value.before
          : before // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      after: after == freezed
          ? _value.after
          : after // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JobFilter extends _JobFilter {
  const _$_JobFilter(
      {@JsonKey(name: 'deletion_mark_included')
          this.deletionMarkIncluded = false,
      @JsonKey(name: 'limit')
          this.limit = 100,
      @JsonKey(name: 'before')
          this.before,
      @JsonKey(name: 'after')
          this.after})
      : super._();

  factory _$_JobFilter.fromJson(Map<String, dynamic> json) =>
      _$$_JobFilterFromJson(json);

  @override

  /// Включать в выборку с пометкой на удаление
  /// false - только существующие
  /// true - существующие и помеченные на удаленние
  @JsonKey(name: 'deletion_mark_included')
  final bool deletionMarkIncluded;
  @override

  /// Ожидаемое количество
  /// Если не указано - 100
  @JsonKey(name: 'limit')
  final int limit;
  @override

  /// Создано до
  @JsonKey(name: 'before')
  final DateTime? before;
  @override

  /// Создано после
  @JsonKey(name: 'after')
  final DateTime? after;

  @override
  String toString() {
    return 'JobFilter(deletionMarkIncluded: $deletionMarkIncluded, limit: $limit, before: $before, after: $after)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _JobFilter &&
            (identical(other.deletionMarkIncluded, deletionMarkIncluded) ||
                other.deletionMarkIncluded == deletionMarkIncluded) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.before, before) || other.before == before) &&
            (identical(other.after, after) || other.after == after));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, deletionMarkIncluded, limit, before, after);

  @JsonKey(ignore: true)
  @override
  _$JobFilterCopyWith<_JobFilter> get copyWith =>
      __$JobFilterCopyWithImpl<_JobFilter>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JobFilterToJson(this);
  }
}

abstract class _JobFilter extends JobFilter {
  const factory _JobFilter(
      {@JsonKey(name: 'deletion_mark_included') bool deletionMarkIncluded,
      @JsonKey(name: 'limit') int limit,
      @JsonKey(name: 'before') DateTime? before,
      @JsonKey(name: 'after') DateTime? after}) = _$_JobFilter;
  const _JobFilter._() : super._();

  factory _JobFilter.fromJson(Map<String, dynamic> json) =
      _$_JobFilter.fromJson;

  @override

  /// Включать в выборку с пометкой на удаление
  /// false - только существующие
  /// true - существующие и помеченные на удаленние
  @JsonKey(name: 'deletion_mark_included')
  bool get deletionMarkIncluded;
  @override

  /// Ожидаемое количество
  /// Если не указано - 100
  @JsonKey(name: 'limit')
  int get limit;
  @override

  /// Создано до
  @JsonKey(name: 'before')
  DateTime? get before;
  @override

  /// Создано после
  @JsonKey(name: 'after')
  DateTime? get after;
  @override
  @JsonKey(ignore: true)
  _$JobFilterCopyWith<_JobFilter> get copyWith =>
      throw _privateConstructorUsedError;
}
