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
  switch (json['type']) {
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
      throw CheckedFromJsonException(json, 'type', 'DeveloperLevel', 'Invalid union type "${json['type']}"!');
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
  factory $DeveloperLevelCopyWith(DeveloperLevel value, $Res Function(DeveloperLevel) then) =
      _$DeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$DeveloperLevelCopyWithImpl<$Res> implements $DeveloperLevelCopyWith<$Res> {
  _$DeveloperLevelCopyWithImpl(this._value, this._then);

  final DeveloperLevel _value;
  // ignore: unused_field
  final $Res Function(DeveloperLevel) _then;
}

/// @nodoc
abstract class $InternDeveloperLevelCopyWith<$Res> {
  factory $InternDeveloperLevelCopyWith(InternDeveloperLevel value, $Res Function(InternDeveloperLevel) then) =
      _$InternDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$InternDeveloperLevelCopyWithImpl<$Res> extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $InternDeveloperLevelCopyWith<$Res> {
  _$InternDeveloperLevelCopyWithImpl(InternDeveloperLevel _value, $Res Function(InternDeveloperLevel) _then)
      : super(_value, (v) => _then(v as InternDeveloperLevel));

  @override
  InternDeveloperLevel get _value => super._value as InternDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('INTERN')
class _$InternDeveloperLevel extends InternDeveloperLevel {
  const _$InternDeveloperLevel({String? $type})
      : $type = $type ?? 'INTERN',
        super._();

  factory _$InternDeveloperLevel.fromJson(Map<String, dynamic> json) => _$$InternDeveloperLevelFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeveloperLevel.intern()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is InternDeveloperLevel);
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
    return _$$InternDeveloperLevelToJson(this);
  }
}

abstract class InternDeveloperLevel extends DeveloperLevel {
  const factory InternDeveloperLevel() = _$InternDeveloperLevel;
  const InternDeveloperLevel._() : super._();

  factory InternDeveloperLevel.fromJson(Map<String, dynamic> json) = _$InternDeveloperLevel.fromJson;
}

/// @nodoc
abstract class $JuniorDeveloperLevelCopyWith<$Res> {
  factory $JuniorDeveloperLevelCopyWith(JuniorDeveloperLevel value, $Res Function(JuniorDeveloperLevel) then) =
      _$JuniorDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$JuniorDeveloperLevelCopyWithImpl<$Res> extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $JuniorDeveloperLevelCopyWith<$Res> {
  _$JuniorDeveloperLevelCopyWithImpl(JuniorDeveloperLevel _value, $Res Function(JuniorDeveloperLevel) _then)
      : super(_value, (v) => _then(v as JuniorDeveloperLevel));

  @override
  JuniorDeveloperLevel get _value => super._value as JuniorDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('JUNIOR')
class _$JuniorDeveloperLevel extends JuniorDeveloperLevel {
  const _$JuniorDeveloperLevel({String? $type})
      : $type = $type ?? 'JUNIOR',
        super._();

  factory _$JuniorDeveloperLevel.fromJson(Map<String, dynamic> json) => _$$JuniorDeveloperLevelFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeveloperLevel.junior()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is JuniorDeveloperLevel);
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
    return _$$JuniorDeveloperLevelToJson(this);
  }
}

abstract class JuniorDeveloperLevel extends DeveloperLevel {
  const factory JuniorDeveloperLevel() = _$JuniorDeveloperLevel;
  const JuniorDeveloperLevel._() : super._();

  factory JuniorDeveloperLevel.fromJson(Map<String, dynamic> json) = _$JuniorDeveloperLevel.fromJson;
}

/// @nodoc
abstract class $MiddleDeveloperLevelCopyWith<$Res> {
  factory $MiddleDeveloperLevelCopyWith(MiddleDeveloperLevel value, $Res Function(MiddleDeveloperLevel) then) =
      _$MiddleDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$MiddleDeveloperLevelCopyWithImpl<$Res> extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $MiddleDeveloperLevelCopyWith<$Res> {
  _$MiddleDeveloperLevelCopyWithImpl(MiddleDeveloperLevel _value, $Res Function(MiddleDeveloperLevel) _then)
      : super(_value, (v) => _then(v as MiddleDeveloperLevel));

  @override
  MiddleDeveloperLevel get _value => super._value as MiddleDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('MIDDLE')
class _$MiddleDeveloperLevel extends MiddleDeveloperLevel {
  const _$MiddleDeveloperLevel({String? $type})
      : $type = $type ?? 'MIDDLE',
        super._();

  factory _$MiddleDeveloperLevel.fromJson(Map<String, dynamic> json) => _$$MiddleDeveloperLevelFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeveloperLevel.middle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is MiddleDeveloperLevel);
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
    return _$$MiddleDeveloperLevelToJson(this);
  }
}

abstract class MiddleDeveloperLevel extends DeveloperLevel {
  const factory MiddleDeveloperLevel() = _$MiddleDeveloperLevel;
  const MiddleDeveloperLevel._() : super._();

  factory MiddleDeveloperLevel.fromJson(Map<String, dynamic> json) = _$MiddleDeveloperLevel.fromJson;
}

/// @nodoc
abstract class $SeniorDeveloperLevelCopyWith<$Res> {
  factory $SeniorDeveloperLevelCopyWith(SeniorDeveloperLevel value, $Res Function(SeniorDeveloperLevel) then) =
      _$SeniorDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$SeniorDeveloperLevelCopyWithImpl<$Res> extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $SeniorDeveloperLevelCopyWith<$Res> {
  _$SeniorDeveloperLevelCopyWithImpl(SeniorDeveloperLevel _value, $Res Function(SeniorDeveloperLevel) _then)
      : super(_value, (v) => _then(v as SeniorDeveloperLevel));

  @override
  SeniorDeveloperLevel get _value => super._value as SeniorDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('SENIOR')
class _$SeniorDeveloperLevel extends SeniorDeveloperLevel {
  const _$SeniorDeveloperLevel({String? $type})
      : $type = $type ?? 'SENIOR',
        super._();

  factory _$SeniorDeveloperLevel.fromJson(Map<String, dynamic> json) => _$$SeniorDeveloperLevelFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeveloperLevel.senior()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is SeniorDeveloperLevel);
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
    return _$$SeniorDeveloperLevelToJson(this);
  }
}

abstract class SeniorDeveloperLevel extends DeveloperLevel {
  const factory SeniorDeveloperLevel() = _$SeniorDeveloperLevel;
  const SeniorDeveloperLevel._() : super._();

  factory SeniorDeveloperLevel.fromJson(Map<String, dynamic> json) = _$SeniorDeveloperLevel.fromJson;
}

/// @nodoc
abstract class $LeadDeveloperLevelCopyWith<$Res> {
  factory $LeadDeveloperLevelCopyWith(LeadDeveloperLevel value, $Res Function(LeadDeveloperLevel) then) =
      _$LeadDeveloperLevelCopyWithImpl<$Res>;
}

/// @nodoc
class _$LeadDeveloperLevelCopyWithImpl<$Res> extends _$DeveloperLevelCopyWithImpl<$Res>
    implements $LeadDeveloperLevelCopyWith<$Res> {
  _$LeadDeveloperLevelCopyWithImpl(LeadDeveloperLevel _value, $Res Function(LeadDeveloperLevel) _then)
      : super(_value, (v) => _then(v as LeadDeveloperLevel));

  @override
  LeadDeveloperLevel get _value => super._value as LeadDeveloperLevel;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('LEAD')
class _$LeadDeveloperLevel extends LeadDeveloperLevel {
  const _$LeadDeveloperLevel({String? $type})
      : $type = $type ?? 'LEAD',
        super._();

  factory _$LeadDeveloperLevel.fromJson(Map<String, dynamic> json) => _$$LeadDeveloperLevelFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'DeveloperLevel.lead()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is LeadDeveloperLevel);
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
    return _$$LeadDeveloperLevelToJson(this);
  }
}

abstract class LeadDeveloperLevel extends DeveloperLevel {
  const factory LeadDeveloperLevel() = _$LeadDeveloperLevel;
  const LeadDeveloperLevel._() : super._();

  factory LeadDeveloperLevel.fromJson(Map<String, dynamic> json) = _$LeadDeveloperLevel.fromJson;
}

Employment _$EmploymentFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
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
      throw CheckedFromJsonException(json, 'type', 'Employment', 'Invalid union type "${json['type']}"!');
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
  factory $EmploymentCopyWith(Employment value, $Res Function(Employment) then) = _$EmploymentCopyWithImpl<$Res>;
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
  factory $FullTimeEmploymentCopyWith(FullTimeEmployment value, $Res Function(FullTimeEmployment) then) =
      _$FullTimeEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$FullTimeEmploymentCopyWithImpl<$Res> extends _$EmploymentCopyWithImpl<$Res>
    implements $FullTimeEmploymentCopyWith<$Res> {
  _$FullTimeEmploymentCopyWithImpl(FullTimeEmployment _value, $Res Function(FullTimeEmployment) _then)
      : super(_value, (v) => _then(v as FullTimeEmployment));

  @override
  FullTimeEmployment get _value => super._value as FullTimeEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('FULL_TIME')
class _$FullTimeEmployment extends FullTimeEmployment {
  const _$FullTimeEmployment({String? $type})
      : $type = $type ?? 'FULL_TIME',
        super._();

  factory _$FullTimeEmployment.fromJson(Map<String, dynamic> json) => _$$FullTimeEmploymentFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Employment.fullTime()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is FullTimeEmployment);
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
    return _$$FullTimeEmploymentToJson(this);
  }
}

