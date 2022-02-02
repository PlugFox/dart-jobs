import 'package:dart_jobs_client/src/common/constant/pubspec.yaml.g.dart' as pubspec;
import 'package:dart_jobs_client/src/common/constant/storage_namespace.dart';
import 'package:l/l.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

@sealed
abstract class AppMigrator {
  AppMigrator._();

  static Future<void> migrate(SharedPreferences sharedPreferences) async {
    try {
      final prevMajor = sharedPreferences.getInt(versionMajorKey);
      final prevMinor = sharedPreferences.getInt(versionMinorKey);
      final prevPatch = sharedPreferences.getInt(versionPatchKey);

      if (pubspec.major == prevMajor && pubspec.minor == prevMinor && pubspec.patch == prevPatch) {
        return;
      } else if (prevMajor != null && prevMinor != null && prevPatch != null) {
        l.i('Переходим с версии $prevMajor.$prevMinor.$prevPatch на ${pubspec.major}.${pubspec.minor}.${pubspec.patch}');
      }

      await Future.wait<void>(
        <Future<void>>[
          sharedPreferences.setInt(versionMajorKey, pubspec.major),
          sharedPreferences.setInt(versionMinorKey, pubspec.minor),
          sharedPreferences.setInt(versionPatchKey, pubspec.patch),
        ],
      );
    } on Object {
      l.e('Ошибка миграции приложения');
      rethrow;
    }
  }
}
