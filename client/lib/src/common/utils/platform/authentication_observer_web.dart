import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sentry/sentry.dart';

void onAuthStateChanges(User? user) {
  FirebaseAnalytics.instance.setUserId(id: user?.uid);
  FirebaseAnalytics.instance.setUserProperty(name: 'email', value: user?.email);
  FirebaseAnalytics.instance.setUserProperty(name: 'name', value: user?.displayName);
  if (user?.uid.isNotEmpty ?? false) {
    Sentry.configureScope((scope) => scope.setTag('uid', user?.uid ?? ''));
  }
  if (user?.email?.isNotEmpty ?? false) {
    Sentry.configureScope((scope) => scope.setTag('email', user?.email ?? ''));
  }
}
