import 'package:dart_jobs/src/common/localization/localizations.dart';
import 'package:dart_jobs/src/feature/settings/widget/settings_widget.dart';
import 'package:flutter/material.dart';

@immutable
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.localization.settings),
        ),
        body: const SafeArea(
          child: SettingsWidget(),
        ),
      );
}
