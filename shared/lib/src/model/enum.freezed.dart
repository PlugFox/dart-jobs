// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'enum.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DeveloperLevel _$DeveloperLevelFromJson(Map<String, dynamic> json) {
  switch (json['type'] as String?) {
    case 'INTERN':
      return InternDeveloperLevel.fromJson(json);
    case 'JUNIOR':
      return JuniorDeveloperLevel.fromJson(json);
    case 'MIDDLE':
      return MiddleDeveloperLevel.fromJson(json);
    case 'SENIOR':
      return SeniorDeveloperLevel.fromJson(json);
    case 'LEAD':
      return LeadDeveloperLevel.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'DeveloperLevel',
          'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
class _$DeveloperLevelTearOff {
  const _$DeveloperLevelTearOff();

  InternDeveloperLevel intern() {
    return const InternDeveloperLevel();
  }

  JuniorDeveloperLevel junior() {
    return const JuniorDeveloperLevel();
  }

  MiddleDeveloperLevel middle() {
    return const MiddleDeveloperLevel();
  }

  SeniorDeveloperLevel senior() {
    return const SeniorDeveloperLevel();
  }

  LeadDeveloperLevel lead() {
    return const LeadDeveloperLevel();
  }

  DeveloperLevel fromJson(Map<String, Object?> json) {
    return DeveloperLevel.fromJson(json);
  }
}

/// @nodoc
const $DeveloperLevel = _$DeveloperLevelTearOff();

/// @nodoc
mixin _$DeveloperLevel {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() intern,
    required TResult Function() junior,
    required TResult Function() middle,
    required TResult Function() senior,
    required TResult Function() lead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InternDeveloperLevel value) intern,
    required TResult Function(JuniorDeveloperLevel value) junior,
    required TResult Function(MiddleDeveloperLevel value) middle,
    required TResult Function(SeniorDeveloperLevel value) senior,
    required TResult Function(LeadDeveloperLevel value) lead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeveloperLevelCopyWith<$Res> {
  factory $DeveloperLevelCopyWith(
          DeveloperLevel value, $Res Function(DeveloperLevel) then) =
      _$DeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$DeveloperLevelCopyWithImpl<$Res>
    implements $DeveloperLevelCopyWith<$Res> {
  _$DeveloperLevelCopyWithImpl(this._value, this._then);

  final DeveloperLevel _value;
  // ignore: unused_field
  final $Res Function(DeveloperLevel) _then;
}

/// @nodoc
abstract class $InternDeveloperLevelCopyWith<$Res> {
  factory $InternDeveloperLevelCopyWith(InternDeveloperLevel value,
          $Res Function(InternDeveloperLevel) then) =
      _$InternDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$InternDeveloperLevelCopyWithImpl<$Res>
    extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $InternDeveloperLevelCopyWith<$Res> {
  _$InternDeveloperLevelCopyWithImpl(
      InternDeveloperLevel _value, $Res Function(InternDeveloperLevel) _then)
      : super(_value, (v) => _then(v as InternDeveloperLevel));

  @override
  InternDeveloperLevel get _value => super._value as InternDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('INTERN')
class _$InternDeveloperLevel extends InternDeveloperLevel {
  const _$InternDeveloperLevel() : super._();

  factory _$InternDeveloperLevel.fromJson(Map<String, dynamic> json) =>
      _$$InternDeveloperLevelFromJson(json);

  @override
  String toString() {
    return 'DeveloperLevel.intern()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is InternDeveloperLevel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() intern,
    required TResult Function() junior,
    required TResult Function() middle,
    required TResult Function() senior,
    required TResult Function() lead,
  }) {
    return intern();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
  }) {
    return intern?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
    required TResult orElse(),
  }) {
    if (intern != null) {
      return intern();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InternDeveloperLevel value) intern,
    required TResult Function(JuniorDeveloperLevel value) junior,
    required TResult Function(MiddleDeveloperLevel value) middle,
    required TResult Function(SeniorDeveloperLevel value) senior,
    required TResult Function(LeadDeveloperLevel value) lead,
  }) {
    return intern(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
  }) {
    return intern?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
    required TResult orElse(),
  }) {
    if (intern != null) {
      return intern(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$InternDeveloperLevelToJson(this)..['type'] = 'INTERN';
  }
}

abstract class InternDeveloperLevel extends DeveloperLevel {
  const factory InternDeveloperLevel() = _$InternDeveloperLevel;
  const InternDeveloperLevel._() : super._();

  factory InternDeveloperLevel.fromJson(Map<String, dynamic> json) =
      _$InternDeveloperLevel.fromJson;
}

/// @nodoc
abstract class $JuniorDeveloperLevelCopyWith<$Res> {
  factory $JuniorDeveloperLevelCopyWith(JuniorDeveloperLevel value,
          $Res Function(JuniorDeveloperLevel) then) =
      _$JuniorDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$JuniorDeveloperLevelCopyWithImpl<$Res>
    extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $JuniorDeveloperLevelCopyWith<$Res> {
  _$JuniorDeveloperLevelCopyWithImpl(
      JuniorDeveloperLevel _value, $Res Function(JuniorDeveloperLevel) _then)
      : super(_value, (v) => _then(v as JuniorDeveloperLevel));

  @override
  JuniorDeveloperLevel get _value => super._value as JuniorDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('JUNIOR')
class _$JuniorDeveloperLevel extends JuniorDeveloperLevel {
  const _$JuniorDeveloperLevel() : super._();

  factory _$JuniorDeveloperLevel.fromJson(Map<String, dynamic> json) =>
      _$$JuniorDeveloperLevelFromJson(json);

  @override
  String toString() {
    return 'DeveloperLevel.junior()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is JuniorDeveloperLevel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() intern,
    required TResult Function() junior,
    required TResult Function() middle,
    required TResult Function() senior,
    required TResult Function() lead,
  }) {
    return junior();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
  }) {
    return junior?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
    required TResult orElse(),
  }) {
    if (junior != null) {
      return junior();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InternDeveloperLevel value) intern,
    required TResult Function(JuniorDeveloperLevel value) junior,
    required TResult Function(MiddleDeveloperLevel value) middle,
    required TResult Function(SeniorDeveloperLevel value) senior,
    required TResult Function(LeadDeveloperLevel value) lead,
  }) {
    return junior(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
  }) {
    return junior?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
    required TResult orElse(),
  }) {
    if (junior != null) {
      return junior(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$JuniorDeveloperLevelToJson(this)..['type'] = 'JUNIOR';
  }
}

abstract class JuniorDeveloperLevel extends DeveloperLevel {
  const factory JuniorDeveloperLevel() = _$JuniorDeveloperLevel;
  const JuniorDeveloperLevel._() : super._();

  factory JuniorDeveloperLevel.fromJson(Map<String, dynamic> json) =
      _$JuniorDeveloperLevel.fromJson;
}

/// @nodoc
abstract class $MiddleDeveloperLevelCopyWith<$Res> {
  factory $MiddleDeveloperLevelCopyWith(MiddleDeveloperLevel value,
          $Res Function(MiddleDeveloperLevel) then) =
      _$MiddleDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$MiddleDeveloperLevelCopyWithImpl<$Res>
    extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $MiddleDeveloperLevelCopyWith<$Res> {
  _$MiddleDeveloperLevelCopyWithImpl(
      MiddleDeveloperLevel _value, $Res Function(MiddleDeveloperLevel) _then)
      : super(_value, (v) => _then(v as MiddleDeveloperLevel));

  @override
  MiddleDeveloperLevel get _value => super._value as MiddleDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('MIDDLE')
class _$MiddleDeveloperLevel extends MiddleDeveloperLevel {
  const _$MiddleDeveloperLevel() : super._();

  factory _$MiddleDeveloperLevel.fromJson(Map<String, dynamic> json) =>
      _$$MiddleDeveloperLevelFromJson(json);

  @override
  String toString() {
    return 'DeveloperLevel.middle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MiddleDeveloperLevel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() intern,
    required TResult Function() junior,
    required TResult Function() middle,
    required TResult Function() senior,
    required TResult Function() lead,
  }) {
    return middle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
  }) {
    return middle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
    required TResult orElse(),
  }) {
    if (middle != null) {
      return middle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InternDeveloperLevel value) intern,
    required TResult Function(JuniorDeveloperLevel value) junior,
    required TResult Function(MiddleDeveloperLevel value) middle,
    required TResult Function(SeniorDeveloperLevel value) senior,
    required TResult Function(LeadDeveloperLevel value) lead,
  }) {
    return middle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
  }) {
    return middle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
    required TResult orElse(),
  }) {
    if (middle != null) {
      return middle(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$MiddleDeveloperLevelToJson(this)..['type'] = 'MIDDLE';
  }
}

abstract class MiddleDeveloperLevel extends DeveloperLevel {
  const factory MiddleDeveloperLevel() = _$MiddleDeveloperLevel;
  const MiddleDeveloperLevel._() : super._();

  factory MiddleDeveloperLevel.fromJson(Map<String, dynamic> json) =
      _$MiddleDeveloperLevel.fromJson;
}

/// @nodoc
abstract class $SeniorDeveloperLevelCopyWith<$Res> {
  factory $SeniorDeveloperLevelCopyWith(SeniorDeveloperLevel value,
          $Res Function(SeniorDeveloperLevel) then) =
      _$SeniorDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$SeniorDeveloperLevelCopyWithImpl<$Res>
    extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $SeniorDeveloperLevelCopyWith<$Res> {
  _$SeniorDeveloperLevelCopyWithImpl(
      SeniorDeveloperLevel _value, $Res Function(SeniorDeveloperLevel) _then)
      : super(_value, (v) => _then(v as SeniorDeveloperLevel));

  @override
  SeniorDeveloperLevel get _value => super._value as SeniorDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('SENIOR')
class _$SeniorDeveloperLevel extends SeniorDeveloperLevel {
  const _$SeniorDeveloperLevel() : super._();

  factory _$SeniorDeveloperLevel.fromJson(Map<String, dynamic> json) =>
      _$$SeniorDeveloperLevelFromJson(json);

  @override
  String toString() {
    return 'DeveloperLevel.senior()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SeniorDeveloperLevel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() intern,
    required TResult Function() junior,
    required TResult Function() middle,
    required TResult Function() senior,
    required TResult Function() lead,
  }) {
    return senior();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
  }) {
    return senior?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
    required TResult orElse(),
  }) {
    if (senior != null) {
      return senior();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InternDeveloperLevel value) intern,
    required TResult Function(JuniorDeveloperLevel value) junior,
    required TResult Function(MiddleDeveloperLevel value) middle,
    required TResult Function(SeniorDeveloperLevel value) senior,
    required TResult Function(LeadDeveloperLevel value) lead,
  }) {
    return senior(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
  }) {
    return senior?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
    required TResult orElse(),
  }) {
    if (senior != null) {
      return senior(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$SeniorDeveloperLevelToJson(this)..['type'] = 'SENIOR';
  }
}

abstract class SeniorDeveloperLevel extends DeveloperLevel {
  const factory SeniorDeveloperLevel() = _$SeniorDeveloperLevel;
  const SeniorDeveloperLevel._() : super._();

  factory SeniorDeveloperLevel.fromJson(Map<String, dynamic> json) =
      _$SeniorDeveloperLevel.fromJson;
}

/// @nodoc
abstract class $LeadDeveloperLevelCopyWith<$Res> {
  factory $LeadDeveloperLevelCopyWith(
          LeadDeveloperLevel value, $Res Function(LeadDeveloperLevel) then) =
      _$LeadDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$LeadDeveloperLevelCopyWithImpl<$Res>
    extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $LeadDeveloperLevelCopyWith<$Res> {
  _$LeadDeveloperLevelCopyWithImpl(
      LeadDeveloperLevel _value, $Res Function(LeadDeveloperLevel) _then)
      : super(_value, (v) => _then(v as LeadDeveloperLevel));

  @override
  LeadDeveloperLevel get _value => super._value as LeadDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('LEAD')
class _$LeadDeveloperLevel extends LeadDeveloperLevel {
  const _$LeadDeveloperLevel() : super._();

  factory _$LeadDeveloperLevel.fromJson(Map<String, dynamic> json) =>
      _$$LeadDeveloperLevelFromJson(json);

  @override
  String toString() {
    return 'DeveloperLevel.lead()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is LeadDeveloperLevel);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() intern,
    required TResult Function() junior,
    required TResult Function() middle,
    required TResult Function() senior,
    required TResult Function() lead,
  }) {
    return lead();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
  }) {
    return lead?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? intern,
    TResult Function()? junior,
    TResult Function()? middle,
    TResult Function()? senior,
    TResult Function()? lead,
    required TResult orElse(),
  }) {
    if (lead != null) {
      return lead();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(InternDeveloperLevel value) intern,
    required TResult Function(JuniorDeveloperLevel value) junior,
    required TResult Function(MiddleDeveloperLevel value) middle,
    required TResult Function(SeniorDeveloperLevel value) senior,
    required TResult Function(LeadDeveloperLevel value) lead,
  }) {
    return lead(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
  }) {
    return lead?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(InternDeveloperLevel value)? intern,
    TResult Function(JuniorDeveloperLevel value)? junior,
    TResult Function(MiddleDeveloperLevel value)? middle,
    TResult Function(SeniorDeveloperLevel value)? senior,
    TResult Function(LeadDeveloperLevel value)? lead,
    required TResult orElse(),
  }) {
    if (lead != null) {
      return lead(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$LeadDeveloperLevelToJson(this)..['type'] = 'LEAD';
  }
}

abstract class LeadDeveloperLevel extends DeveloperLevel {
  const factory LeadDeveloperLevel() = _$LeadDeveloperLevel;
  const LeadDeveloperLevel._() : super._();

  factory LeadDeveloperLevel.fromJson(Map<String, dynamic> json) =
      _$LeadDeveloperLevel.fromJson;
}

Employment _$EmploymentFromJson(Map<String, dynamic> json) {
  switch (json['type'] as String?) {
    case 'FULL_TIME':
      return FullTimeEmployment.fromJson(json);
    case 'PART_TIME':
      return PartTimeEmployment.fromJson(json);
    case 'ONE_TIME':
      return OneTimeEmployment.fromJson(json);
    case 'CONTRACT':
      return ContractEmployment.fromJson(json);
    case 'OPEN_SOURCE':
      return OpenSourceEmployment.fromJson(json);
    case 'COLLABORATION':
      return CollaborationEmployment.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Employment', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
class _$EmploymentTearOff {
  const _$EmploymentTearOff();

  FullTimeEmployment fullTime() {
    return const FullTimeEmployment();
  }

  PartTimeEmployment partTime() {
    return const PartTimeEmployment();
  }

  OneTimeEmployment oneTime() {
    return const OneTimeEmployment();
  }

  ContractEmployment contract() {
    return const ContractEmployment();
  }

  OpenSourceEmployment openSource() {
    return const OpenSourceEmployment();
  }

  CollaborationEmployment collaboration() {
    return const CollaborationEmployment();
  }

  Employment fromJson(Map<String, Object?> json) {
    return Employment.fromJson(json);
  }
}

/// @nodoc
const $Employment = _$EmploymentTearOff();

/// @nodoc
mixin _$Employment {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fullTime,
    required TResult Function() partTime,
    required TResult Function() oneTime,
    required TResult Function() contract,
    required TResult Function() openSource,
    required TResult Function() collaboration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullTimeEmployment value) fullTime,
    required TResult Function(PartTimeEmployment value) partTime,
    required TResult Function(OneTimeEmployment value) oneTime,
    required TResult Function(ContractEmployment value) contract,
    required TResult Function(OpenSourceEmployment value) openSource,
    required TResult Function(CollaborationEmployment value) collaboration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmploymentCopyWith<$Res> {
  factory $EmploymentCopyWith(
          Employment value, $Res Function(Employment) then) =
      _$EmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$EmploymentCopyWithImpl<$Res> implements $EmploymentCopyWith<$Res> {
  _$EmploymentCopyWithImpl(this._value, this._then);

  final Employment _value;
  // ignore: unused_field
  final $Res Function(Employment) _then;
}

/// @nodoc
abstract class $FullTimeEmploymentCopyWith<$Res> {
  factory $FullTimeEmploymentCopyWith(
          FullTimeEmployment value, $Res Function(FullTimeEmployment) then) =
      _$FullTimeEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$FullTimeEmploymentCopyWithImpl<$Res>
    extends _$EmploymentCopyWithImpl<$Res>
    implements $FullTimeEmploymentCopyWith<$Res> {
  _$FullTimeEmploymentCopyWithImpl(
      FullTimeEmployment _value, $Res Function(FullTimeEmployment) _then)
      : super(_value, (v) => _then(v as FullTimeEmployment));

  @override
  FullTimeEmployment get _value => super._value as FullTimeEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('FULL_TIME')
class _$FullTimeEmployment extends FullTimeEmployment {
  const _$FullTimeEmployment() : super._();

  factory _$FullTimeEmployment.fromJson(Map<String, dynamic> json) =>
      _$$FullTimeEmploymentFromJson(json);

  @override
  String toString() {
    return 'Employment.fullTime()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is FullTimeEmployment);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fullTime,
    required TResult Function() partTime,
    required TResult Function() oneTime,
    required TResult Function() contract,
    required TResult Function() openSource,
    required TResult Function() collaboration,
  }) {
    return fullTime();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
  }) {
    return fullTime?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
    required TResult orElse(),
  }) {
    if (fullTime != null) {
      return fullTime();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullTimeEmployment value) fullTime,
    required TResult Function(PartTimeEmployment value) partTime,
    required TResult Function(OneTimeEmployment value) oneTime,
    required TResult Function(ContractEmployment value) contract,
    required TResult Function(OpenSourceEmployment value) openSource,
    required TResult Function(CollaborationEmployment value) collaboration,
  }) {
    return fullTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
  }) {
    return fullTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
    required TResult orElse(),
  }) {
    if (fullTime != null) {
      return fullTime(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$FullTimeEmploymentToJson(this)..['type'] = 'FULL_TIME';
  }
}

abstract class FullTimeEmployment extends Employment {
  const factory FullTimeEmployment() = _$FullTimeEmployment;
  const FullTimeEmployment._() : super._();

  factory FullTimeEmployment.fromJson(Map<String, dynamic> json) =
      _$FullTimeEmployment.fromJson;
}

/// @nodoc
abstract class $PartTimeEmploymentCopyWith<$Res> {
  factory $PartTimeEmploymentCopyWith(
          PartTimeEmployment value, $Res Function(PartTimeEmployment) then) =
      _$PartTimeEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$PartTimeEmploymentCopyWithImpl<$Res>
    extends _$EmploymentCopyWithImpl<$Res>
    implements $PartTimeEmploymentCopyWith<$Res> {
  _$PartTimeEmploymentCopyWithImpl(
      PartTimeEmployment _value, $Res Function(PartTimeEmployment) _then)
      : super(_value, (v) => _then(v as PartTimeEmployment));

  @override
  PartTimeEmployment get _value => super._value as PartTimeEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('PART_TIME')
class _$PartTimeEmployment extends PartTimeEmployment {
  const _$PartTimeEmployment() : super._();

  factory _$PartTimeEmployment.fromJson(Map<String, dynamic> json) =>
      _$$PartTimeEmploymentFromJson(json);

  @override
  String toString() {
    return 'Employment.partTime()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is PartTimeEmployment);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fullTime,
    required TResult Function() partTime,
    required TResult Function() oneTime,
    required TResult Function() contract,
    required TResult Function() openSource,
    required TResult Function() collaboration,
  }) {
    return partTime();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
  }) {
    return partTime?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
    required TResult orElse(),
  }) {
    if (partTime != null) {
      return partTime();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullTimeEmployment value) fullTime,
    required TResult Function(PartTimeEmployment value) partTime,
    required TResult Function(OneTimeEmployment value) oneTime,
    required TResult Function(ContractEmployment value) contract,
    required TResult Function(OpenSourceEmployment value) openSource,
    required TResult Function(CollaborationEmployment value) collaboration,
  }) {
    return partTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
  }) {
    return partTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
    required TResult orElse(),
  }) {
    if (partTime != null) {
      return partTime(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PartTimeEmploymentToJson(this)..['type'] = 'PART_TIME';
  }
}

abstract class PartTimeEmployment extends Employment {
  const factory PartTimeEmployment() = _$PartTimeEmployment;
  const PartTimeEmployment._() : super._();

  factory PartTimeEmployment.fromJson(Map<String, dynamic> json) =
      _$PartTimeEmployment.fromJson;
}

/// @nodoc
abstract class $OneTimeEmploymentCopyWith<$Res> {
  factory $OneTimeEmploymentCopyWith(
          OneTimeEmployment value, $Res Function(OneTimeEmployment) then) =
      _$OneTimeEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$OneTimeEmploymentCopyWithImpl<$Res>
    extends _$EmploymentCopyWithImpl<$Res>
    implements $OneTimeEmploymentCopyWith<$Res> {
  _$OneTimeEmploymentCopyWithImpl(
      OneTimeEmployment _value, $Res Function(OneTimeEmployment) _then)
      : super(_value, (v) => _then(v as OneTimeEmployment));

  @override
  OneTimeEmployment get _value => super._value as OneTimeEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('ONE_TIME')
class _$OneTimeEmployment extends OneTimeEmployment {
  const _$OneTimeEmployment() : super._();

  factory _$OneTimeEmployment.fromJson(Map<String, dynamic> json) =>
      _$$OneTimeEmploymentFromJson(json);

  @override
  String toString() {
    return 'Employment.oneTime()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OneTimeEmployment);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fullTime,
    required TResult Function() partTime,
    required TResult Function() oneTime,
    required TResult Function() contract,
    required TResult Function() openSource,
    required TResult Function() collaboration,
  }) {
    return oneTime();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
  }) {
    return oneTime?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
    required TResult orElse(),
  }) {
    if (oneTime != null) {
      return oneTime();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullTimeEmployment value) fullTime,
    required TResult Function(PartTimeEmployment value) partTime,
    required TResult Function(OneTimeEmployment value) oneTime,
    required TResult Function(ContractEmployment value) contract,
    required TResult Function(OpenSourceEmployment value) openSource,
    required TResult Function(CollaborationEmployment value) collaboration,
  }) {
    return oneTime(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
  }) {
    return oneTime?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
    required TResult orElse(),
  }) {
    if (oneTime != null) {
      return oneTime(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OneTimeEmploymentToJson(this)..['type'] = 'ONE_TIME';
  }
}

abstract class OneTimeEmployment extends Employment {
  const factory OneTimeEmployment() = _$OneTimeEmployment;
  const OneTimeEmployment._() : super._();

  factory OneTimeEmployment.fromJson(Map<String, dynamic> json) =
      _$OneTimeEmployment.fromJson;
}

/// @nodoc
abstract class $ContractEmploymentCopyWith<$Res> {
  factory $ContractEmploymentCopyWith(
          ContractEmployment value, $Res Function(ContractEmployment) then) =
      _$ContractEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$ContractEmploymentCopyWithImpl<$Res>
    extends _$EmploymentCopyWithImpl<$Res>
    implements $ContractEmploymentCopyWith<$Res> {
  _$ContractEmploymentCopyWithImpl(
      ContractEmployment _value, $Res Function(ContractEmployment) _then)
      : super(_value, (v) => _then(v as ContractEmployment));

  @override
  ContractEmployment get _value => super._value as ContractEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('CONTRACT')
class _$ContractEmployment extends ContractEmployment {
  const _$ContractEmployment() : super._();

  factory _$ContractEmployment.fromJson(Map<String, dynamic> json) =>
      _$$ContractEmploymentFromJson(json);

  @override
  String toString() {
    return 'Employment.contract()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ContractEmployment);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fullTime,
    required TResult Function() partTime,
    required TResult Function() oneTime,
    required TResult Function() contract,
    required TResult Function() openSource,
    required TResult Function() collaboration,
  }) {
    return contract();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
  }) {
    return contract?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
    required TResult orElse(),
  }) {
    if (contract != null) {
      return contract();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullTimeEmployment value) fullTime,
    required TResult Function(PartTimeEmployment value) partTime,
    required TResult Function(OneTimeEmployment value) oneTime,
    required TResult Function(ContractEmployment value) contract,
    required TResult Function(OpenSourceEmployment value) openSource,
    required TResult Function(CollaborationEmployment value) collaboration,
  }) {
    return contract(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
  }) {
    return contract?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
    required TResult orElse(),
  }) {
    if (contract != null) {
      return contract(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ContractEmploymentToJson(this)..['type'] = 'CONTRACT';
  }
}

abstract class ContractEmployment extends Employment {
  const factory ContractEmployment() = _$ContractEmployment;
  const ContractEmployment._() : super._();

  factory ContractEmployment.fromJson(Map<String, dynamic> json) =
      _$ContractEmployment.fromJson;
}

/// @nodoc
abstract class $OpenSourceEmploymentCopyWith<$Res> {
  factory $OpenSourceEmploymentCopyWith(OpenSourceEmployment value,
          $Res Function(OpenSourceEmployment) then) =
      _$OpenSourceEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$OpenSourceEmploymentCopyWithImpl<$Res>
    extends _$EmploymentCopyWithImpl<$Res>
    implements $OpenSourceEmploymentCopyWith<$Res> {
  _$OpenSourceEmploymentCopyWithImpl(
      OpenSourceEmployment _value, $Res Function(OpenSourceEmployment) _then)
      : super(_value, (v) => _then(v as OpenSourceEmployment));

  @override
  OpenSourceEmployment get _value => super._value as OpenSourceEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('OPEN_SOURCE')
class _$OpenSourceEmployment extends OpenSourceEmployment {
  const _$OpenSourceEmployment() : super._();

  factory _$OpenSourceEmployment.fromJson(Map<String, dynamic> json) =>
      _$$OpenSourceEmploymentFromJson(json);

  @override
  String toString() {
    return 'Employment.openSource()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is OpenSourceEmployment);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fullTime,
    required TResult Function() partTime,
    required TResult Function() oneTime,
    required TResult Function() contract,
    required TResult Function() openSource,
    required TResult Function() collaboration,
  }) {
    return openSource();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
  }) {
    return openSource?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
    required TResult orElse(),
  }) {
    if (openSource != null) {
      return openSource();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullTimeEmployment value) fullTime,
    required TResult Function(PartTimeEmployment value) partTime,
    required TResult Function(OneTimeEmployment value) oneTime,
    required TResult Function(ContractEmployment value) contract,
    required TResult Function(OpenSourceEmployment value) openSource,
    required TResult Function(CollaborationEmployment value) collaboration,
  }) {
    return openSource(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
  }) {
    return openSource?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
    required TResult orElse(),
  }) {
    if (openSource != null) {
      return openSource(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OpenSourceEmploymentToJson(this)..['type'] = 'OPEN_SOURCE';
  }
}

abstract class OpenSourceEmployment extends Employment {
  const factory OpenSourceEmployment() = _$OpenSourceEmployment;
  const OpenSourceEmployment._() : super._();

  factory OpenSourceEmployment.fromJson(Map<String, dynamic> json) =
      _$OpenSourceEmployment.fromJson;
}

/// @nodoc
abstract class $CollaborationEmploymentCopyWith<$Res> {
  factory $CollaborationEmploymentCopyWith(CollaborationEmployment value,
          $Res Function(CollaborationEmployment) then) =
      _$CollaborationEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$CollaborationEmploymentCopyWithImpl<$Res>
    extends _$EmploymentCopyWithImpl<$Res>
    implements $CollaborationEmploymentCopyWith<$Res> {
  _$CollaborationEmploymentCopyWithImpl(CollaborationEmployment _value,
      $Res Function(CollaborationEmployment) _then)
      : super(_value, (v) => _then(v as CollaborationEmployment));

  @override
  CollaborationEmployment get _value => super._value as CollaborationEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('COLLABORATION')
class _$CollaborationEmployment extends CollaborationEmployment {
  const _$CollaborationEmployment() : super._();

  factory _$CollaborationEmployment.fromJson(Map<String, dynamic> json) =>
      _$$CollaborationEmploymentFromJson(json);

  @override
  String toString() {
    return 'Employment.collaboration()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is CollaborationEmployment);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() fullTime,
    required TResult Function() partTime,
    required TResult Function() oneTime,
    required TResult Function() contract,
    required TResult Function() openSource,
    required TResult Function() collaboration,
  }) {
    return collaboration();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
  }) {
    return collaboration?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? fullTime,
    TResult Function()? partTime,
    TResult Function()? oneTime,
    TResult Function()? contract,
    TResult Function()? openSource,
    TResult Function()? collaboration,
    required TResult orElse(),
  }) {
    if (collaboration != null) {
      return collaboration();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FullTimeEmployment value) fullTime,
    required TResult Function(PartTimeEmployment value) partTime,
    required TResult Function(OneTimeEmployment value) oneTime,
    required TResult Function(ContractEmployment value) contract,
    required TResult Function(OpenSourceEmployment value) openSource,
    required TResult Function(CollaborationEmployment value) collaboration,
  }) {
    return collaboration(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
  }) {
    return collaboration?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FullTimeEmployment value)? fullTime,
    TResult Function(PartTimeEmployment value)? partTime,
    TResult Function(OneTimeEmployment value)? oneTime,
    TResult Function(ContractEmployment value)? contract,
    TResult Function(OpenSourceEmployment value)? openSource,
    TResult Function(CollaborationEmployment value)? collaboration,
    required TResult orElse(),
  }) {
    if (collaboration != null) {
      return collaboration(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$CollaborationEmploymentToJson(this)..['type'] = 'COLLABORATION';
  }
}

abstract class CollaborationEmployment extends Employment {
  const factory CollaborationEmployment() = _$CollaborationEmployment;
  const CollaborationEmployment._() : super._();

  factory CollaborationEmployment.fromJson(Map<String, dynamic> json) =
      _$CollaborationEmployment.fromJson;
}

Skill _$SkillFromJson(Map<String, dynamic> json) {
  return OtherSkill.fromJson(json);
}

/// @nodoc
class _$SkillTearOff {
  const _$SkillTearOff();

  OtherSkill other(String value) {
    return OtherSkill(
      value,
    );
  }

  Skill fromJson(Map<String, Object?> json) {
    return Skill.fromJson(json);
  }
}

/// @nodoc
const $Skill = _$SkillTearOff();

/// @nodoc
mixin _$Skill {
  String get value => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtherSkill value) other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtherSkill value)? other,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtherSkill value)? other,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SkillCopyWith<Skill> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SkillCopyWith<$Res> {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) then) =
      _$SkillCopyWithImpl<$Res>;
  $Res call({String value});
}