abstract class FullTimeEmployment extends Employment {
  const factory FullTimeEmployment() = _$FullTimeEmployment;
  const FullTimeEmployment._() : super._();

  factory FullTimeEmployment.fromJson(Map<String, dynamic> json) = _$FullTimeEmployment.fromJson;
}

/// @nodoc
abstract class $PartTimeEmploymentCopyWith<$Res> {
  factory $PartTimeEmploymentCopyWith(PartTimeEmployment value, $Res Function(PartTimeEmployment) then) =
      _$PartTimeEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$PartTimeEmploymentCopyWithImpl<$Res> extends _$EmploymentCopyWithImpl<$Res>
    implements $PartTimeEmploymentCopyWith<$Res> {
  _$PartTimeEmploymentCopyWithImpl(PartTimeEmployment _value, $Res Function(PartTimeEmployment) _then)
      : super(_value, (v) => _then(v as PartTimeEmployment));

  @override
  PartTimeEmployment get _value => super._value as PartTimeEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('PART_TIME')
class _$PartTimeEmployment extends PartTimeEmployment {
  const _$PartTimeEmployment({String? $type})
      : $type = $type ?? 'PART_TIME',
        super._();

  factory _$PartTimeEmployment.fromJson(Map<String, dynamic> json) => _$$PartTimeEmploymentFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Employment.partTime()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is PartTimeEmployment);
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
    return _$$PartTimeEmploymentToJson(this);
  }
}

