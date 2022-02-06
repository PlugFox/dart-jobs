import 'dart:async';

import 'package:dart_jobs_client/src/common/utils/platform/authentication_observer_io.dart'
    // ignore: uri_does_not_exist
    if (dart.library.html) 'package:dart_jobs_client/src/common/utils/platform/authentication_observer_web.dart'
    as platform_observe_callback;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:l/l.dart';

extension AuthenticationObserverX on FirebaseAuth {
  static StreamSubscription<User?>? _subscription;

  StreamSubscription<User?> observe() {
    if (_subscription != null) {
      _subscription?.cancel();
      _subscription = null;
    }

    void onError(Object error, StackTrace stackTrace) {
      l.w(
        'Произошла ошибка в функции наблюдателя аутентификации: $error',
        stackTrace,
      );
    }

    try {
      platform_observe_callback.onAuthStateChanges(FirebaseAuth.instance.currentUser);
    } on Object catch (error, stackTrace) {
      onError(error, stackTrace);
    }

    return _subscription = FirebaseAuth.instance.userChanges().listen(
          platform_observe_callback.onAuthStateChanges,
          cancelOnError: false,
          onDone: () => _subscription = null,
          onError: onError,
        );
  }
}
