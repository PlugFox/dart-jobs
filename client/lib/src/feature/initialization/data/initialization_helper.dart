// ignore_for_file: long-method

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dart_jobs/src/common/constant/pubspec.yaml.g.dart' as pubspec;
import 'package:dart_jobs/src/common/constant/storage_namespace.dart';
import 'package:dart_jobs/src/common/model/app_metadata.dart';
import 'package:dart_jobs/src/common/utils/screen_util.dart';
import 'package:dart_jobs/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:dart_jobs/src/feature/job/data/job_network_data_provider.dart';
import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs/src/feature/settings/data/settings_repository.dart';
import 'package:dart_jobs_shared/grpc.dart' as grpc;
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable, kIsWeb, kReleaseMode;
import 'package:flutter/widgets.dart' show Orientation;
import 'package:grpc/grpc_or_grpcweb.dart' as grpc;
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializationHelper {
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  bool get isNotInitialized => !isInitialized;

  InitializationProgress _initializationProgress = const InitializationProgress();

  void reset() {
    _isInitialized = false;
    _initializationProgress = const InitializationProgress();
  }

  RepositoryStore getResult() => _initializationProgress.getResult();

  Stream<InitializationProgressStatus> initialize() async* {
    _isInitialized = false;
    final totalSteps = _initializationSteps.length;
    var currentStep = 0;
    var initializationProgress = _initializationProgress;
    final stopwatch = Stopwatch()..start();
    await for (final step in Stream.fromIterable(_initializationSteps.entries)) {
      currentStep++;
      yield InitializationProgressStatus(
        progress: (currentStep * 100 ~/ totalSteps).clamp(0, 100),
        message: step.key,
      );
      initializationProgress = await step.value(initializationProgress);
    }
    final result = stopwatch.elapsedMilliseconds;
    _initializationProgress = initializationProgress;
    final screenSize = ScreenUtil.screenSize();
    // ignore: unawaited_futures
    _initializationProgress.analytics?.logEvent(
      name: 'initialized',
      parameters: <String, Object>{
        'duration': result,
        'version': pubspec.version,
        'version_major_minor': pubspec.major + (pubspec.minor / 100),
        'screen_size': screenSize.representation,
        'screen_size_min': screenSize.min,
        'screen_size_max': screenSize.max,
        'orientation': ScreenUtil.orientation() == Orientation.landscape ? 'landscape' : 'portrait',
        'locale': platform.locale,
        'platform': platform.isWeb ? 'web' : 'io',
        'mobile_desktop': platform.when<String>(
              desktop: () => 'desktop',
              mobile: () => 'mobile',
            ) ??
            'unknown',
        'operating_system': platform.operatingSystem.when<String>(
          android: () => 'android',
          fuchsia: () => 'fuchsia',
          iOS: () => 'ios',
          linux: () => 'linux',
          macOS: () => 'macos',
          windows: () => 'windows',
          unknown: () => 'unknown',
        ),
        'build_mode': platform.when<String>(
              release: () => 'release',
              debug: () => 'debug',
              profile: () => 'profile',
            ) ??
            'release',
      },
    );
    l.i('Инициализация заняла $result мс.');
    stopwatch
      ..stop()
      ..reset();
    _isInitialized = true;
  }
}

@immutable
class InitializationProgressStatus {
  final int progress;
  final String message;
  const InitializationProgressStatus({
    required this.progress,
    required this.message,
  });
}

