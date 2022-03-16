import 'package:dart_jobs_client/src/common/constant/firebase_options.dart' as firebase_options;
import 'package:dart_jobs_client/src/common/utils/authentication_observer.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/foundation.dart';
import 'package:l/l.dart';

// ignore: avoid_classes_with_only_static_members
abstract class FirebaseInitializer {
  /// Инициализация фаербейза
  static Future<void> initialize() async {
    // Инициализировать Firebase
    l.vvvvvv('Инициализируем Firebase');
    await firebase_core.Firebase.initializeApp(
      options: firebase_options.DefaultFirebaseOptions.currentPlatform,
    ).then<void>(
      (final firebaseApp) => Future.wait<void>(
        <Future<void>>[
          firebaseApp.setAutomaticDataCollectionEnabled(kReleaseMode),
          firebaseApp.setAutomaticResourceManagementEnabled(kReleaseMode),
        ],
      ),
    );
    // Устанавливаем идентификаторы и свойства пользователя
    firebase_auth.FirebaseAuth.instance.observe();
  }
}
