import 'package:collection/collection.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/profile_screen.dart';
import 'package:dart_jobs_client/src/feature/bug_report/widget/bug_report_page.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_screen.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_page.dart';
import 'package:dart_jobs_client/src/feature/not_found/widget/not_found_screen.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:platform_info/platform_info.dart';

/// Базовый класс роута для приложения, с ним работает корневой роутер
@immutable
abstract class AppPage<T extends Object?> extends Page<T> {
  AppPage({
    required String name,
    required this.location,
    Object? arguments,
    this.maintainState = true,
    this.fullscreenDialog = false,
    LocalKey? key,
  })  : assert(
          location.toLowerCase().trim() == location,
          'Предполагается, что адрес страницы всегда в нижнем регистре',
        ),
        super(
          name: name,
          arguments: arguments,
          restorationId: location,
          key: key ?? ValueKey<String>(location),
        );

  /// Создать роут из сегмента пути
  static AppPage fromPath({
    required final String location,
    final Object? arguments,
  }) {
    // Предполагаем, что каждый сегмент состоит из имени,
    // описывающий тип роута, а затем, через "-", идут
    // дополнительные, позиционные, параметры, например id
    final segments = location.toLowerCase().split('-');
    final name = segments.firstOrNull?.trim();
    final args = segments.length > 1 ? segments.sublist(1) : const <String>[];
    assert(
      name != null && name.isNotEmpty && name.codeUnits.every((e) => e > 96 && e < 123),
      'Имя должно состоять только из символов латинского алфавита в нижнем регистре: a..z',
    );
    // Тут объявляем все роуты приложения
    switch (name) {
      case '':
      case '/':
      case 'home':
      case 'feed':
        return FeedPage();
      case 'settings':
        return SettingsPage();
      case 'profile':
        return ProfilePage();
      case 'about':
        return AboutPage();
      case 'job':
        return JobPage('job', args.firstOrNull);
      case 'feedback':
        return BugReportPage('feedback');
      case '404':
      default:
        return NotFoundPage();
    }
  }

  /// Сегмент пути со всеми аргументами с которыми создался роут
  /// Например item-red-456
  final String location;

  /// {@macro flutter.widgets.ModalRoute.maintainState}
  final bool maintainState;

  /// {@macro flutter.widgets.PageRoute.fullscreenDialog}
  final bool fullscreenDialog;

  @override
  Route<T> createRoute(BuildContext context) => platform.isWeb
      ? PageRouteBuilder(
          pageBuilder: (context, _, __) => builder(context),
          settings: this,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        )
      : MaterialPageRoute<T>(
          builder: builder,
          settings: this,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );

  Widget builder(BuildContext context);
}

/// Домашний роут
class FeedPage extends AppPage<void> {
  FeedPage()
      : super(
          location: 'feed',
          name: 'feed',
          arguments: null,
        );

  @override
  Widget builder(BuildContext context) => const FeedScreen();
}

/// Роут не найден
class NotFoundPage extends AppPage<void> {
  NotFoundPage()
      : super(
          location: '404',
          name: '404',
          arguments: null,
        );

  @override
  Widget builder(BuildContext context) => const NotFoundScreen();
}

/// Настройки
class SettingsPage extends AppPage<void> {
  SettingsPage()
      : super(
          location: 'settings',
          name: 'settings',
          arguments: null,
        );

  @override
  Widget builder(BuildContext context) => const SettingsScreen();
}

/// Профиль
class ProfilePage extends AppPage<void> {
  ProfilePage()
      : super(
          location: 'profile',
          name: 'profile',
          arguments: null,
        );

  @override
  Widget builder(BuildContext context) => const ProfileScreen();
}

/// Страница описания
class AboutPage extends AppPage<void> {
  AboutPage()
      : super(
          location: 'about',
          name: 'about',
          arguments: null,
        );

  @override
  Widget builder(BuildContext context) => throw UnimplementedError(); // const AboutScreen();
}
