import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => AdaptiveScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(context.localization.profile),
        ),
        body: const SafeArea(
          child: _ProfileBody(),
        ),
      );
}

@immutable
class _ProfileBody extends StatefulWidget {
  const _ProfileBody({
    final Key? key,
  }) : super(key: key);

  @override
  State<_ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<_ProfileBody> {
  @override
  Widget build(final BuildContext context) => const ProfileWidget();
}
