import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../authentication/data/authentication_repository.dart';
import '../../settings/data/settings_repository.dart';

class InitializationProgress {
  final FirebaseAnalytics? analytics;
  final IAuthenticationRepository? authenticationRepository;
  final FirebaseFirestore? firebaseFirestore;
  final SharedPreferences? sharedPreferences;
  final ISettingsRepository? settingsRepository;

  const InitializationProgress({
    this.analytics,
    this.authenticationRepository,
    this.firebaseFirestore,
    this.sharedPreferences,
    this.settingsRepository,
  });

  @factory
  // ignore: long-parameter-list
  InitializationProgress copyWith({
    FirebaseAnalytics? newAnalytics,
    IAuthenticationRepository? newAuthenticationRepository,
    FirebaseFirestore? newFirebaseFirestore,
    SharedPreferences? newSharedPreferences,
    ISettingsRepository? newSettingsRepository,
  }) =>
      InitializationProgress(
        analytics: newAnalytics ?? analytics,
        authenticationRepository: newAuthenticationRepository ?? authenticationRepository,
        firebaseFirestore: newFirebaseFirestore ?? firebaseFirestore,
        sharedPreferences: newSharedPreferences ?? sharedPreferences,
        settingsRepository: newSettingsRepository ?? settingsRepository,
      );

  @factory
  RepositoryStore getResult() => RepositoryStore._(
        analytics: analytics!,
        authenticationRepository: authenticationRepository!,
        firebaseFirestore: firebaseFirestore!,
        sharedPreferences: sharedPreferences!,
        settingsRepository: settingsRepository!,
      );
}

@immutable
class RepositoryStore {
  final FirebaseAnalytics analytics;
  final IAuthenticationRepository authenticationRepository;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences sharedPreferences;
  final ISettingsRepository settingsRepository;

  const RepositoryStore._({
    required this.analytics,
    required this.authenticationRepository,
    required this.firebaseFirestore,
    required this.sharedPreferences,
    required this.settingsRepository,
  });
}
