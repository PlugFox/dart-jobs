import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_scope.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_section.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_tile.dart';
import 'package:flutter/material.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: false,
        padding: EdgeInsets.symmetric(
          horizontal: math.max((MediaQuery.of(context).size.width - bodyWidth) / 2, 8), // 620 px - max width
          vertical: 12,
        ),
        children: <Widget>[
          SettingsSection(title: context.localization.settings_app_configuration),
          SettingsTile(
            leading: const Icon(Icons.style),
            title: Text(context.localization.theme_scheme),
            trailing: const _ThemeSelector(),
          ),
          const Divider(),
          SettingsTile(
            leading: const Icon(Icons.language),
            title: Text(context.localization.settings_app_language),
          ),
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
    final settings = SettingsScope.settingsOf(context);
    final isDark = settings.theme == 'dark';
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ChoiceChip(
          label: Text(context.localization.theme_scheme_light_mode),
          avatar: const Icon(Icons.light_mode),
          selected: true,
          onSelected: isDark
              ? (value) => SettingsScope.updateOf(
                    context,
                    settings: settings.copyWith(
                      theme: 'light',
                    ),
                  )
              : null,
        ),
        const SizedBox(width: 6),
        ChoiceChip(
          label: Text(context.localization.theme_scheme_dark_mode),
          avatar: const Icon(Icons.dark_mode),
          selected: false,
          onSelected: isDark
              ? null
              : (value) => SettingsScope.updateOf(
                    context,
                    settings: settings.copyWith(
                      theme: 'dark',
                    ),
                  ),
        ),
      ],
    );
  }
}
