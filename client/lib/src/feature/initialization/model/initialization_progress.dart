import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jobs/src/common/model/app_metadata.dart';
import 'package:dart_jobs/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs/src/feature/settings/data/settings_repository.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:grpc/grpc.dart' as grpc;
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitializationProgress {
  final FirebaseAnalytics? analytics;
  final IAuthenticationRepository? authenticationRepository;
  final FirebaseFirestore? firebaseFirestore;
  final SharedPreferences? sharedPreferences;
  final ISettingsRepository? settingsRepository;
  final grpc.ClientChannel? clientChannel;
  final IJobRepository? jobRepository;
  final AppMetadata? appMetadata;

  const InitializationProgress({
    this.analytics,
    this.authenticationRepository,
    this.firebaseFirestore,
    this.sharedPreferences,
    this.settingsRepository,
    this.clientChannel,
    this.jobRepository,
    this.appMetadata,
  });

  @factory
  // ignore: long-parameter-list
  InitializationProgress copyWith({
    final FirebaseAnalytics? newAnalytics,
    final IAuthenticationRepository? newAuthenticationRepository,
    final FirebaseFirestore? newFirebaseFirestore,
    final SharedPreferences? newSharedPreferences,
    final ISettingsRepository? newSettingsRepository,
    final grpc.ClientChannel? newClientChannel,
    final IJobRepository? newJobRepository,
    final AppMetadata? newAppMetadata,
  }) =>
      InitializationProgress(
        analytics: newAnalytics ?? analytics,
        authenticationRepository: newAuthenticationRepository ?? authenticationRepository,
        firebaseFirestore: newFirebaseFirestore ?? firebaseFirestore,
        sharedPreferences: newSharedPreferences ?? sharedPreferences,
        settingsRepository: newSettingsRepository ?? settingsRepository,
        clientChannel: newClientChannel ?? clientChannel,
        jobRepository: newJobRepository ?? jobRepository,
        appMetadata: newAppMetadata ?? appMetadata,
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
