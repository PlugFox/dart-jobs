import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:platform_info/platform_info.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    @JsonKey(name: 'locale', required: true, disallowNullValue: true) required String locale,
    @JsonKey(name: 'theme', required: true, disallowNullValue: true) required String theme,
    //@JsonKey(name: 'tip_of_the_day', required: true, disallowNullValue: true) required String tipOfTheDay,
  }) = _UserSettings;

  static UserSettings? _initial;

  // ignore: prefer_constructors_over_static_methods
  static UserSettings get initial => _initial ??= UserSettings(
        locale: platform.locale,
        theme: 'light',
      );

  /// Generate Class from Map<String, dynamic>
  factory UserSettings.fromJson(Map<String, dynamic> json) => _$UserSettingsFromJson(json);
}
