import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/user_avatar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:url_launcher/url_launcher.dart';

/// Drawer приложения
/// Может отображаться рельсой, над роутером, при достаточной ширине экрана [kScaffoldWithRail]
/// Или же выдвигаться при необходимости, как [Drawer] от [AppMaterialContext]
@immutable
class DrawerScope extends StatefulWidget {
  const DrawerScope({
    required final this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  /// Выдвинута ли рельса дравера над всем лейаутом?
  static bool isDrawerShown(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_InheritedDrawerScope>()?.showDrawer ?? false;

  /// Find _DrawerScopeState in BuildContext
  @protected
  @doNotStore
  // ignore: unused_element
  static _DrawerScopeState _stateOf(BuildContext context, {bool listen = false}) {
    _DrawerScopeState? state;
    if (listen) {
      state = context.dependOnInheritedWidgetOfExactType<_InheritedDrawerScope>()?.state;
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedDrawerScope>()?.widget;
      state = inheritedWidget is _InheritedDrawerScope ? inheritedWidget.state : null;
    }
    return state ?? _notInScope();
  }

  @alwaysThrows
  static Never _notInScope() => throw UnsupportedError('Not in DrawerScope scope');

  @override
  State<DrawerScope> createState() => _DrawerScopeState();
}

class _DrawerScopeState extends State<DrawerScope> {
  // ignore: prefer_final_fields
  MediaQueryData _mediaQueryData = const MediaQueryData();
  bool _showDrawer = false;

  //region Lifecycle
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mediaQueryData = MediaQuery.of(context);
    final width = _mediaQueryData.size.width;
    _showDrawer = width >= kScaffoldWithRail;
  }
  //endregion

  @override
  Widget build(BuildContext context) => _InheritedDrawerScope(
        state: this,
        showDrawer: _showDrawer,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          // Это сделано не из за лени, а для переиспользования виджетов внутри Row
          // по сути это коллекция с условиями внутри нее, просто проверка на _showDrawer выполняется лишь раз
          // ignore: avoid-returning-widgets
          children: _showDrawer ? _layoutWithRail(context) : _layoutWithoutRail(context),
        ),
      );

  List<Widget> _layoutWithRail(BuildContext context) => <Widget>[
        SizedBox(
          key: const ValueKey<String>('AppRail'),
          width: kRailWidth,
          child: RepaintBoundary(
            child: MediaQuery(
              data: _mediaQueryData.copyWith(
                size: Size(
                  kRailWidth,
                  _mediaQueryData.size.height,
                ),
              ),
              child: const _AppRail(),
            ),
          ),
        ),
        Expanded(
          key: const ValueKey<String>('Body'),
          child: RepaintBoundary(
            child: MediaQuery(
              data: _mediaQueryData.copyWith(
                size: Size(
                  _mediaQueryData.size.width - kRailWidth,
                  _mediaQueryData.size.height,
                ),
              ),
              child: widget.child,
            ),
          ),
        ),
      ];

  List<Widget> _layoutWithoutRail(BuildContext context) => <Widget>[
        Expanded(
          key: const ValueKey<String>('Body'),
          child: RepaintBoundary(
            child: MediaQuery(
              data: _mediaQueryData,
              child: widget.child,
            ),
          ),
        ),
      ];
}

@immutable
class _InheritedDrawerScope extends InheritedWidget {
  const _InheritedDrawerScope({
    required final this.state,
    required final this.showDrawer,
    required final Widget child,
    Key? key,
  }) : super(
          key: key,
          child: child,
        );

  final _DrawerScopeState state;
  final bool showDrawer;

