import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/localization/localizations.dart';
import '../../authentication/widget/authentication_scope.dart';
import 'feed_scope.dart';

@immutable
class FeedCreationButtons extends StatelessWidget {
  const FeedCreationButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
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
                          (user) {
                            FeedScope.createJobOf(
                              context,
                              user: user,
                            );
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
