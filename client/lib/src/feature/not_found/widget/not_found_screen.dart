import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:flutter/material.dart';

@immutable
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => AdaptiveScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(context.localization.not_found),
        ),
        body: SafeArea(
          child: Center(
            child: TextButton(
              onPressed: () => AppRouter.maybePop(context).then<void>(
                (final value) {
                  if (!value) {
                    AppRouter.goHome(context);
                  }
                },
              ),
              child: Text(
                context.materialLocalizations.backButtonTooltip,
              ),
            ),
          ),
        ),
      );
}