abstract class PartTimeEmployment extends Employment {
  const factory PartTimeEmployment() = _$PartTimeEmployment;
  const PartTimeEmployment._() : super._();

  factory PartTimeEmployment.fromJson(Map<String, dynamic> json) = _$PartTimeEmployment.fromJson;
}

/// @nodoc
abstract class $OneTimeEmploymentCopyWith<$Res> {
  factory $OneTimeEmploymentCopyWith(OneTimeEmployment value, $Res Function(OneTimeEmployment) then) =
      _$OneTimeEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$OneTimeEmploymentCopyWithImpl<$Res> extends _$EmploymentCopyWithImpl<$Res>
    implements $OneTimeEmploymentCopyWith<$Res> {
  _$OneTimeEmploymentCopyWithImpl(OneTimeEmployment _value, $Res Function(OneTimeEmployment) _then)
      : super(_value, (v) => _then(v as OneTimeEmployment));

  @override
  OneTimeEmployment get _value => super._value as OneTimeEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('ONE_TIME')
class _$OneTimeEmployment extends OneTimeEmployment {
  const _$OneTimeEmployment({String? $type})
      : $type = $type ?? 'ONE_TIME',
        super._();

  factory _$OneTimeEmployment.fromJson(Map<String, dynamic> json) => _$$OneTimeEmploymentFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Employment.oneTime()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is OneTimeEmployment);
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
    return _$$OneTimeEmploymentToJson(this);
  }
}

abstract class OneTimeEmployment extends Employment {
  const factory OneTimeEmployment() = _$OneTimeEmployment;
  const OneTimeEmployment._() : super._();

  factory OneTimeEmployment.fromJson(Map<String, dynamic> json) = _$OneTimeEmployment.fromJson;
}

/// @nodoc
abstract class $ContractEmploymentCopyWith<$Res> {
  factory $ContractEmploymentCopyWith(ContractEmployment value, $Res Function(ContractEmployment) then) =
      _$ContractEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$ContractEmploymentCopyWithImpl<$Res> extends _$EmploymentCopyWithImpl<$Res>
    implements $ContractEmploymentCopyWith<$Res> {
  _$ContractEmploymentCopyWithImpl(ContractEmployment _value, $Res Function(ContractEmployment) _then)
      : super(_value, (v) => _then(v as ContractEmployment));

  @override
  ContractEmployment get _value => super._value as ContractEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('CONTRACT')
class _$ContractEmployment extends ContractEmployment {
  const _$ContractEmployment({String? $type})
      : $type = $type ?? 'CONTRACT',
        super._();

  factory _$ContractEmployment.fromJson(Map<String, dynamic> json) => _$$ContractEmploymentFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Employment.contract()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is ContractEmployment);
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
    return _$$ContractEmploymentToJson(this);
  }
}