/// @nodoc
class _$SkillCopyWithImpl<$Res> implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._value, this._then);

  final Skill _value;
  // ignore: unused_field
  final $Res Function(Skill) _then;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $OtherSkillCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory $OtherSkillCopyWith(
          OtherSkill value, $Res Function(OtherSkill) then) =
      _$OtherSkillCopyWithImpl<$Res>;
  @override
  $Res call({String value});
}

/// @nodoc
class _$OtherSkillCopyWithImpl<$Res> extends _$SkillCopyWithImpl<$Res>
    implements $OtherSkillCopyWith<$Res> {
  _$OtherSkillCopyWithImpl(OtherSkill _value, $Res Function(OtherSkill) _then)
      : super(_value, (v) => _then(v as OtherSkill));

  @override
  OtherSkill get _value => super._value as OtherSkill;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(OtherSkill(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('other')
class _$OtherSkill extends OtherSkill {
  const _$OtherSkill(this.value) : super._();

  factory _$OtherSkill.fromJson(Map<String, dynamic> json) =>
      _$$OtherSkillFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'Skill.other(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtherSkill &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  $OtherSkillCopyWith<OtherSkill> get copyWith =>
      _$OtherSkillCopyWithImpl<OtherSkill>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) other,
  }) {
    return other(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? other,
  }) {
    return other?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtherSkill value) other,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtherSkill value)? other,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtherSkill value)? other,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherSkillToJson(this);
  }
}

