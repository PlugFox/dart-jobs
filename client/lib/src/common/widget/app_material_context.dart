import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/configuration.dart';
import 'package:dart_jobs_client/src/common/router/information_parser.dart';
import 'package:dart_jobs_client/src/common/router/information_provider.dart';
import 'package:dart_jobs_client/src/common/router/router_delegate.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

@immutable
class AppMaterialContext extends StatefulWidget {
  const AppMaterialContext({
    final Key? key,
  }) : super(key: key);

  @override
  State<AppMaterialContext> createState() => _AppMaterialContextState();
}

class _AppMaterialContextState extends State<AppMaterialContext> {
  final RouteInformationParser<IRouteConfiguration> _routeInformationParser = const AppRouteInformationParser();
  final AppInformationProvider _routeInformationProvider = AppInformationProvider();
  final AppRouterDelegate _routerDelegate = AppRouterDelegate();

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
      debugShowCheckedModeBanner: false,
      theme: themeData,
      onGenerateTitle: (final context) => context.localization.title,
      restorationScopeId: 'app',
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
