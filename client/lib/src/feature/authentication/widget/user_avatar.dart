import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:flutter/material.dart';

@immutable
class UserAvatar extends StatelessWidget {
  const UserAvatar({
    final Key? key,
    final this.size = 60,
  }) : super(key: key);

  /// Диаметр аватара
  final double size;

  @override
  Widget build(final BuildContext context) => IconButton(
        onPressed: () {
          AuthenticationScope.authenticateOr(
            context,
            (final user) => AppRouter.navigate(
              context,
              (final configuration) => const ProfileRouteConfiguration(),
            ),
          );
        },
        icon: CircleAvatar(
          radius: size / 2,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: _UserAvatarImage(
                  size: size - 8,
                ),
              ),
            ),
          ),
        ),
      );
}

@immutable
class _UserAvatarImage extends StatelessWidget {
  const _UserAvatarImage({
    final this.size = 52,
    final Key? key,
  }) : super(key: key);

  /// Диаметр
  final double size;

  @override
  Widget build(final BuildContext context) {
    final photoURL = AuthenticationScope.userOf(context, listen: true).when<String?>(
      authenticated: (final user) => user.photoURL,
      notAuthenticated: () => null,
    );
    return photoURL == null || photoURL.isEmpty
        ? Icon(Icons.person, size: size / 2)
        : ClipRRect(
            borderRadius: BorderRadius.circular(size / 2),
            child: Image.network(
              photoURL,
              alignment: Alignment.center,
              fit: BoxFit.scaleDown,
              filterQuality: FilterQuality.medium,
              width: size,
              height: size,
              cacheHeight: size.truncate(),
              cacheWidth: size.truncate(),
            ),
          );
  }
}
