import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jobs_client/src/common/model/app_metadata.dart';
import 'package:dart_jobs_client/src/feature/authentication/data/authentication_repository.dart';
import 'package:dart_jobs_client/src/feature/bug_report/logic/bug_report_repository.dart';
import 'package:dart_jobs_client/src/feature/job/data/job_repository.dart';
import 'package:dart_jobs_client/src/feature/settings/data/settings_repository.dart';
import 'package:dart_jobs_shared/graphql.dart';
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
  final IBugReportRepository? bugReportRepository;
  final AppMetadata? appMetadata;
  final GQLClient? gqlClient;

  const InitializationProgress({
    this.analytics,
    this.authenticationRepository,
    this.firebaseFirestore,
    this.sharedPreferences,
    this.settingsRepository,
    this.jobRepository,
    this.bugReportRepository,
    this.appMetadata,
    this.gqlClient,
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
    final IBugReportRepository? newBugReportRepository,
    final AppMetadata? newAppMetadata,
    final GQLClient? newGQLClient,
  }) =>
      InitializationProgress(
        analytics: newAnalytics ?? analytics,
        authenticationRepository: newAuthenticationRepository ?? authenticationRepository,
        firebaseFirestore: newFirebaseFirestore ?? firebaseFirestore,
        sharedPreferences: newSharedPreferences ?? sharedPreferences,
        settingsRepository: newSettingsRepository ?? settingsRepository,
        jobRepository: newJobRepository ?? jobRepository,
        appMetadata: newAppMetadata ?? appMetadata,
        bugReportRepository: newBugReportRepository ?? bugReportRepository,
        gqlClient: newGQLClient ?? gqlClient,
      );

  @factory
  RepositoryStore getResult() => RepositoryStore._(
        analytics: analytics,
        authenticationRepository: authenticationRepository!,
        firebaseFirestore: firebaseFirestore!,
        settingsRepository: settingsRepository!,
        jobRepository: jobRepository!,
        bugReportRepository: bugReportRepository!,
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
  final IBugReportRepository bugReportRepository;
  final AppMetadata? appMetadata;

  const RepositoryStore._({
    required this.analytics,
    required this.authenticationRepository,
    required this.firebaseFirestore,
    required this.settingsRepository,
    required this.jobRepository,
    required this.bugReportRepository,
    required this.appMetadata,
  });
}
