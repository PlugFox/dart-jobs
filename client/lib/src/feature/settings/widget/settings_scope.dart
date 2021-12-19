import 'package:dart_jobs_client/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/settings/bloc/settings_bloc.dart';
import 'package:dart_jobs_client/src/feature/settings/model/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class SettingsScope extends StatefulWidget {
  final Widget child;
  const SettingsScope({
    required this.child,
    final Key? key,
  }) : super(key: key);

  static SettingsBLoC _blocOf(final BuildContext context) => _InheritedSettings.stateOf(context)!.settingsBLoC;

  /// Обновить настройки приложения
  static void updateOf(final BuildContext context, {required final UserSettings settings}) => _blocOf(context).add(
        SettingsEvent.update(
          AuthenticationScope.userOf(context, listen: false),
          settings,
        ),
      );

  /// Получить текущие настройки приложения
  static UserSettings settingsOf(final BuildContext context, {bool listen = true}) =>
      _InheritedSettings.settingsOf(context, listen: listen)!;

  /// Получить и подписаться на текущую локаль приложения
  static Locale localeOf(final BuildContext context) => Locale(_InheritedSettings.aspectOf(context, 'locale').locale);

  /// Получить и подписаться на текущую тему приложения
  static ThemeData themeOf(final BuildContext context) {
    switch (_InheritedSettings.aspectOf(context, 'theme').theme) {
      case 'dark':
        return ThemeData.dark();
      case 'light':
      default:
        return ThemeData.light();
    }
  }

  @override
  State<StatefulWidget> createState() => _SettingsScopeState();
}

class _SettingsScopeState extends State<SettingsScope> {
  AuthenticatedUser? _currentUser;
  late SettingsBLoC settingsBLoC;

  @override
  void initState() {
    super.initState();
    settingsBLoC = SettingsBLoC(
      repository: RepositoryScope.of(context).settingsRepository,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final user = AuthenticationScope.userOf(context, listen: true).authenticatedOrNull;
    if (_currentUser != user) {
      _currentUser = user;
      getSettingsFromServer(user);
    }
  }

  void getSettingsFromServer(final AuthenticatedUser? user) {
    if (user == null || user.isNotAuthenticated) return;
    settingsBLoC.add(
      SettingsEvent.getFromServer(user),
    );
  }

  @override
  void dispose() {
    settingsBLoC.close();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BlocBuilder<SettingsBLoC, SettingsState>(
        bloc: settingsBLoC,
        buildWhen: (final prev, final next) => prev != next,
        builder: (final context, final state) => _InheritedSettings(
          state: this,
          settings: state.settings,
          child: widget.child,
        ),
      );
}

class _InheritedSettings extends InheritedModel<String> {
  final _SettingsScopeState state;
  final UserSettings settings;
  const _InheritedSettings({
    required this.state,
    required this.settings,
    required final Widget child,
    final Key? key,
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant final _InheritedSettings oldWidget) => oldWidget.settings != settings;

  @override
  bool updateShouldNotifyDependent(covariant final _InheritedSettings oldWidget, final Set<String> dependencies) =>
      oldWidget.settings != settings &&
      ((dependencies.contains('locale') && oldWidget.settings.locale != settings.locale) ||
          (dependencies.contains('theme') && oldWidget.settings.theme != settings.theme));

  static UserSettings aspectOf(final BuildContext context, final String aspect) =>
      InheritedModel.inheritFrom<_InheritedSettings>(context, aspect: aspect)?.settings ?? UserSettings.initial;

  static _SettingsScopeState? stateOf(final BuildContext context, {bool listen = false}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()?.state
      : (context.getElementForInheritedWidgetOfExactType<_InheritedSettings>()?.widget as _InheritedSettings?)?.state;

  static UserSettings? settingsOf(final BuildContext context, {bool listen = false}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()?.settings
      : (context.getElementForInheritedWidgetOfExactType<_InheritedSettings>()?.widget as _InheritedSettings?)
          ?.settings;
}
