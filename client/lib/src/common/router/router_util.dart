import 'package:path/path.dart' as p;

abstract class RouteInformationUtil {
  RouteInformationUtil._();

  /// Выбросить из локации повторяющиеся сегменты
  /// Роут всегда должен начинаться с home
  static String normalize(String? sourceLocation) {
    if (sourceLocation == null) return 'feed';
    final segments = <String>[];
    sourceLocation
        .toLowerCase()
        .split('/')
        .map<String>((e) => e.trim())
        .where((e) => e.isNotEmpty && e != 'feed')
        .forEach(
          (e) => segments
            ..remove(e)
            ..add(e),
        );
    return p.normalize(
      p.joinAll(
        <String>[
          'feed',
          ...segments,
        ],
      ),
    );
  }
}
