import 'package:dart_jobs_client/src/feature/settings/widget/platform/io.dart'
    if (dart.library.html) 'package:dart_jobs_client/src/feature/settings/widget/platform/web.dart' as platform;

void changeTheme(String theme) => platform.changeTheme(theme);
