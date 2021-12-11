import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/page_router.dart';
import 'package:flutter/material.dart';

@immutable
class JobNotFound extends StatelessWidget {
  const JobNotFound({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Scaffold(
        appBar: AppBar(
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
                    onPressed: () => PageRouter.goHome(context),
                    icon: Icon(
                      Icons.home,
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
