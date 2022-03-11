import 'package:dart_jobs_client/src/feature/settings/widget/platform/platform_io.dart'
    if (dart.library.html) 'package:dart_jobs_client/src/feature/settings/widget/platform/platform_web.dart'
    as platform;

void changeTheme(String theme) => platform.changeTheme(theme);
