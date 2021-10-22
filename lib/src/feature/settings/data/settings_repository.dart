import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/settings/model/user_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ISettingsRepository {
  /// Получить настройки из локального кэша
  UserSettings getFromCache();

  /// Получить настройки с сервера
  Future<UserSettings> getFromServer(final AuthenticatedUser user);

  /// Обновить настройки в кэше и на сервере
  Future<void> update(final AuthenticatedUser user, final UserSettings settings);
}

class SettingsRepository implements ISettingsRepository {
  UserSettings? _settingsCache;
  static const String _prefix = 'settings';
  final SharedPreferences _sharedPreferences;
  final FirebaseFirestore _firestore;

  SettingsRepository({
    required final SharedPreferences sharedPreferences,
    required final FirebaseFirestore firestore,
  })  : _firestore = firestore,
        _sharedPreferences = sharedPreferences;

  @override
  UserSettings getFromCache() => _settingsCache ??= UserSettings(
        locale: _sharedPreferences.getString('$_prefix.locale') ?? UserSettings.initial.locale,
        theme: _sharedPreferences.getString('$_prefix.theme') ?? UserSettings.initial.theme,
      );

  @override
  Future<UserSettings> getFromServer(final UserEntity user) async {
    if (user is! AuthenticatedUser || user.uid.isEmpty) {
      return Future<UserSettings>.value(UserSettings.initial);
    }
    //const source = Source.serverAndCache;
    final snapshot = await _getSettingsDocumentRef(user).get(); // const GetOptions(source: source)
    UserSettings result;
    if (!snapshot.exists) {
      result = UserSettings.initial;
    } else {
      final data = snapshot.data() as Map<String, Object?>? ?? <String, Object?>{};
      final remoteSettings = Map<String, String?>.from(
        data..removeWhere((final key, final value) => value is! String?),
      );
      result = UserSettings(
        locale: remoteSettings['locale'] ?? UserSettings.initial.locale,
        theme: remoteSettings['theme'] ?? UserSettings.initial.theme,
      );
    }
    await _updateLocal(result);
    return result;
  }

  @override
  Future<void> update(final AuthenticatedUser user, final UserSettings settings) => Future.wait<void>(
        <Future<void>>[
          _updateLocal(settings),
          _updateRemote(user, settings),
        ],
      );

  DocumentReference _getSettingsDocumentRef(final AuthenticatedUser user) =>
      _firestore.collection('users').doc(user.uid).collection('settings').doc('default');

  Future<void> _updateLocal(final UserSettings settings) async {
    _settingsCache = settings;
    final map = settings.toJson();
    for (final entry in map.entries) {
      if (entry.value is! String) continue;
      await _sharedPreferences.setString('$_prefix.${entry.key}', entry.value as String);
    }
  }

  Future<void> _updateRemote(final AuthenticatedUser user, final UserSettings settings) =>
      _getSettingsDocumentRef(user).set(settings.toJson());
}