  @override
  bool updateShouldNotify(_InheritedDrawerScope oldWidget) => showDrawer != oldWidget.showDrawer;
}

@immutable
class _AppRail extends StatelessWidget {
  const _AppRail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const AppDrawer();
}

@immutable
class AppDrawer extends StatelessWidget {
  const AppDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const _DrawerHeader(),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                children: <Widget>[
                  // Профиль
                  _DrawerTile(
                    icon: Icons.account_circle,
                    title: context.localization.profile,
                    shouldBeDisabled: (location) => location.endsWith('profile'),
                    onTap: () {
                      final router = AppRouter.of(context);
                      AuthenticationScope.authenticateOr(
                        context,
                        (_) => router.router.setNewRoutePath(
                          const ProfileRouteConfiguration(),
                        ),
                      );
                    },
                  ),
                  // Настройки
                  _DrawerTile(
                    icon: Icons.settings,
                    title: context.localization.settings,
                    shouldBeDisabled: (location) => location.endsWith('settings'),
                    onTap: () => AppRouter.navigate(
                      context,
                      (configuration) => const SettingsRouteConfiguration(),
                    ),
                  ),
                  // Создать новую работу
                  _DrawerTile(
                    icon: Icons.create,
                    title: context.localization.create_new_job,
                    shouldBeDisabled: (location) => location.endsWith('job'),
                    onTap: () {
                      final router = AppRouter.of(context);
                      AuthenticationScope.authenticateOr(
                        context,
                        (final user) => router.router.setNewRoutePath(
                          const JobRouteConfiguration.create(),
                        ),
                      );
                    },
                  ),
                  // Избранные
                  _DrawerTile(
                    icon: Icons.favorite,
                    title: context.localization.favorite,
                    onTap: null,
                  ),
                  // Отправить баг репорт
                  _DrawerTile(
                    icon: Icons.bug_report,
                    title: context.localization.bug_report_title,
                    shouldBeDisabled: (location) => location.endsWith('feedback'),
                    onTap: () => AppRouter.navigate(context, (configuration) => const BugReportRouteConfiguration()),
                  ),
                  // Отобразить лицензии
                  _DrawerTile(
                    icon: Icons.info,
                    title: context.localization.licenses,
                    onTap: () => AppRouter.showLicensePageOf(context),
                  ),
                  // Залогиниться или разлогиниться
                  const LoginOrLogoutTile(),
                ],
              ),
            ),
            const Divider(
              height: 3,
              indent: 12,
              endIndent: 12,
            ),
            SizedBox(
              height: 50,
              child: Center(
                child: Text.rich(
                  TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                        text: 'by ',
                        style: Theme.of(context).textTheme.caption,
                      ),
                      TextSpan(
                        text: '@PlugFox',
                        style: Theme.of(context).textTheme.caption?.copyWith(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => launch('https://github.com/PlugFox').catchError(
                                (Object error, StackTrace stackTrace) {
                                  l.e(
                                    'Произошла ошибка при открытии ссылки @PlugFox в Drawer: "$error"',
                                    stackTrace,
                                  );
                                  return true;
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required final this.icon,
    required final this.title,
    required final this.onTap,
    final this.shouldBeDisabled,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool Function(String location)? shouldBeDisabled;

  @override
  Widget build(BuildContext context) {
    final router = AppRouter.routerOf(context);
    return AnimatedBuilder(
      animation: router,
      builder: (context, child) {
        final isDisabled = (shouldBeDisabled?.call(router.currentConfiguration.location) ?? false) || onTap == null;
        return Opacity(
          opacity: isDisabled ? .5 : 1,
          child: ListTile(
            leading: Icon(icon),
            title: child,
            onTap: isDisabled ? null : onTap,
          ),
        );
      },
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

@immutable
class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthenticationScope.authenticatedOrNullOf(context, listen: true);
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      currentAccountPicture: const UserAvatar(
        size: 80,
      ),
      currentAccountPictureSize: const Size.square(80),
      accountName: Text(
        user?.displayName ?? '',
        style: Theme.of(context).primaryTextTheme.headline6,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      accountEmail: Text(
        user?.email ?? user?.phoneNumber ?? '',
        style: Theme.of(context).primaryTextTheme.caption,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}

@immutable
class LoginOrLogoutTile extends StatelessWidget {
  const LoginOrLogoutTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AuthenticationScope.userOf(context, listen: true).when(
        authenticated: (_) => ListTile(
          leading: const Icon(Icons.logout),
          title: Text(
            context.localization.log_out,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => AuthenticationScope.logOut(context),
        ),
        notAuthenticated: () => ListTile(
          leading: const Icon(Icons.login),
          title: Text(
            context.localization.log_in,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () => AuthenticationScope.signInWithGoogle(context),
        ),
      );
}
