import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jobs/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs/src/feature/feed/data/feed_repository.dart';
import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs/src/feature/settings/data/settings_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializationProgress {
  final FirebaseAnalytics? analytics;
  final IAuthenticationRepository? authenticationRepository;
  final FirebaseFirestore? firebaseFirestore;
  final SharedPreferences? sharedPreferences;
  final ISettingsRepository? settingsRepository;
  final IFeedRepository? feedRepository;
  final IJobRepository? jobRepository;

  const InitializationProgress({
    this.analytics,
    this.authenticationRepository,
    this.firebaseFirestore,
    this.sharedPreferences,
    this.settingsRepository,
    this.feedRepository,
    this.jobRepository,
  });

  @factory
  // ignore: long-parameter-list
  InitializationProgress copyWith({
    final FirebaseAnalytics? newAnalytics,
    final IAuthenticationRepository? newAuthenticationRepository,
    final FirebaseFirestore? newFirebaseFirestore,
    final SharedPreferences? newSharedPreferences,
    final ISettingsRepository? newSettingsRepository,
    final IFeedRepository? newFeedRepository,
    final IJobRepository? newJobRepository,
  }) =>
      InitializationProgress(
        analytics: newAnalytics ?? analytics,
        authenticationRepository: newAuthenticationRepository ?? authenticationRepository,
        firebaseFirestore: newFirebaseFirestore ?? firebaseFirestore,
        sharedPreferences: newSharedPreferences ?? sharedPreferences,
        settingsRepository: newSettingsRepository ?? settingsRepository,
        feedRepository: newFeedRepository ?? feedRepository,
        jobRepository: newJobRepository ?? jobRepository,
      );

  @factory
  RepositoryStore getResult() => RepositoryStore._(
        analytics: analytics,
        authenticationRepository: authenticationRepository!,
        firebaseFirestore: firebaseFirestore!,
        sharedPreferences: sharedPreferences!,
        settingsRepository: settingsRepository!,
        feedRepository: feedRepository!,
        jobRepository: jobRepository!,
      );
}

@immutable
class RepositoryStore {
  final FirebaseAnalytics? analytics;
  final IAuthenticationRepository authenticationRepository;
  final FirebaseFirestore firebaseFirestore;
  final SharedPreferences sharedPreferences;
  final ISettingsRepository settingsRepository;
  final IFeedRepository feedRepository;
  final IJobRepository jobRepository;

  const RepositoryStore._({
    required this.analytics,
    required this.authenticationRepository,
    required this.firebaseFirestore,
    required this.sharedPreferences,
    required this.settingsRepository,
    required this.feedRepository,
    required this.jobRepository,
  });
}
