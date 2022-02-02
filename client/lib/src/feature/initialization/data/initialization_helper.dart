// ignore_for_file: long-method

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:dart_jobs_client/src/common/constant/pubspec.yaml.g.dart' as pubspec;
import 'package:dart_jobs_client/src/common/model/app_metadata.dart';
import 'package:dart_jobs_client/src/common/utils/screen_util.dart';
import 'package:dart_jobs_client/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs_client/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs_client/src/feature/bug_report/logic/bug_report_repository.dart';
import 'package:dart_jobs_client/src/feature/cloud_messaging/data/cloud_messaging_service.dart';
import 'package:dart_jobs_client/src/feature/initialization/data/app_migrator.dart';
import 'package:dart_jobs_client/src/feature/initialization/data/graphql_client_creator.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/job/data/job_network_data_provider.dart';
import 'package:dart_jobs_client/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs_client/src/feature/settings/data/settings_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart' show immutable, kIsWeb, kReleaseMode;
import 'package:flutter/widgets.dart' show Orientation;
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializationHelper with _LogSuccessfulInitializedMixin {
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
    try {
      await for (final step in Stream.fromIterable(_initializationSteps.entries)) {
        currentStep++;
        yield InitializationProgressStatus(
          progress: (currentStep * 100 ~/ totalSteps).clamp(0, 100),
          message: step.key,
        );
        initializationProgress = await step.value(initializationProgress);
      }
      final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
      _initializationProgress = initializationProgress;
      // ignore: unawaited_futures
      _logSuccessfulInitialized(
        analytics: _initializationProgress.analytics,
        elapsedMilliseconds: elapsedMilliseconds,
      );
      _isInitialized = true;
    } finally {
      stopwatch
        ..stop()
        ..reset();
    }
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
      final analytics = FirebaseAnalytics.instance;
      newProgress = progress.copyWith(newAnalytics: analytics);
      await analytics.setAnalyticsCollectionEnabled(kReleaseMode);
      await analytics.logAppOpen();
    } on Object {
      newProgress = progress;
    }
    return newProgress;
  },
  'Get remote config': (final progress) async {
    try {
      final config = RemoteConfig.instance;
      await config.setDefaults(<String, Object?>{});
      await config.fetch().timeout(const Duration(seconds: 1));
      config.getAll();
    } on Object catch (error, stackTrace) {
      l.w('Не могу получить RemoteConfig при инициализации: $error', stackTrace);
    }
    return progress;
  },
  'Preparing for authentication': (final progress) => progress.copyWith(
        newAuthenticationRepository: AuthenticationRepository(firebaseAuth: FirebaseAuth.instance),
      ),
  'Creating GraphQL client': (final progress) => progress.copyWith(
        newGQLClient: GraphQLClientCreator.create(),
      ),
  'Preparing main remote storage': (final progress) => progress.copyWith(
        newFirebaseFirestore: FirebaseFirestore.instance,
      ),
  'Initializing local keystore': (final progress) => SharedPreferences.getInstance().then<InitializationProgress>(
        (final sharedPreferences) => progress.copyWith(newSharedPreferences: sharedPreferences),
      ),
  'Adding cloud messaging service': (final progress) => progress.copyWith(
        newCloudMessagingService: CloudMessagingServiceImpl(sharedPreferences: progress.sharedPreferences!),
      ),
  'Create a job repository': (final progress) async {
    final repository = JobRepositoryImpl(
      firebaseAuth: FirebaseAuth.instance,
      firestore: progress.firebaseFirestore!,
      sharedPreferences: progress.sharedPreferences!,
      networkDataProvider: JobNetworkDataProviderImpl(
        client: progress.gqlClient!,
      ),
    );
    await repository.restoreFilter();
    return progress.copyWith(
      newJobRepository: repository,
    );
  },
  'Preparing bug report repository': (final progress) async {
    final repository = BugReportRepository();
    return progress.copyWith(
      newBugReportRepository: repository,
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
  'Migrate app from previous version': (store) async {
    final sharedPrefs = store.sharedPreferences;
    if (sharedPrefs == null) return store;
    await AppMigrator.migrate(sharedPrefs);
    return store;
  },
};

mixin _LogSuccessfulInitializedMixin {
  Future<void> _logSuccessfulInitialized({
    required final FirebaseAnalytics? analytics,
    required final int elapsedMilliseconds,
  }) async {
    final screenSize = ScreenUtil.screenSize();
    await analytics?.logEvent(
      name: 'initialized',
      parameters: <String, Object>{
        'duration': elapsedMilliseconds,
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
    l.i('Инициализация заняла $elapsedMilliseconds мс.');
  }
}
