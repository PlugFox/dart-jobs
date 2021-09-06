import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../../feature/settings/widget/settings_scope.dart';
import '../localization/localizations.dart';
import '../router/initial_route_configuration.dart';
import '../router/route_information_parser.dart';
import '../router/route_information_provider.dart';
import '../router/router_delegate.dart';

@immutable
class AppMaterialContext extends StatefulWidget {
  const AppMaterialContext({
    Key? key,
  }) : super(key: key);

  /// Для поиска _GlobalMaterialContextState в контексте
  static _AppMaterialContextState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppMaterialContextState>();

  @override
  State<AppMaterialContext> createState() => _AppMaterialContextState();
}

class _AppMaterialContextState extends State<AppMaterialContext> {
  final AppRouteInformationParser _routeInformationParser = AppRouteInformationParser();
  final AppRouteInformationProvider _routeInformationProvider = AppRouteInformationProvider(
    initialRouteInformation: InitialRouteConfiguration.instance().routeInformation,
  );
  final AppRouterDelegate _routerDelegate = AppRouterDelegate(
    initialConfiguration: InitialRouteConfiguration.instance().routeConfiguration,
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
  Widget build(BuildContext context) {
    final currentLocale = SettingsScope.localeOf(context);
    final themeData = SettingsScope.themeOf(context);
    return MaterialApp.router(
      color: Colors.blue,
      theme: themeData,
      onGenerateTitle: (context) => context.localization.title,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      routeInformationProvider: _routeInformationProvider,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
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
