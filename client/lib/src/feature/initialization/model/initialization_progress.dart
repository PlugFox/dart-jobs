import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jobs/src/common/model/app_metadata.dart';
import 'package:dart_jobs/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs/src/feature/settings/data/settings_repository.dart';
import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializationProgress {
  final FirebaseAnalytics? analytics;
  final IAuthenticationRepository? authenticationRepository;
  final FirebaseFirestore? firebaseFirestore;
  final SharedPreferences? sharedPreferences;
  final ISettingsRepository? settingsRepository;
  final IJobRepository? jobRepository;
  final AppMetadata? appMetadata;
  final Dio? dio;

  const InitializationProgress({
    this.analytics,
    this.authenticationRepository,
    this.firebaseFirestore,
    this.sharedPreferences,
    this.settingsRepository,
    this.jobRepository,
    this.appMetadata,
    this.dio,
  });

  @factory
  // ignore: long-parameter-list
  InitializationProgress copyWith({
    final FirebaseAnalytics? newAnalytics,
    final IAuthenticationRepository? newAuthenticationRepository,
    final FirebaseFirestore? newFirebaseFirestore,
    final SharedPreferences? newSharedPreferences,
    final ISettingsRepository? newSettingsRepository,
    final IJobRepository? newJobRepository,
    final AppMetadata? newAppMetadata,
    final Dio? newDio,
  }) =>
      InitializationProgress(
        analytics: newAnalytics ?? analytics,
        authenticationRepository: newAuthenticationRepository ?? authenticationRepository,
        firebaseFirestore: newFirebaseFirestore ?? firebaseFirestore,
        sharedPreferences: newSharedPreferences ?? sharedPreferences,
        settingsRepository: newSettingsRepository ?? settingsRepository,
        jobRepository: newJobRepository ?? jobRepository,
        appMetadata: newAppMetadata ?? appMetadata,
        dio: newDio ?? dio,
      );

  @factory
  RepositoryStore getResult() => RepositoryStore._(
        analytics: analytics,
        authenticationRepository: authenticationRepository!,
        firebaseFirestore: firebaseFirestore!,
        settingsRepository: settingsRepository!,
        jobRepository: jobRepository!,
        appMetadata: appMetadata,
      );
}

@immutable
class RepositoryStore {
  final FirebaseAnalytics? analytics;
  final IAuthenticationRepository authenticationRepository;
  final FirebaseFirestore firebaseFirestore;
  final ISettingsRepository settingsRepository;
  final IJobRepository jobRepository;
  final AppMetadata? appMetadata;

  const RepositoryStore._({
    required this.analytics,
    required this.authenticationRepository,
    required this.firebaseFirestore,
    required this.settingsRepository,
    required this.jobRepository,
    required this.appMetadata,
  });
}
