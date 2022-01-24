import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/feature/browser_capabilities/models/browser_capabilities_data.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

@immutable
class BrowserCapabilities extends StatefulWidget {
  final Widget child;

  const BrowserCapabilities({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// Find BrowserCapabilitiesData in BuildContext
  static BrowserCapabilitiesData? of(BuildContext context) {
    final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedBrowserCapabilities>()?.widget;
    return inheritedWidget is _InheritedBrowserCapabilities ? inheritedWidget.data : null;
  }

  @override
  State<BrowserCapabilities> createState() => _BrowserCapabilitiesState();
}

class _BrowserCapabilitiesState extends State<BrowserCapabilities> {
  final BrowserCapabilitiesData _browserCapabilitiesData = BrowserCapabilitiesData();

  //region Lifecycle
  @override
  // ignore: long-method
  void initState() {
    super.initState();
    if (_browserCapabilitiesData.isBrowser &&
        (!_browserCapabilitiesData.serviceWorkerSupported || !_browserCapabilitiesData.supportedPWA)) {
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        showDialog<void>(
          builder: (context) => Dialog(
            child: SizedBox(
              height: 270,
              width: 270,
              child: Scaffold(
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Ограниченный функционал',
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 25),
                        Text(
                          'Этот браузер обладает ограниченным функционалом.\n\n'
                          '${_browserCapabilitiesData.isChrome ? 'Обновите' : 'Скачайте'} Chrome для всех возможностей.',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const Spacer(),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              height: 50,
                              width: 110,
                              child: TextButton(
                                onPressed: () {
                                  AppRouter.pop(context);
                                  launcher.launch('https://www.google.com/intl/ru_ru/chrome/');
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                child: Center(
                                  child: Text(
                                    'Скачать',
                                    style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              width: 110,
                              child: TextButton(
                                onPressed: () => AppRouter.pop(context),
                                child: Center(
                                  child: Text(
                                    'Закрыть',
                                    style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.red),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          context: context,
          useRootNavigator: true,
        );
      });
    }
  }

  //endregion

  @override
  Widget build(BuildContext context) => _InheritedBrowserCapabilities(
        data: _browserCapabilitiesData,
        child: widget.child,
      );
}

@immutable
class _InheritedBrowserCapabilities extends InheritedWidget {
  final BrowserCapabilitiesData data;

  const _InheritedBrowserCapabilities({
    required this.data,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedBrowserCapabilities oldWidget) => false;
}
