import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../../authentication/model/user_entity.dart';
import '../../authentication/widget/authentication_scope.dart';
import '../../initialization/widget/initialization_scope.dart';
import '../bloc/settings_bloc.dart';
import '../model/user_settings.dart';

@immutable
class SettingsScope extends StatefulWidget {
  final Widget child;
  const SettingsScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  static SettingsBLoC _blocOf(BuildContext context) => _InheritedSettings.stateOf(context).settingsBLoC;

  /// Обновить настройки приложения
  static void updateOf(BuildContext context, {required UserSettings settings}) {
    final user = AuthenticationScope.userOf(context, listen: false).authenticatedOrNull;
    if (user == null) return;
    _blocOf(context).add(
      SettingsEvent.update(
        user,
        settings,
      ),
    );
  }

  /// Получить текущие настройки приложения
  static UserSettings settingsOf(BuildContext context, {bool listen = false}) =>
      _InheritedSettings.of(context, listen: listen).settings;

  /// Получить и подписаться на текущую локаль приложения
  static Locale localeOf(BuildContext context) => Locale(_InheritedSettings.aspectOf(context, 'locale').locale);

  /// Получить и подписаться на текущую тему приложения
  static ThemeData themeOf(BuildContext context) {
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
      repository: InitializationScope.storeOf(context).settingsRepository,
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

  void getSettingsFromServer(AuthenticatedUser? user) {
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
  Widget build(BuildContext context) => BlocBuilder<SettingsBLoC, SettingsState>(
        bloc: settingsBLoC,
        buildWhen: (prev, next) => prev != next,
        builder: (context, state) => _InheritedSettings(
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
    required Widget child,
    Key? key,
  }) : super(child: child, key: key);

  @override
  bool updateShouldNotify(covariant _InheritedSettings oldWidget) => oldWidget.settings != settings;

  @override
  bool updateShouldNotifyDependent(covariant _InheritedSettings oldWidget, Set<String> dependencies) =>
      oldWidget.settings != settings &&
      ((dependencies.contains('locale') && oldWidget.settings.locale != settings.locale) ||
          (dependencies.contains('theme') && oldWidget.settings.theme != settings.theme));

  static _InheritedSettings of(BuildContext context, {bool listen = false}) => listen
      ? context.dependOnInheritedWidgetOfExactType<_InheritedSettings>()!
      : (context.getElementForInheritedWidgetOfExactType<_InheritedSettings>()!.widget as _InheritedSettings);

  static UserSettings aspectOf(BuildContext context, String aspect) =>
      InheritedModel.inheritFrom<_InheritedSettings>(context, aspect: aspect)!.settings;

  static _SettingsScopeState stateOf(BuildContext context) => of(context, listen: false).state;
}
