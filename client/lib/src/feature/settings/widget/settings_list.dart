import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/cloud_messaging/bloc/cloud_messaging_bloc.dart';
import 'package:dart_jobs_client/src/feature/cloud_messaging/widget/cloud_messaging_scope.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/flags/russia_flag_painter.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/flags/usa_flag_painter.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_scope.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => BlocBuilder<CloudMessagingBLoC, CloudMessagingState>(
        builder: (context, fcmState) => ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: math.max((MediaQuery.of(context).size.width - kBodyWidth) / 2, 8), // 620 px - max width
            vertical: 12,
          ),
          children: <Widget>[
            //SettingsSection(title: context.localization.settings_app_configuration),
            const SizedBox(height: 24),
            SettingsTile(
              leading: const Icon(Icons.style),
              title: Text(context.localization.theme_scheme),
              subtitle: const _ThemeSelector(),
            ),
            const Divider(),
            SettingsTile(
              leading: const Icon(Icons.language),
              title: Text(context.localization.settings_app_language),
              subtitle: const _LanguageSelector(),
            ),
            // Пока отключил пуши для всех платформ
            //if (fcmState.isSupported) ...<Widget>[
            //  const Divider(),
            //  const RequestFCMPermissions(),
            //],
            const Divider(),
          ],
        ),
      );
}

@immutable
class _ThemeSelector extends StatelessWidget {
  const _ThemeSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final settings = SettingsScope.settingsOf(context, listen: true);
    final isDark = settings.theme == 'dark';
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: constraints.maxWidth < 280
            ? <Widget>[
                _ThemeChip.min(
                  key: ValueKey<String>('min_light_$isDark'),
                  selected: !isDark,
                  themeCode: 'light',
                  iconWidget: const Icon(Icons.light_mode),
                ),
                const SizedBox(width: 24),
                _ThemeChip.min(
                  key: ValueKey<String>('min_dark_$isDark'),
                  selected: isDark,
                  themeCode: 'dark',
                  iconWidget: const Icon(Icons.dark_mode),
                ),
              ]
            : <Widget>[
                _ThemeChip(
                  key: ValueKey<String>('expanded_light_$isDark'),
                  selected: !isDark,
                  themeCode: 'light',
                  theme: context.localization.theme_scheme_light_mode,
                  iconWidget: const Icon(Icons.light_mode),
                ),
                const SizedBox(width: 6),
                _ThemeChip(
                  key: ValueKey<String>('expanded_dark_$isDark'),
                  selected: isDark,
                  themeCode: 'dark',
                  theme: context.localization.theme_scheme_dark_mode,
                  iconWidget: const Icon(Icons.dark_mode),
                ),
              ],
      ),
    );
  }
}

@immutable
class _ThemeChip extends StatelessWidget {
  const _ThemeChip({
    required this.themeCode,
    required this.theme,
    required this.selected,
    this.iconWidget = const SizedBox.shrink(),
    Key? key,
  })  : expanded = true,
        super(key: key);

  const _ThemeChip.min({
    required this.themeCode,
    required this.selected,
    this.iconWidget = const SizedBox.shrink(),
    Key? key,
  })  : expanded = false,
        theme = '',
        super(key: key);

  final bool expanded;
  final String themeCode;
  final String theme;
  final Widget iconWidget;
  final bool selected;

  @override
  Widget build(BuildContext context) => expanded
      ? ChoiceChip(
          label: SizedBox(
            width: 80,
            child: Center(
              child: Text(theme),
            ),
          ),
          avatar: iconWidget,
          selected: selected,
          onSelected: selected ? null : (_) => _onSelected(context),
        )
      : CircleAvatar(
          backgroundColor: selected
              ? Theme.of(context).chipTheme.secondarySelectedColor
              : Theme.of(context).chipTheme.backgroundColor,
          child: IconButton(
            icon: iconWidget,
            visualDensity: VisualDensity.standard,
            onPressed: selected ? null : () => _onSelected(context),
            color: Theme.of(context).iconTheme.color,
          ),
        );

  void _onSelected(BuildContext context) => WidgetsBinding.instance?.addPostFrameCallback(
        (_) => SettingsScope.updateOf(
          context,
          settings: SettingsScope.settingsOf(context).copyWith(
            theme: themeCode,
          ),
        ),
      );
}

