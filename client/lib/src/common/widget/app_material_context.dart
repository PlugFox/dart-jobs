import 'package:dart_jobs/src/common/localization/localizations.dart';
import 'package:dart_jobs/src/common/router/configuration.dart';
import 'package:dart_jobs/src/common/router/route_information_parser.dart';
import 'package:dart_jobs/src/common/router/route_information_provider.dart';
import 'package:dart_jobs/src/common/router/router_delegate.dart';
import 'package:dart_jobs/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@immutable
class AppMaterialContext extends StatefulWidget {
  const AppMaterialContext({
    final Key? key,
  }) : super(key: key);

  /// Для поиска _GlobalMaterialContextState в контексте
  static _AppMaterialContextState? of(final BuildContext context) =>
      context.findAncestorStateOfType<_AppMaterialContextState>();

  @override
  State<AppMaterialContext> createState() => _AppMaterialContextState();
}

class _AppMaterialContextState extends State<AppMaterialContext> {
  final PageInformationParser _routeInformationParser = const PageInformationParser();
  final PageInformationProvider _routeInformationProvider = PageInformationProvider(
    initialRouteInformation: const RouteInformation(
      location: '/',
    ),
  );
  final PageRouterDelegate _routerDelegate = PageRouterDelegate(
    initialConfiguration: const FeedPageConfiguration(),
  );

  @override
  void initState() {
    super.initState();
    //final repoStore = InitializationScope.storeOf(context);
  }

  @override
  void dispose() {
    _routeInformationProvider.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    final currentLocale = SettingsScope.localeOf(context);
    final themeData = SettingsScope.themeOf(context);
    return MaterialApp.router(
      color: Colors.blue,
      theme: themeData,
      onGenerateTitle: (final context) => context.localization.title,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      routeInformationProvider: _routeInformationProvider,
      localeResolutionCallback: (final deviceLocale, final supportedLocales) {
        for (final locale in supportedLocales) {
          if (locale.languageCode == currentLocale.languageCode) {
            return currentLocale;
          }
        }
        for (final locale in supportedLocales) {
          if (deviceLocale == locale) {
            return deviceLocale;
          }
        }
        return AppLocalization.fallbackLocale;
      },
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: context.supportedLocales,
      locale: currentLocale,
    );
  }
}
