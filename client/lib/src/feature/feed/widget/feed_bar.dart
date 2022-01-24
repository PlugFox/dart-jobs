import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/common/utils/screen_util.dart';
import 'package:dart_jobs_client/src/common/widget/drawer_scope.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/user_avatar.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_search_bar.dart';
import 'package:flutter/material.dart';

/// Шапка
class FeedBar extends StatelessWidget {
  const FeedBar({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SliverAppBar(
        pinned: true,
        floating: true,
        snap: false,
        toolbarHeight: kToolbarHeight,
        //shape: const RoundedRectangleBorder(
        //  borderRadius: BorderRadius.vertical(
        //    top: Radius.zero,
        //    bottom: Radius.circular(8),
        //  ),
        //),
        //forceElevated: true,
        //elevation: 2,
        collapsedHeight: ScreenUtil.screenSizeOf(context).maybeWhen<double?>(
          small: () => kToolbarHeight + 15,
          medium: () => kToolbarHeight + 15,
          large: () => kToolbarHeight + 15,
          extraLarge: () => kToolbarHeight + 15,
          orElse: () => null,
        ),
        expandedHeight: kToolbarHeight + FeedSearchBar.searchBarSize.height + 15,
        //elevation: 4,
        leading: DrawerScope.isDrawerShown(context)
            ? null
            : IconButton(
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: const Icon(Icons.menu),
              ),
        title: Text(context.localization.title),
        actions: const <Widget>[
          /*
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
          */
          /*
          /// Help && Bug report
          SizedBox.square(
            dimension: kToolbarHeight,
            child: FeedBarSettings(),
          ),
          */
          SizedBox.square(
            dimension: kToolbarHeight,
            child: FeedBarSettings(),
          ),
          SizedBox.square(
            dimension: kToolbarHeight,
            child: UserAvatar(),
          ),
          SizedBox(width: 15),
        ],
        bottom: const FeedSearchBar(),
      );
}

class FeedBarSettings extends StatelessWidget {
  const FeedBarSettings({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => IconButton(
        onPressed: () {
          AppRouter.navigate(
            context,
            (final configuration) => const SettingsRouteConfiguration(),
          );
        },
        icon: const CircleAvatar(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  _kSettingsIcon,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      );
}

const IconData _kSettingsIcon = Icons.settings;
