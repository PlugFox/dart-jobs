import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_info/platform_info.dart';

import '../../../common/router/app_router.dart';
import '../model/user_entity.dart';
import 'authentication_scope.dart';

@immutable
class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthenticationScope.userOf(context);
    if (user is! AuthenticatedUser) {
      WidgetsBinding.instance?.addPostFrameCallback(
        (_) => AppRouter.pop(context),
      );
      return const SizedBox.shrink();
    }
    final photo = user.photoURL;
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 120,
            child: Row(
              children: <Widget>[
                SizedBox.square(
                  dimension: 120,
                  child: Center(
                    child: Image.network(
                      photo!,
                      alignment: Alignment.center,
                      fit: BoxFit.scaleDown,
                      filterQuality: FilterQuality.medium,
                      width: 120,
                      height: 120,
                      cacheHeight: 120,
                      cacheWidth: 120,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '${user.displayName}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      if (!platform.buildMode.isRelease)
                        Text(
                          'uid: ${user.uid}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      Text(
                        '${user.email}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        user.phoneNumber ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 64,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: OutlinedButton(
                onPressed: () {
                  AppRouter.pop(context);
                  AuthenticationScope.logOut(context);
                },
                child: const Text('Log out'),
              ),
            ),
          ),
          const Expanded(
            child: Placeholder(),
          ),
        ],
      ),
    );
  }
}
