import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/flags/russia_flag_painter.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/flags/usa_flag_painter.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_scope.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_tile.dart';
import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          horizontal: math.max((MediaQuery.of(context).size.width - bodyWidth) / 2, 8), // 620 px - max width
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
          const Divider(),
        ],
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ChoiceChip(
          tooltip: context.localization.theme_scheme_light_mode,
          label: SizedBox(
            width: 80,
            child: Center(
              child: Text(context.localization.theme_scheme_light_mode),
            ),
          ),
          avatar: const Icon(Icons.light_mode),
          selected: !isDark,
          onSelected: isDark ? (value) => _onSelected(context, 'light') : null,
          key: ValueKey<String>('light_${!isDark}'),
        ),
        const SizedBox(width: 6),
        ChoiceChip(
          tooltip: context.localization.theme_scheme_dark_mode,
          label: SizedBox(
            width: 80,
            child: Center(
              child: Text(context.localization.theme_scheme_dark_mode),
            ),
          ),
          avatar: const Icon(Icons.dark_mode),
          selected: isDark,
          onSelected: isDark ? null : (value) => _onSelected(context, 'dark'),
          key: ValueKey<String>('dark_$isDark'),
        ),
      ],
    );
  }

  void _onSelected(BuildContext context, String theme) => WidgetsBinding.instance?.addPostFrameCallback(
        (_) => SettingsScope.updateOf(
          context,
          settings: SettingsScope.settingsOf(context).copyWith(
            theme: theme,
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _LocaleChip(
          //key: ValueKey<String>('en_${languageCode == 'en'}'),
          selected: languageCode == 'en',
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
          //key: ValueKey<String>('ru_${languageCode == 'ru'}'),
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
  }) : super(key: key);

  final String languageCode;
  final String language;
  final Widget iconWidget;
  final bool selected;

  @override
  Widget build(BuildContext context) => ChoiceChip(
        label: SizedBox(
          width: 80,
          child: Center(
            child: Text(language),
          ),
        ),
        avatar: iconWidget,
        selected: selected,
        onSelected: selected ? null : (_) => _updateLocale(context),
      );

  void _updateLocale(BuildContext context) => SettingsScope.updateOf(
        context,
        settings: SettingsScope.settingsOf(context).copyWith(
          locale: languageCode,
        ),
      );
}