final Map<String, FutureOr<InitializationProgress> Function(InitializationProgress progress)> _initializationSteps =
    <String, FutureOr<InitializationProgress> Function(InitializationProgress progress)>{
  'Initializing analytics': (final progress) async {
    InitializationProgress newProgress;
    try {
      final analytics = FirebaseAnalytics();
      newProgress = progress.copyWith(newAnalytics: analytics);
      await analytics.setAnalyticsCollectionEnabled(kReleaseMode);
      await analytics.logAppOpen();
    } on Object {
      newProgress = progress;
    }
    return newProgress;
  },
  'Preparing for authentication': (final progress) => progress.copyWith(
        newAuthenticationRepository: AuthenticationRepository(firebaseAuth: FirebaseAuth.instance),
      ),
  'Preparing main remote storage': (final progress) => progress.copyWith(
        newFirebaseFirestore: FirebaseFirestore.instance,
      ),
  'Initializing local keystore': (final progress) => SharedPreferences.getInstance().then<InitializationProgress>(
        (final sharedPreferences) => progress.copyWith(newSharedPreferences: sharedPreferences),
      ),
  /*
  'Settings client channel': (final progress) => progress.copyWith(
        /// TODO: эндпоинты и secure
        newClientChannel: grpc.GrpcOrGrpcWebClientChannel.grpc(
          'jobs.api.plugfox.dev',
          port: 443,
          options: ChannelOptions(
            credentials: ChannelCredentials.secure(
              certificates: utf8.encode(grpcCertificate),
            ),
            idleTimeout: const Duration(minutes: 2),
            connectionTimeout: const Duration(minutes: 25),
            userAgent: 'dart-grpc/${platform.isWeb ? 'web' : 'io'}/${platform.operatingSystem.when(
              android: () => 'android',
              fuchsia: () => 'fuchsia',
              iOS: () => 'iOS',
              linux: () => 'linux',
              macOS: () => 'macOS',
              windows: () => 'windows',
              unknown: () => 'unknown',
            )}',
            codecRegistry: CodecRegistry(
              codecs: const <Codec>[
                GzipCodec(),
                IdentityCodec(),
              ],
            ),
          ),
        ),
      ),
  */
  /*
  'Making client transport': (final progress) => progress.copyWith(
        newClientChannel: grpc.GrpcOrGrpcWebClientChannel.toSingleEndpoint(
          host: 'jobs.api.plugfox.dev',
          port: 443,
          transportSecure: true,
        ),
      ),
  */
  'Create a job repository': (final progress) {
    final clientChannel = grpc.GrpcOrGrpcWebClientChannel.toSingleEndpoint(
      host: 'localhost', // 'jobs.api.plugfox.dev',
      port: 9090,
      transportSecure: false,
    );
    return progress.copyWith(
      newJobRepository: JobRepositoryImpl(
        firebaseAuth: FirebaseAuth.instance,
        networkDataProvider: JobNetworkDataProviderImpl(
          client: grpc.JobServiceClient(
            clientChannel,
            options: grpc.CallOptions(
              //compression: const GzipCodec(),
              timeout: const Duration(minutes: 2),
            ),
            //interceptors: <grpc.ClientInterceptor>[],
          ),
        ),
      ),
    );
  },
  'Get current settings': (final progress) async {
    final repository = SettingsRepository(
      sharedPreferences: progress.sharedPreferences!,
      firestore: progress.firebaseFirestore!,
    );
    // Если юзер уже доступен - получим актуальные настройки
    // в противном случае получим настройки из кэша
    final user = progress.authenticationRepository?.currentUser ?? const UserEntity.notAuthenticated();
    if (user.isNotAuthenticated) {
      repository.getFromCache();
    } else {
      try {
        await repository.getFromServer(user);
      } on Object {
        repository.getFromCache();
      }
    }
    return progress.copyWith(newSettingsRepository: repository);
  },
  'Checking the application version': (final store) async {
    try {
      final build = int.tryParse(pubspec.build.first);
      final sharedPrefs = store.sharedPreferences;
      if (sharedPrefs == null) return store;
      if (build != null) {
        await Future.wait<void>(
          <Future<void>>[
            sharedPrefs.setInt(versionMajorKey, pubspec.major),
            sharedPrefs.setInt(versionMinorKey, pubspec.minor),
            sharedPrefs.setInt(versionPatchKey, pubspec.patch),
            sharedPrefs.setInt(versionBuildKey, build),
          ],
        );
      } else {
        await Future.wait<void>(
          <Future<void>>[
            sharedPrefs.remove(versionMajorKey),
            sharedPrefs.remove(versionMinorKey),
            sharedPrefs.remove(versionPatchKey),
            sharedPrefs.remove(versionBuildKey),
          ],
        );
      }
    } on Object {
      l.e('Ошибка миграции приложения');
      rethrow;
    }
    return store;
  },
  'Creating app metadata': (final store) async {
    final screenSize = ScreenUtil.screenSize();
    final appMetadata = AppMetadata(
      isWeb: kIsWeb,
      isRelease: platform.buildMode.isRelease,
      appVersion: pubspec.version,
      appVersionMajor: pubspec.major,
      appVersionMinor: pubspec.minor,
      appVersionPatch: pubspec.patch,
      appBuildTimestamp: pubspec.build.isNotEmpty ? (int.tryParse(pubspec.build.firstOrNull ?? '-1') ?? -1) : -1,
      appPackageName: 'dart_jobs',
      appName: 'Dart Jobs',
      // deviceInfo.appName,
      operatingSystem: platform.when<String>(
            android: () => 'Android',
            iOS: () => 'iOS',
            macOS: () => 'macOS',
            windows: () => 'Windows',
            fuchsia: () => 'Fuchsia',
            linux: () => 'Linux',
          ) ??
          'Other',
      processorsCount: platform.numberOfProcessors,
      appLaunchedTimestamp: DateTime.now().millisecondsSinceEpoch,
      locale: platform.locale,

      deviceRepresentation: screenSize.representation,
      deviceLogicalSideMin: screenSize.min,
      deviceLogicalSideMax: screenSize.max,
    );
    return store.copyWith(newAppMetadata: appMetadata);
  },
};