abstract class ContractEmployment extends Employment {
  const factory ContractEmployment() = _$ContractEmployment;
  const ContractEmployment._() : super._();

  factory ContractEmployment.fromJson(Map<String, dynamic> json) = _$ContractEmployment.fromJson;
}

/// @nodoc
abstract class $OpenSourceEmploymentCopyWith<$Res> {
  factory $OpenSourceEmploymentCopyWith(OpenSourceEmployment value, $Res Function(OpenSourceEmployment) then) =
      _$OpenSourceEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$OpenSourceEmploymentCopyWithImpl<$Res> extends _$EmploymentCopyWithImpl<$Res>
    implements $OpenSourceEmploymentCopyWith<$Res> {
  _$OpenSourceEmploymentCopyWithImpl(OpenSourceEmployment _value, $Res Function(OpenSourceEmployment) _then)
      : super(_value, (v) => _then(v as OpenSourceEmployment));

  @override
  OpenSourceEmployment get _value => super._value as OpenSourceEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('OPEN_SOURCE')
class _$OpenSourceEmployment extends OpenSourceEmployment {
  const _$OpenSourceEmployment({String? $type})
      : $type = $type ?? 'OPEN_SOURCE',
        super._();

  factory _$OpenSourceEmployment.fromJson(Map<String, dynamic> json) => _$$OpenSourceEmploymentFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Employment.openSource()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is OpenSourceEmployment);
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
    return _$$OpenSourceEmploymentToJson(this);
  }
}

abstract class OpenSourceEmployment extends Employment {
  const factory OpenSourceEmployment() = _$OpenSourceEmployment;
  const OpenSourceEmployment._() : super._();

  factory OpenSourceEmployment.fromJson(Map<String, dynamic> json) = _$OpenSourceEmployment.fromJson;
}

/// @nodoc
abstract class $CollaborationEmploymentCopyWith<$Res> {
  factory $CollaborationEmploymentCopyWith(CollaborationEmployment value, $Res Function(CollaborationEmployment) then) =
      _$CollaborationEmploymentCopyWithImpl<$Res>;
}

/// @nodoc
class _$CollaborationEmploymentCopyWithImpl<$Res> extends _$EmploymentCopyWithImpl<$Res>
    implements $CollaborationEmploymentCopyWith<$Res> {
  _$CollaborationEmploymentCopyWithImpl(CollaborationEmployment _value, $Res Function(CollaborationEmployment) _then)
      : super(_value, (v) => _then(v as CollaborationEmployment));

  @override
  CollaborationEmployment get _value => super._value as CollaborationEmployment;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('COLLABORATION')
class _$CollaborationEmployment extends CollaborationEmployment {
  const _$CollaborationEmployment({String? $type})
      : $type = $type ?? 'COLLABORATION',
        super._();

  factory _$CollaborationEmployment.fromJson(Map<String, dynamic> json) => _$$CollaborationEmploymentFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Employment.collaboration()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is CollaborationEmployment);
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
    return _$$CollaborationEmploymentToJson(this);
  }
}

abstract class CollaborationEmployment extends Employment {
  const factory CollaborationEmployment() = _$CollaborationEmployment;
  const CollaborationEmployment._() : super._();

  factory CollaborationEmployment.fromJson(Map<String, dynamic> json) = _$CollaborationEmployment.fromJson;
}

Relocation _$RelocationFromJson(Map<String, dynamic> json) {
  switch (json['type']) {
    case 'IMPOSSIBLE':
      return ImpossibleRelocation.fromJson(json);
    case 'POSSIBLE':
      return PossibleRelocation.fromJson(json);
    case 'REQUIRED':
      return RequiredRelocation.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'type', 'Relocation', 'Invalid union type "${json['type']}"!');
  }
}

/// @nodoc
class _$RelocationTearOff {
  const _$RelocationTearOff();

  ImpossibleRelocation impossible() {
    return const ImpossibleRelocation();
  }

  PossibleRelocation possible() {
    return const PossibleRelocation();
  }

