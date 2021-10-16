import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../common/localization/localizations.dart';
import 'settings_widget.dart';

@immutable
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.localization.settings),
        ),
        body: const SafeArea(
          child: SettingsWidget(),
        ),
      );
}
