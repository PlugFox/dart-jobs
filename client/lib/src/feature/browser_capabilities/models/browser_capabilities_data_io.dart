import 'package:dart_jobs_client/src/feature/browser_capabilities/models/browser_capabilities_data.dart';
import 'package:meta/meta.dart';

BrowserCapabilitiesData getBrowserCapabilitiesData() => const BrowserCapabilitiesDataIO._();

class BrowserCapabilitiesDataIO implements BrowserCapabilitiesData {
  @override
  bool get isBrowser => false;

  @override
  String get browserName => 'Не браузер';

  @override
  String get browserVersion => '0.0.0+0-0';

  @override
  bool get isChrome => false;

  @override
  bool get isFirefox => false;

  @override
  bool get isInternetExplorer => false;

  @override
  bool get isSafari => false;

  @override
  bool get isWKWebView => false;

  @override
  bool get serviceWorkerSupported => false;

  @override
  bool get cacheSupported => false;

  @override
  bool get storageSupported => false;

  @override
  bool get indexedDbSupported => false;

  @override
  bool get standalone => true;

  @override
  bool get supportedPWA => true;

  @literal
  const BrowserCapabilitiesDataIO._();

  @override
  WhenResult when<WhenResult>({
    required WhenResult Function() web,
    required WhenResult Function() io,
  }) =>
      io();
}
