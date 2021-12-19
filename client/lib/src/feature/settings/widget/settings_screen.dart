import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_widget.dart';
import 'package:flutter/material.dart';

@immutable
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => AdaptiveScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(context.localization.settings),
        ),
        body: const SafeArea(
          child: SettingsWidget(),
        ),
      );
}