/// TODO: переместить в константы
/// Сертификат для lets'e encrypt
/// Взял с `https://letsencrypt.org/certs/lets-encrypt-r3.pem`
const String grpcCertificate = '''
-----BEGIN CERTIFICATE-----
MIIFFjCCAv6gAwIBAgIRAJErCErPDBinU/bWLiWnX1owDQYJKoZIhvcNAQELBQAw
TzELMAkGA1UEBhMCVVMxKTAnBgNVBAoTIEludGVybmV0IFNlY3VyaXR5IFJlc2Vh
cmNoIEdyb3VwMRUwEwYDVQQDEwxJU1JHIFJvb3QgWDEwHhcNMjAwOTA0MDAwMDAw
WhcNMjUwOTE1MTYwMDAwWjAyMQswCQYDVQQGEwJVUzEWMBQGA1UEChMNTGV0J3Mg
RW5jcnlwdDELMAkGA1UEAxMCUjMwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEK
AoIBAQC7AhUozPaglNMPEuyNVZLD+ILxmaZ6QoinXSaqtSu5xUyxr45r+XXIo9cP
R5QUVTVXjJ6oojkZ9YI8QqlObvU7wy7bjcCwXPNZOOftz2nwWgsbvsCUJCWH+jdx
sxPnHKzhm+/b5DtFUkWWqcFTzjTIUu61ru2P3mBw4qVUq7ZtDpelQDRrK9O8Zutm
NHz6a4uPVymZ+DAXXbpyb/uBxa3Shlg9F8fnCbvxK/eG3MHacV3URuPMrSXBiLxg
Z3Vms/EY96Jc5lP/Ooi2R6X/ExjqmAl3P51T+c8B5fWmcBcUr2Ok/5mzk53cU6cG
/kiFHaFpriV1uxPMUgP17VGhi9sVAgMBAAGjggEIMIIBBDAOBgNVHQ8BAf8EBAMC
AYYwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMBMBIGA1UdEwEB/wQIMAYB
Af8CAQAwHQYDVR0OBBYEFBQusxe3WFbLrlAJQOYfr52LFMLGMB8GA1UdIwQYMBaA
FHm0WeZ7tuXkAXOACIjIGlj26ZtuMDIGCCsGAQUFBwEBBCYwJDAiBggrBgEFBQcw
AoYWaHR0cDovL3gxLmkubGVuY3Iub3JnLzAnBgNVHR8EIDAeMBygGqAYhhZodHRw
Oi8veDEuYy5sZW5jci5vcmcvMCIGA1UdIAQbMBkwCAYGZ4EMAQIBMA0GCysGAQQB
gt8TAQEBMA0GCSqGSIb3DQEBCwUAA4ICAQCFyk5HPqP3hUSFvNVneLKYY611TR6W
PTNlclQtgaDqw+34IL9fzLdwALduO/ZelN7kIJ+m74uyA+eitRY8kc607TkC53wl
ikfmZW4/RvTZ8M6UK+5UzhK8jCdLuMGYL6KvzXGRSgi3yLgjewQtCPkIVz6D2QQz
CkcheAmCJ8MqyJu5zlzyZMjAvnnAT45tRAxekrsu94sQ4egdRCnbWSDtY7kh+BIm
lJNXoB1lBMEKIq4QDUOXoRgffuDghje1WrG9ML+Hbisq/yFOGwXD9RiX8F6sw6W4
avAuvDszue5L3sz85K+EC4Y/wFVDNvZo4TYXao6Z0f+lQKc0t8DQYzk1OXVu8rp2
yJMC6alLbBfODALZvYH7n7do1AZls4I9d1P4jnkDrQoxB3UqQ9hVl3LEKQ73xF1O
yK5GhDDX8oVfGKF5u+decIsH4YaTw7mP3GFxJSqv3+0lUFJoi5Lc5da149p90Ids
hCExroL1+7mryIkXPeFM5TgO9r0rvZaBFOvV2z0gp35Z0+L4WPlbuEjN/lxPFin+
HlUjr8gRsI3qfJOQFy/9rKIJR0Y/8Omwt/8oTWgy1mdeHmmjk7j1nYsvC9JSQ6Zv
MldlTTKB3zhThV1+XWYp6rjd5JW1zbVWEkLNxE7GJThEUG3szgBVGP7pSWTUTsqX
nLRbwHOoq7hHwg==
-----END CERTIFICATE-----
''';
