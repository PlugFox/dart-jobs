import 'package:dart_jobs_client/src/feature/browser_capabilities/models/browser_capabilities_data_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/src/feature/browser_capabilities/data/models/browser_capabilities_data_web.dart';

abstract class BrowserCapabilitiesData {
  bool get isBrowser;

  String get browserName;

  String get browserVersion;

  bool get isChrome;

  bool get isFirefox;

  bool get isInternetExplorer;

  bool get isSafari;

  bool get isWKWebView;

  bool get serviceWorkerSupported;

  bool get cacheSupported;

  bool get storageSupported;

  bool get supportedPWA;

  /// Поддержка Indexed DB
  bool get indexedDbSupported;

  /// Запущено в режиме PWA или TWA
  bool get standalone;

  WhenResult when<WhenResult>({
    required WhenResult Function() web,
    required WhenResult Function() io,
  });

  factory BrowserCapabilitiesData() => getBrowserCapabilitiesData();
}
