import 'dart:ui' as ui show Brightness, window;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:platform_info/platform_info.dart';

part 'user_settings.freezed.dart';
part 'user_settings.g.dart';

@freezed
class UserSettings with _$UserSettings {
  const factory UserSettings({
    // ignore: invalid_annotation_target
    @JsonKey(name: 'locale', required: true, disallowNullValue: true) required final String locale,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'theme', required: true, disallowNullValue: true) required final String theme,
    //@JsonKey(name: 'tip_of_the_day', required: true, disallowNullValue: true) required String tipOfTheDay,
  }) = _UserSettings;

  static UserSettings? _initial;

  // ignore: prefer_constructors_over_static_methods
  static UserSettings get initial => _initial ??= UserSettings(
        locale: platform.locale,
        theme: ui.window.platformBrightness == ui.Brightness.dark ? 'dark' : 'light',
      );

  /// Generate Class from Map<String, dynamic>
  factory UserSettings.fromJson(final Map<String, dynamic> json) => _$UserSettingsFromJson(json);
}
