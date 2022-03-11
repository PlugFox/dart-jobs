import 'package:dart_jobs_client/src/app.dart';
import 'package:dart_jobs_client/src/common/router/pages.dart';
import 'package:dart_jobs_client/src/common/router/router_delegate.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart' as dynamic_links;
import 'package:flutter/foundation.dart' show kReleaseMode, FlutterError;
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';

/// Запуск приложения как io
Future<void> run() async {
  // Собирать логи для Crashlytics в релизе
  // ignore: unawaited_futures
  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(kReleaseMode);
  if (kReleaseMode) {
    // Перехватывать ошибки флатера в релизе
    final sourceFlutterError = FlutterError.onError;
    FlutterError.onError = (final details) {
      FirebaseCrashlytics.instance.recordFlutterError(details);
      sourceFlutterError?.call(details);
    };

    // Все ошибки и предупреждения из логов в крашлитикс
    l
        .where(
          (final msg) => msg.level.maybeWhen<bool>(
            error: () => true,
            warning: () => true,
            orElse: () => false,
          ),
        )
        .map<String>((final msg) => msg.message.toString())
        .listen(FirebaseCrashlytics.instance.log);
  }

  // Инициализировать и запустить приложение
  await App.initializeAndRun(
    onSuccessfulInitialization: (store) async {
      await _checkDynamicLink(store.routerDelegate);
    },
  );
}

Future<void> _checkDynamicLink(AppRouterDelegate routerDelegate) async {
  if (platform.when<bool>(android: () => false, iOS: () => false) ?? true) return;

  // Get any initial links
  await dynamic_links.FirebaseDynamicLinks.instance.getInitialLink().then<void>(
    (initialLink) {
      final location = initialLink?.link.pathSegments.last;
      if (location == null || location.isEmpty) return;
      l.s('Dynamic link: ${initialLink?.link}');
      final page = AppPage.fromPath(location: location);
      if (page is NotFoundPage) return;
      routerDelegate.setNewRoutePath(routerDelegate.currentConfiguration.add(page));
      //FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      //  Navigator.pushNamed(context, dynamicLinkData.link.path);
      //}).onError((error) {
      //  // Handle errors
      //});
    },
  );
}