  RequiredRelocation required() {
    return const RequiredRelocation();
  }

  Relocation fromJson(Map<String, Object?> json) {
    return Relocation.fromJson(json);
  }
}

/// @nodoc
const $Relocation = _$RelocationTearOff();

/// @nodoc
mixin _$Relocation {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() impossible,
    required TResult Function() possible,
    required TResult Function() required,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? impossible,
    TResult Function()? possible,
    TResult Function()? required,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? impossible,
    TResult Function()? possible,
    TResult Function()? required,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImpossibleRelocation value) impossible,
    required TResult Function(PossibleRelocation value) possible,
    required TResult Function(RequiredRelocation value) required,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ImpossibleRelocation value)? impossible,
    TResult Function(PossibleRelocation value)? possible,
    TResult Function(RequiredRelocation value)? required,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImpossibleRelocation value)? impossible,
    TResult Function(PossibleRelocation value)? possible,
    TResult Function(RequiredRelocation value)? required,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RelocationCopyWith<$Res> {
  factory $RelocationCopyWith(Relocation value, $Res Function(Relocation) then) = _$RelocationCopyWithImpl<$Res>;
}

/// @nodoc
class _$RelocationCopyWithImpl<$Res> implements $RelocationCopyWith<$Res> {
  _$RelocationCopyWithImpl(this._value, this._then);

  final Relocation _value;
  // ignore: unused_field
  final $Res Function(Relocation) _then;
}

/// @nodoc
abstract class $ImpossibleRelocationCopyWith<$Res> {
  factory $ImpossibleRelocationCopyWith(ImpossibleRelocation value, $Res Function(ImpossibleRelocation) then) =
      _$ImpossibleRelocationCopyWithImpl<$Res>;
}

