import 'package:dart_jobs/src/common/widget/app_material_context.dart';
import 'package:dart_jobs/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:dart_jobs/src/feature/initialization/widget/initialization_screen.dart';
import 'package:dart_jobs/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/widgets.dart';

@immutable
class App extends StatelessWidget {
  static void run() => runApp(
        const App(),
      );

  const App({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => const InitializationScope(
        initializationScreen: InitializationScreen(),
        child: AuthenticationScope(
          child: SettingsScope(
            child: FeedScope(
              child: AppMaterialContext(),
            ),
          ),
        ),
      );
}
