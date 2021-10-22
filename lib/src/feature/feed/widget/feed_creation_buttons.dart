import 'package:dart_jobs/src/common/localization/localizations.dart';
import 'package:dart_jobs/src/feature/authentication/widget/authentication_scope.dart';
import 'package:flutter/material.dart';

@immutable
class FeedCreationButtons extends StatelessWidget {
  const FeedCreationButtons({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SliverToBoxAdapter(
        child: SizedBox(
          height: 75,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: 250,
                    height: 50,
                    child: OutlinedButton(
                      child: Text(
                        context.localization.create_new_job.toUpperCase(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onPressed: () {
                        AuthenticationScope.authenticateOr(
                          context,
                          (final user) {
                            throw UnimplementedError('Не реализовано');
                            /*
                            FeedScope.createJobOf(
                              context,
                              user: user,
                            );
                            */
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
