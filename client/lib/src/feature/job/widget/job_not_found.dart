import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:flutter/material.dart';

@immutable
class JobNotFound extends StatelessWidget {
  const JobNotFound({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => AdaptiveScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            context.localization.job_not_found,
            maxLines: 1,
          ),
        ),
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: <Widget>[
                Center(
                  child: Text(
                    context.localization.job_not_found,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: IconButton(
                    onPressed: () => AppRouter.goHome(context),
                    icon: Icon(
                      _kHomeIcon,
                      color: Theme.of(context).primaryColor,
                    ),
                    iconSize: 48,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

const IconData _kHomeIcon = Icons.home;
