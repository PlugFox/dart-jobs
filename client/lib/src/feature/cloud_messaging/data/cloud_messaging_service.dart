import 'package:dart_jobs_client/src/common/constant/storage_namespace.dart';
import 'package:dart_jobs_client/src/feature/cloud_messaging/model/notification_status.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICloudMessagingService {
  /// Поддерживается
  bool get isSupported;

  /// Не поддерживается
  bool get isNotSupported;

  /// Разрешение на пуш уже запрашивалось
  bool get isRequested;

  /// Проверить состояние
  Future<NotificationStatus> check();

  /// Запросить разрешение на пуши
  Future<NotificationStatus> request({bool ifNotAlreadyRequested = false});
}

class CloudMessagingServiceImpl implements ICloudMessagingService {
  CloudMessagingServiceImpl({
    required final SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  @override
  bool get isSupported => FirebaseMessaging.instance.isSupported();

  @override
  bool get isNotSupported => !isSupported;

  @override
  bool get isRequested => _sharedPreferences.getBool(kCloudMessagingPushRequested) ?? false;

  @override
  Future<NotificationStatus> check() async {
    if (isNotSupported) return const NotificationStatus.notSupported();
    final settings = await FirebaseMessaging.instance.getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized
        ? const NotificationStatus.authorized()
        : const NotificationStatus.notAuthorized();
  }

  @override
  Future<NotificationStatus> request({bool ifNotAlreadyRequested = false}) async {
    if (ifNotAlreadyRequested && isRequested) return check();
    await _sharedPreferences.setBool(kCloudMessagingPushRequested, true);
    if (isNotSupported) return const NotificationStatus.notSupported();
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: false,
    );
    return settings.authorizationStatus == AuthorizationStatus.authorized
        ? const NotificationStatus.authorized()
        : const NotificationStatus.notAuthorized();
  }
}
