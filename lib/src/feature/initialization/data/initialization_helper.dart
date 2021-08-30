import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kReleaseMode;
import 'package:flutter/widgets.dart' show Orientation;
import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:platform_info/platform_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/constant/pubspec.yaml.g.dart' as pubspec;
import '../../../common/utils/screen_util.dart';
import '../../authentication/data/authentication_repository.dart';
import '../../authentication/model/user_entity.dart';
import '../../settings/data/settings_repository.dart';
import '../model/initialization_progress.dart';

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
    // ignore: unawaited_futures
    _initializationProgress.analytics?.logEvent(
      name: 'initialized',
      parameters: <String, Object>{
        'duration': result,
        'version': pubspec.version,
        'version_major': pubspec.major,
        'screen_size': ScreenUtil.screenSize().representation,
        'orientation': ScreenUtil.orientation() == Orientation.landscape ? 'landscape' : 'portrait',
        'locale': platform.locale,
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

final Map<String, FutureOr<InitializationProgress> Function(InitializationProgress progress)> _initializationSteps = {
  'Initializing analytics': (progress) async {
    final analytics = FirebaseAnalytics();
    await analytics.setAnalyticsCollectionEnabled(kReleaseMode);
    await analytics.logAppOpen();
    return progress.copyWith(newAnalytics: analytics);
  },
  'Preparing for authentication': (progress) => progress.copyWith(
        newAuthenticationRepository: AuthenticationRepository(firebaseAuth: FirebaseAuth.instance),
      ),
  'Preparing main remote storage': (progress) => progress.copyWith(
        newFirebaseFirestore: FirebaseFirestore.instance,
      ),
  'Initializing local keystore': (progress) => SharedPreferences.getInstance().then<InitializationProgress>(
        (sharedPreferences) => progress.copyWith(newSharedPreferences: sharedPreferences),
      ),
  'Get current settings': (progress) async {
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
};
