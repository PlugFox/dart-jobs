import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'common/widget/app_material_context.dart';
import 'feature/authentication/widget/authentication_scope.dart';
import 'feature/feed/widget/feed_scope.dart';
import 'feature/initialization/widget/initialization_scope.dart';
import 'feature/initialization/widget/initialization_screen.dart';
import 'feature/settings/widget/settings_scope.dart';

@immutable
class App extends StatelessWidget {
  static void run() => runApp(
        const App(),
      );

  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const InitializationScope(
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