abstract class OtherSkill extends Skill {
  const factory OtherSkill(String value) = _$OtherSkill;
  const OtherSkill._() : super._();

  factory OtherSkill.fromJson(Map<String, dynamic> json) =
      _$OtherSkill.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  $OtherSkillCopyWith<OtherSkill> get copyWith =>
      throw _privateConstructorUsedError;
}

Contact _$ContactFromJson(Map<String, dynamic> json) {
  switch (json['type'] as String?) {
    case 'OTHER':
      return OtherContact.fromJson(json);
    case 'PHONE':
      return PhoneContact.fromJson(json);
    case 'WEBSITE':
      return WebsiteContact.fromJson(json);
    case 'EMAIL':
      return EmailContact.fromJson(json);
    case 'Telegram':
      return TelegramContact.fromJson(json);

    default:
      throw CheckedFromJsonException(
          json, 'type', 'Contact', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
class _$ContactTearOff {
  const _$ContactTearOff();

  OtherContact other(String value) {
    return OtherContact(
      value,
    );
  }

  PhoneContact phone(String value) {
    return PhoneContact(
      value,
    );
  }

  WebsiteContact website(String value) {
    return WebsiteContact(
      value,
    );
  }

  EmailContact email(String value) {
    return EmailContact(
      value,
    );
  }

  TelegramContact telegram(String value) {
    return TelegramContact(
      value,
    );
  }

  Contact fromJson(Map<String, Object?> json) {
    return Contact.fromJson(json);
  }
}

/// @nodoc
const $Contact = _$ContactTearOff();

/// @nodoc
mixin _$Contact {
  String get value => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) other,
    required TResult Function(String value) phone,
    required TResult Function(String value) website,
    required TResult Function(String value) email,
    required TResult Function(String value) telegram,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtherContact value) other,
    required TResult Function(PhoneContact value) phone,
    required TResult Function(WebsiteContact value) website,
    required TResult Function(EmailContact value) email,
    required TResult Function(TelegramContact value) telegram,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ContactCopyWith<Contact> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactCopyWith<$Res> {
  factory $ContactCopyWith(Contact value, $Res Function(Contact) then) =
      _$ContactCopyWithImpl<$Res>;
  $Res call({String value});
}

/// @nodoc
class _$ContactCopyWithImpl<$Res> implements $ContactCopyWith<$Res> {
  _$ContactCopyWithImpl(this._value, this._then);

  final Contact _value;
  // ignore: unused_field
  final $Res Function(Contact) _then;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class $OtherContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory $OtherContactCopyWith(
          OtherContact value, $Res Function(OtherContact) then) =
      _$OtherContactCopyWithImpl<$Res>;
  @override
  $Res call({String value});
}

/// @nodoc
class _$OtherContactCopyWithImpl<$Res> extends _$ContactCopyWithImpl<$Res>
    implements $OtherContactCopyWith<$Res> {
  _$OtherContactCopyWithImpl(
      OtherContact _value, $Res Function(OtherContact) _then)
      : super(_value, (v) => _then(v as OtherContact));

  @override
  OtherContact get _value => super._value as OtherContact;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(OtherContact(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('OTHER')
class _$OtherContact extends OtherContact {
  const _$OtherContact(this.value) : super._();

  factory _$OtherContact.fromJson(Map<String, dynamic> json) =>
      _$$OtherContactFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'Contact.other(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OtherContact &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  $OtherContactCopyWith<OtherContact> get copyWith =>
      _$OtherContactCopyWithImpl<OtherContact>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) other,
    required TResult Function(String value) phone,
    required TResult Function(String value) website,
    required TResult Function(String value) email,
    required TResult Function(String value) telegram,
  }) {
    return other(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
  }) {
    return other?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtherContact value) other,
    required TResult Function(PhoneContact value) phone,
    required TResult Function(WebsiteContact value) website,
    required TResult Function(EmailContact value) email,
    required TResult Function(TelegramContact value) telegram,
  }) {
    return other(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
  }) {
    return other?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
    required TResult orElse(),
  }) {
    if (other != null) {
      return other(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$OtherContactToJson(this)..['type'] = 'OTHER';
  }
}

abstract class OtherContact extends Contact {
  const factory OtherContact(String value) = _$OtherContact;
  const OtherContact._() : super._();

  factory OtherContact.fromJson(Map<String, dynamic> json) =
      _$OtherContact.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  $OtherContactCopyWith<OtherContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhoneContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory $PhoneContactCopyWith(
          PhoneContact value, $Res Function(PhoneContact) then) =
      _$PhoneContactCopyWithImpl<$Res>;
  @override
  $Res call({String value});
}

/// @nodoc
class _$PhoneContactCopyWithImpl<$Res> extends _$ContactCopyWithImpl<$Res>
    implements $PhoneContactCopyWith<$Res> {
  _$PhoneContactCopyWithImpl(
      PhoneContact _value, $Res Function(PhoneContact) _then)
      : super(_value, (v) => _then(v as PhoneContact));

  @override
  PhoneContact get _value => super._value as PhoneContact;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(PhoneContact(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('PHONE')
class _$PhoneContact extends PhoneContact {
  const _$PhoneContact(this.value) : super._();

  factory _$PhoneContact.fromJson(Map<String, dynamic> json) =>
      _$$PhoneContactFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'Contact.phone(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PhoneContact &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  $PhoneContactCopyWith<PhoneContact> get copyWith =>
      _$PhoneContactCopyWithImpl<PhoneContact>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) other,
    required TResult Function(String value) phone,
    required TResult Function(String value) website,
    required TResult Function(String value) email,
    required TResult Function(String value) telegram,
  }) {
    return phone(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
  }) {
    return phone?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
    required TResult orElse(),
  }) {
    if (phone != null) {
      return phone(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtherContact value) other,
    required TResult Function(PhoneContact value) phone,
    required TResult Function(WebsiteContact value) website,
    required TResult Function(EmailContact value) email,
    required TResult Function(TelegramContact value) telegram,
  }) {
    return phone(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
  }) {
    return phone?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
    required TResult orElse(),
  }) {
    if (phone != null) {
      return phone(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PhoneContactToJson(this)..['type'] = 'PHONE';
  }
}

abstract class PhoneContact extends Contact {
  const factory PhoneContact(String value) = _$PhoneContact;
  const PhoneContact._() : super._();

  factory PhoneContact.fromJson(Map<String, dynamic> json) =
      _$PhoneContact.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  $PhoneContactCopyWith<PhoneContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebsiteContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory $WebsiteContactCopyWith(
          WebsiteContact value, $Res Function(WebsiteContact) then) =
      _$WebsiteContactCopyWithImpl<$Res>;
  @override
  $Res call({String value});
}

/// @nodoc
class _$WebsiteContactCopyWithImpl<$Res> extends _$ContactCopyWithImpl<$Res>
    implements $WebsiteContactCopyWith<$Res> {
  _$WebsiteContactCopyWithImpl(
      WebsiteContact _value, $Res Function(WebsiteContact) _then)
      : super(_value, (v) => _then(v as WebsiteContact));

  @override
  WebsiteContact get _value => super._value as WebsiteContact;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(WebsiteContact(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('WEBSITE')
class _$WebsiteContact extends WebsiteContact {
  const _$WebsiteContact(this.value) : super._();

  factory _$WebsiteContact.fromJson(Map<String, dynamic> json) =>
      _$$WebsiteContactFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'Contact.website(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is WebsiteContact &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  $WebsiteContactCopyWith<WebsiteContact> get copyWith =>
      _$WebsiteContactCopyWithImpl<WebsiteContact>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) other,
    required TResult Function(String value) phone,
    required TResult Function(String value) website,
    required TResult Function(String value) email,
    required TResult Function(String value) telegram,
  }) {
    return website(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
  }) {
    return website?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
    required TResult orElse(),
  }) {
    if (website != null) {
      return website(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtherContact value) other,
    required TResult Function(PhoneContact value) phone,
    required TResult Function(WebsiteContact value) website,
    required TResult Function(EmailContact value) email,
    required TResult Function(TelegramContact value) telegram,
  }) {
    return website(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
  }) {
    return website?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
    required TResult orElse(),
  }) {
    if (website != null) {
      return website(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$WebsiteContactToJson(this)..['type'] = 'WEBSITE';
  }
}

abstract class WebsiteContact extends Contact {
  const factory WebsiteContact(String value) = _$WebsiteContact;
  const WebsiteContact._() : super._();

  factory WebsiteContact.fromJson(Map<String, dynamic> json) =
      _$WebsiteContact.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  $WebsiteContactCopyWith<WebsiteContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EmailContactCopyWith<$Res> implements $ContactCopyWith<$Res> {
  factory $EmailContactCopyWith(
          EmailContact value, $Res Function(EmailContact) then) =
      _$EmailContactCopyWithImpl<$Res>;
  @override
  $Res call({String value});
}

/// @nodoc
class _$EmailContactCopyWithImpl<$Res> extends _$ContactCopyWithImpl<$Res>
    implements $EmailContactCopyWith<$Res> {
  _$EmailContactCopyWithImpl(
      EmailContact _value, $Res Function(EmailContact) _then)
      : super(_value, (v) => _then(v as EmailContact));

  @override
  EmailContact get _value => super._value as EmailContact;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(EmailContact(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('EMAIL')
class _$EmailContact extends EmailContact {
  const _$EmailContact(this.value) : super._();

  factory _$EmailContact.fromJson(Map<String, dynamic> json) =>
      _$$EmailContactFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'Contact.email(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is EmailContact &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  $EmailContactCopyWith<EmailContact> get copyWith =>
      _$EmailContactCopyWithImpl<EmailContact>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) other,
    required TResult Function(String value) phone,
    required TResult Function(String value) website,
    required TResult Function(String value) email,
    required TResult Function(String value) telegram,
  }) {
    return email(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
  }) {
    return email?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
    required TResult orElse(),
  }) {
    if (email != null) {
      return email(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtherContact value) other,
    required TResult Function(PhoneContact value) phone,
    required TResult Function(WebsiteContact value) website,
    required TResult Function(EmailContact value) email,
    required TResult Function(TelegramContact value) telegram,
  }) {
    return email(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
  }) {
    return email?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
    required TResult orElse(),
  }) {
    if (email != null) {
      return email(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$EmailContactToJson(this)..['type'] = 'EMAIL';
  }
}

abstract class EmailContact extends Contact {
  const factory EmailContact(String value) = _$EmailContact;
  const EmailContact._() : super._();

  factory EmailContact.fromJson(Map<String, dynamic> json) =
      _$EmailContact.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  $EmailContactCopyWith<EmailContact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TelegramContactCopyWith<$Res>
    implements $ContactCopyWith<$Res> {
  factory $TelegramContactCopyWith(
          TelegramContact value, $Res Function(TelegramContact) then) =
      _$TelegramContactCopyWithImpl<$Res>;
  @override
  $Res call({String value});
}

/// @nodoc
class _$TelegramContactCopyWithImpl<$Res> extends _$ContactCopyWithImpl<$Res>
    implements $TelegramContactCopyWith<$Res> {
  _$TelegramContactCopyWithImpl(
      TelegramContact _value, $Res Function(TelegramContact) _then)
      : super(_value, (v) => _then(v as TelegramContact));

  @override
  TelegramContact get _value => super._value as TelegramContact;

  @override
  $Res call({
    Object? value = freezed,
  }) {
    return _then(TelegramContact(
      value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('Telegram')
class _$TelegramContact extends TelegramContact {
  const _$TelegramContact(this.value) : super._();

  factory _$TelegramContact.fromJson(Map<String, dynamic> json) =>
      _$$TelegramContactFromJson(json);

  @override
  final String value;

  @override
  String toString() {
    return 'Contact.telegram(value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TelegramContact &&
            (identical(other.value, value) || other.value == value));
  }

  @override
  int get hashCode => Object.hash(runtimeType, value);

  @JsonKey(ignore: true)
  @override
  $TelegramContactCopyWith<TelegramContact> get copyWith =>
      _$TelegramContactCopyWithImpl<TelegramContact>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String value) other,
    required TResult Function(String value) phone,
    required TResult Function(String value) website,
    required TResult Function(String value) email,
    required TResult Function(String value) telegram,
  }) {
    return telegram(value);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
  }) {
    return telegram?.call(value);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String value)? other,
    TResult Function(String value)? phone,
    TResult Function(String value)? website,
    TResult Function(String value)? email,
    TResult Function(String value)? telegram,
    required TResult orElse(),
  }) {
    if (telegram != null) {
      return telegram(value);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OtherContact value) other,
    required TResult Function(PhoneContact value) phone,
    required TResult Function(WebsiteContact value) website,
    required TResult Function(EmailContact value) email,
    required TResult Function(TelegramContact value) telegram,
  }) {
    return telegram(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
  }) {
    return telegram?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OtherContact value)? other,
    TResult Function(PhoneContact value)? phone,
    TResult Function(WebsiteContact value)? website,
    TResult Function(EmailContact value)? email,
    TResult Function(TelegramContact value)? telegram,
    required TResult orElse(),
  }) {
    if (telegram != null) {
      return telegram(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TelegramContactToJson(this)..['type'] = 'Telegram';
  }
}

abstract class TelegramContact extends Contact {
  const factory TelegramContact(String value) = _$TelegramContact;
  const TelegramContact._() : super._();

  factory TelegramContact.fromJson(Map<String, dynamic> json) =
      _$TelegramContact.fromJson;

  @override
  String get value;
  @override
  @JsonKey(ignore: true)
  $TelegramContactCopyWith<TelegramContact> get copyWith =>
      throw _privateConstructorUsedError;
}
