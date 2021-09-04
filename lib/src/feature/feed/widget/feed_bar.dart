import 'package:flutter/material.dart';

import '../../../common/constant/assets.gen.dart' as assets;
import '../../../common/localization/localizations.dart';
import '../../../common/router/app_router.dart';
import '../../../common/router/configuration.dart';
import '../../../common/utils/screen_util.dart';
import 'feed_search_bar.dart';

/// Шапка
class FeedBar extends StatelessWidget {
  const FeedBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverAppBar(
        pinned: true,
        floating: true,
        snap: false,
        toolbarHeight: kToolbarHeight,
        collapsedHeight: ScreenUtil.screenSizeOf(context).maybeWhen<double?>(
          medium: () => kToolbarHeight + 15,
          large: () => kToolbarHeight + 15,
          extraLarge: () => kToolbarHeight + 15,
          orElse: () => null,
        ),
        expandedHeight: kToolbarHeight + FeedSearchBar.searchBarSize.height + 15,
        //elevation: 4,
        leading: Center(
          child: SizedBox.square(
            dimension: 42,
            child: Card(
              color: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: const assets.$AssetsImageGen().dartLogo.dartLogoToolbar.image(),
              ),
            ),
          ),
        ),
        title: Text(context.localization.title),
        actions: const <Widget>[
          /*
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.settings),
          ),
          */
          SizedBox.square(
            dimension: kToolbarHeight,
            child: FeedBarSettings(),
          ),
          SizedBox.square(
            dimension: kToolbarHeight,
            child: FeedBarAvatar(),
          ),
          SizedBox(width: 15),
        ],
        bottom: const FeedSearchBar(),
      );
}

class FeedBarSettings extends StatelessWidget {
  const FeedBarSettings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          AppRouter.navigate(
            context,
            (configuration) => SettingsRouteConfiguration(),
          );
        },
        icon: const CircleAvatar(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(2),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  Icons.settings,
                  size: 30,
                ),
              ),
            ),
          ),
        ),
      );
}

@immutable
class FeedBarAvatar extends StatelessWidget {
  const FeedBarAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () {
          AppRouter.navigate(
            context,
            (configuration) => ProfileRouteConfiguration(),
          );
        },
        icon: const CircleAvatar(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Icon(
              Icons.person,
              size: 30,
            ),
          ),
        ),
      );
}