@immutable
class _LanguageSelector extends StatelessWidget {
  const _LanguageSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    final isEn = languageCode == 'en';
    final isRu = languageCode == 'ru';
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: constraints.maxWidth < 280
            ? <Widget>[
                _LocaleChip.min(
                  key: ValueKey<String>('min_en_$isEn'),
                  selected: isEn,
                  languageCode: 'en',
                  iconWidget: const CustomPaint(
                    size: Size(24, 16),
                    painter: UsaFlagPainter(),
                  ),
                ),
                const SizedBox(width: 24),
                _LocaleChip.min(
                  key: ValueKey<String>('min_ru_$isRu'),
                  selected: isRu,
                  languageCode: 'ru',
                  iconWidget: const CustomPaint(
                    size: Size(24, 16),
                    painter: RussiaFlagPainter(),
                  ),
                ),
              ]
            : <Widget>[
                _LocaleChip(
                  key: ValueKey<String>('expanded_en_$isEn'),
                  selected: isEn,
                  languageCode: 'en',
                  language: context.localization.english,
                  iconWidget: const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: CustomPaint(
                      size: Size(24, 16),
                      painter: UsaFlagPainter(),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _LocaleChip(
                  key: ValueKey<String>('expanded_ru_$isRu'),
                  selected: languageCode == 'ru',
                  languageCode: 'ru',
                  language: context.localization.russian,
                  iconWidget: const Padding(
                    padding: EdgeInsets.fromLTRB(4, 0, 0, 0),
                    child: CustomPaint(
                      size: Size(24, 16),
                      painter: RussiaFlagPainter(),
                    ),
                  ),
                ),
              ],
      ),
    );
  }
}

@immutable
class _LocaleChip extends StatelessWidget {
  const _LocaleChip({
    required this.languageCode,
    required this.language,
    required this.selected,
    this.iconWidget = const SizedBox.shrink(),
    Key? key,
  })  : expanded = true,
        super(key: key);

  const _LocaleChip.min({
    required this.languageCode,
    required this.selected,
    this.iconWidget = const SizedBox.shrink(),
    Key? key,
  })  : language = '',
        expanded = false,
        super(key: key);

  final String languageCode;
  final String language;
  final Widget iconWidget;
  final bool expanded;
  final bool selected;

  @override
  Widget build(BuildContext context) => expanded
      ? ChoiceChip(
          label: SizedBox(
            width: 80,
            child: Center(
              child: Text(language),
            ),
          ),
          avatar: iconWidget,
          selected: selected,
          onSelected: selected ? null : (_) => _updateLocale(context),
        )
      : CircleAvatar(
          backgroundColor: selected
              ? Theme.of(context).chipTheme.secondarySelectedColor
              : Theme.of(context).chipTheme.backgroundColor,
          child: IconButton(
            icon: iconWidget,
            visualDensity: VisualDensity.standard,
            onPressed: selected ? null : () => _updateLocale(context),
            color: Theme.of(context).iconTheme.color,
          ),
        );

  void _updateLocale(BuildContext context) => SettingsScope.updateOf(
        context,
        settings: SettingsScope.settingsOf(context).copyWith(
          locale: languageCode,
        ),
      );
}

@immutable
class RequestFCMPermissions extends StatelessWidget {
  const RequestFCMPermissions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SettingsTile(
        leading: const Icon(Icons.notifications),
        title: Text(context.localization.settings_app_allow_fcm),
        subtitle: Center(
          child: BlocBuilder<CloudMessagingBLoC, CloudMessagingState>(
            builder: (context, state) => state.isAuthorized
                ? ToggleButtons(
                    isSelected: const <bool>[
                      false,
                      false,
                    ],
                    constraints: const BoxConstraints(
                      minWidth: 100,
                      maxWidth: 150,
                      minHeight: 35,
                      maxHeight: 50,
                    ),
                    children: <Widget>[
                      Text(
                        context.localization.subscribe,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        context.localization.unsubscribe,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    onPressed: (idx) {
                      switch (idx) {
                        case 0:
                          CloudMessagingScope.subscribeToCreatedTopic(context);
                          break;
                        case 1:
                          CloudMessagingScope.unsubscribeToCreatedTopic(context);
                          break;
                      }
                    },
                  )
                : TextButton(
                    onPressed: () => CloudMessagingScope.request(context),
                    child: Text(context.localization.settings_app_allow_fcm),
                  ),
          ),
        ),
      );

  // TextButton(
  //   onPressed: () => BlocProvider.of<CloudMessagingBLoC>(context).add(const CloudMessagingEvent.request()),
  //   child: Text(context.localization.settings_app_allow_fcm),
  // )
}
