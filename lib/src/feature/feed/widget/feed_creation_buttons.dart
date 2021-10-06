import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../common/router/page_router.dart';
import '../../authentication/widget/authentication_scope.dart';

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
            children: <Widget>[
              Expanded(
                child: Center(
                  child: OutlinedButton(
                    child: const Text(
                      'CREATE NEW JOB',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onPressed: () {
                      AuthenticationScope.authenticateOr(
                        context,
                        (user) {
                          PageRouter.navigate(
                            context,
                            (configuration) =>
                                throw UnimplementedError('Не реализовано'), //JobPageConfiguration.create(),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
