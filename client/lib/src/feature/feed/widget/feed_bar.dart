import 'package:dart_jobs_client/src/common/constant/assets.gen.dart' as assets;
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/page_router.dart';
import 'package:dart_jobs_client/src/common/utils/screen_util.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
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
        collapsedHeight: ScreenUtil.screenSizeOf(context).maybeWhen<double?>(
          small: () => kToolbarHeight + 15,
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
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => IconButton(
        onPressed: () {
          PageRouter.navigate(
            context,
            (final configuration) => const SettingsPageConfiguration(),
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
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => IconButton(
        onPressed: () {
          AuthenticationScope.authenticateOr(
            context,
            (final user) => PageRouter.navigate(
              context,
              (final configuration) => const ProfilePageConfiguration(),
            ),
          );
        },
        icon: const CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(4),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _UserAvatarImage(),
              ),
            ),
          ),
        ),
      );
}

@immutable
class _UserAvatarImage extends StatelessWidget {
  static const double radius = 26;

  const _UserAvatarImage({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final photoURL = AuthenticationScope.userOf(context, listen: true).when<String?>(
      authenticated: (final user) => user.photoURL,
      notAuthenticated: () => null,
    );
    return photoURL == null || photoURL.isEmpty
        ? const Icon(Icons.person, size: radius)
        : ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Image.network(
              photoURL,
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              filterQuality: FilterQuality.medium,
              width: radius * 2,
              height: radius * 2,
              cacheHeight: (radius * 2).truncate(),
              cacheWidth: (radius * 2).truncate(),
            ),
          );
  }
}
