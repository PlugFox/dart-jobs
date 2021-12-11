import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/page_router.dart';
import 'package:flutter/material.dart';

@immutable
class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(context.localization.not_found),
        ),
        body: SafeArea(
          child: Center(
            child: TextButton(
              onPressed: () => PageRouter.maybePop(context).then<void>(
                (final value) {
                  if (!value) {
                    PageRouter.goHome(context);
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
