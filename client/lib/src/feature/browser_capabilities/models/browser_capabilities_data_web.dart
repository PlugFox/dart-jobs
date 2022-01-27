import 'dart:html' as html;

import 'package:dart_jobs_client/src/feature/browser_capabilities/models/browser_capabilities_data.dart';
import 'package:platform_detect/platform_detect.dart';

BrowserCapabilitiesData getBrowserCapabilitiesData() {
  final window = html.window;
  final navigator = html.window.navigator;

  // Высчитаем запущено ли как PWA
  var standalone = false;
  if (window.matchMedia('(display-mode: standalone)').matches) {
    // PWA
    standalone = true;
  } else if (html.document.referrer.startsWith('android-app://')) {
    // TWA
    standalone = true;
  } else {
    // Browser
    standalone = false;
  }

  // Высчитаем поддержку PWA
  var supportedPWA = standalone;
  if (browser.isChrome && browser.version.major >= 39) {
    supportedPWA = true;
  } else if (browser.isSafari && browser.version.major >= 12) {
    supportedPWA = true;
  }

  return BrowserCapabilitiesDataWeb._(
    browserName: browser.name,
    browserVersion: browser.version.toString(),
    isSafari: browser.isSafari,
    isInternetExplorer: browser.isInternetExplorer,
    isFirefox: browser.isFirefox,
    isWKWebView: browser.isWKWebView,
    isChrome: browser.isChrome,
    serviceWorkerSupported: navigator.serviceWorker != null,
    cacheSupported: window.caches != null,
    storageSupported: navigator.storage != null,
    indexedDbSupported: window.indexedDB != null,
    standalone: standalone,
    supportedPWA: supportedPWA,
  );
}

class BrowserCapabilitiesDataWeb implements BrowserCapabilitiesData {
  @override
  bool get isBrowser => true;

  @override
  final String browserName;

  @override
  final String browserVersion;

  @override
  final bool isChrome;

  @override
  final bool isFirefox;

  @override
  final bool isInternetExplorer;

  @override
  final bool isSafari;

  @override
  final bool isWKWebView;

  @override
  final bool serviceWorkerSupported;

  @override
  final bool cacheSupported;

  @override
  final bool storageSupported;

  @override
  final bool indexedDbSupported;

  @override
  final bool standalone;

  @override
  final bool supportedPWA;

  BrowserCapabilitiesDataWeb._({
    required this.browserName,
    required this.browserVersion,
    required this.isChrome,
    required this.isFirefox,
    required this.isInternetExplorer,
    required this.isSafari,
    required this.isWKWebView,
    required this.serviceWorkerSupported,
    required this.cacheSupported,
    required this.storageSupported,
    required this.indexedDbSupported,
    required this.standalone,
    required this.supportedPWA,
  });

  @override
  WhenResult when<WhenResult>({
    required WhenResult Function() web,
    required WhenResult Function() io,
  }) =>
      web();
}