/// @nodoc
class _$ImpossibleRelocationCopyWithImpl<$Res> extends _$RelocationCopyWithImpl<$Res>
    implements $ImpossibleRelocationCopyWith<$Res> {
  _$ImpossibleRelocationCopyWithImpl(ImpossibleRelocation _value, $Res Function(ImpossibleRelocation) _then)
      : super(_value, (v) => _then(v as ImpossibleRelocation));

  @override
  ImpossibleRelocation get _value => super._value as ImpossibleRelocation;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('IMPOSSIBLE')
class _$ImpossibleRelocation extends ImpossibleRelocation {
  const _$ImpossibleRelocation({String? $type})
      : $type = $type ?? 'IMPOSSIBLE',
        super._();

  factory _$ImpossibleRelocation.fromJson(Map<String, dynamic> json) => _$$ImpossibleRelocationFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Relocation.impossible()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is ImpossibleRelocation);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() impossible,
    required TResult Function() possible,
    required TResult Function() required,
  }) {
    return impossible();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? impossible,
    TResult Function()? possible,
    TResult Function()? required,
  }) {
    return impossible?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? impossible,
    TResult Function()? possible,
    TResult Function()? required,
    required TResult orElse(),
  }) {
    if (impossible != null) {
      return impossible();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImpossibleRelocation value) impossible,
    required TResult Function(PossibleRelocation value) possible,
    required TResult Function(RequiredRelocation value) required,
  }) {
    return impossible(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ImpossibleRelocation value)? impossible,
    TResult Function(PossibleRelocation value)? possible,
    TResult Function(RequiredRelocation value)? required,
  }) {
    return impossible?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImpossibleRelocation value)? impossible,
    TResult Function(PossibleRelocation value)? possible,
    TResult Function(RequiredRelocation value)? required,
    required TResult orElse(),
  }) {
    if (impossible != null) {
      return impossible(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$ImpossibleRelocationToJson(this);
  }
}

abstract class ImpossibleRelocation extends Relocation {
  const factory ImpossibleRelocation() = _$ImpossibleRelocation;
  const ImpossibleRelocation._() : super._();

  factory ImpossibleRelocation.fromJson(Map<String, dynamic> json) = _$ImpossibleRelocation.fromJson;
}

/// @nodoc
abstract class $PossibleRelocationCopyWith<$Res> {
  factory $PossibleRelocationCopyWith(PossibleRelocation value, $Res Function(PossibleRelocation) then) =
      _$PossibleRelocationCopyWithImpl<$Res>;
}

/// @nodoc
class _$PossibleRelocationCopyWithImpl<$Res> extends _$RelocationCopyWithImpl<$Res>
    implements $PossibleRelocationCopyWith<$Res> {
  _$PossibleRelocationCopyWithImpl(PossibleRelocation _value, $Res Function(PossibleRelocation) _then)
      : super(_value, (v) => _then(v as PossibleRelocation));

  @override
  PossibleRelocation get _value => super._value as PossibleRelocation;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('POSSIBLE')
class _$PossibleRelocation extends PossibleRelocation {
  const _$PossibleRelocation({String? $type})
      : $type = $type ?? 'POSSIBLE',
        super._();

  factory _$PossibleRelocation.fromJson(Map<String, dynamic> json) => _$$PossibleRelocationFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Relocation.possible()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is PossibleRelocation);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() impossible,
    required TResult Function() possible,
    required TResult Function() required,
  }) {
    return possible();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? impossible,
    TResult Function()? possible,
    TResult Function()? required,
  }) {
    return possible?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? impossible,
    TResult Function()? possible,
    TResult Function()? required,
    required TResult orElse(),
  }) {
    if (possible != null) {
      return possible();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImpossibleRelocation value) impossible,
    required TResult Function(PossibleRelocation value) possible,
    required TResult Function(RequiredRelocation value) required,
  }) {
    return possible(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ImpossibleRelocation value)? impossible,
    TResult Function(PossibleRelocation value)? possible,
    TResult Function(RequiredRelocation value)? required,
  }) {
    return possible?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImpossibleRelocation value)? impossible,
    TResult Function(PossibleRelocation value)? possible,
    TResult Function(RequiredRelocation value)? required,
    required TResult orElse(),
  }) {
    if (possible != null) {
      return possible(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$PossibleRelocationToJson(this);
  }
}

abstract class PossibleRelocation extends Relocation {
  const factory PossibleRelocation() = _$PossibleRelocation;
  const PossibleRelocation._() : super._();

  factory PossibleRelocation.fromJson(Map<String, dynamic> json) = _$PossibleRelocation.fromJson;
}

/// @nodoc
abstract class $RequiredRelocationCopyWith<$Res> {
  factory $RequiredRelocationCopyWith(RequiredRelocation value, $Res Function(RequiredRelocation) then) =
      _$RequiredRelocationCopyWithImpl<$Res>;
}

/// @nodoc
class _$RequiredRelocationCopyWithImpl<$Res> extends _$RelocationCopyWithImpl<$Res>
    implements $RequiredRelocationCopyWith<$Res> {
  _$RequiredRelocationCopyWithImpl(RequiredRelocation _value, $Res Function(RequiredRelocation) _then)
      : super(_value, (v) => _then(v as RequiredRelocation));

  @override
  RequiredRelocation get _value => super._value as RequiredRelocation;
}

/// @nodoc
@JsonSerializable()
@FreezedUnionValue('REQUIRED')
class _$RequiredRelocation extends RequiredRelocation {
  const _$RequiredRelocation({String? $type})
      : $type = $type ?? 'REQUIRED',
        super._();

  factory _$RequiredRelocation.fromJson(Map<String, dynamic> json) => _$$RequiredRelocationFromJson(json);

  @JsonKey(name: 'type')
  final String $type;

  @override
  String toString() {
    return 'Relocation.required()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other.runtimeType == runtimeType && other is RequiredRelocation);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() impossible,
    required TResult Function() possible,
    required TResult Function() required,
  }) {
    return required();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? impossible,
    TResult Function()? possible,
    TResult Function()? required,
  }) {
    return required?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? impossible,
    TResult Function()? possible,
    TResult Function()? required,
    required TResult orElse(),
  }) {
    if (required != null) {
      return required();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ImpossibleRelocation value) impossible,
    required TResult Function(PossibleRelocation value) possible,
    required TResult Function(RequiredRelocation value) required,
  }) {
    return required(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(ImpossibleRelocation value)? impossible,
    TResult Function(PossibleRelocation value)? possible,
    TResult Function(RequiredRelocation value)? required,
  }) {
    return required?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ImpossibleRelocation value)? impossible,
    TResult Function(PossibleRelocation value)? possible,
    TResult Function(RequiredRelocation value)? required,
    required TResult orElse(),
  }) {
    if (required != null) {
      return required(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$RequiredRelocationToJson(this);
  }
}

abstract class RequiredRelocation extends Relocation {
  const factory RequiredRelocation() = _$RequiredRelocation;
  const RequiredRelocation._() : super._();

  factory RequiredRelocation.fromJson(Map<String, dynamic> json) = _$RequiredRelocation.fromJson;
}
