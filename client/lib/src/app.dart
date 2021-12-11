import 'package:dart_jobs_client/src/common/widget/app_material_context.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_client/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/widgets.dart';

@immutable
class App extends StatelessWidget {
  static void run({
    required final RepositoryStore repositoryStore,
  }) =>
      runApp(
        App(repositoryStore: repositoryStore),
      );

  const App({
    required final RepositoryStore repositoryStore,
    final Key? key,
  })  : _repositoryStore = repositoryStore,
        super(key: key);

  final RepositoryStore _repositoryStore;

  @override
  Widget build(final BuildContext context) => RepositoryScope(
        repositoryStore: _repositoryStore,
        builder: (context) => const AuthenticationScope(
          child: SettingsScope(
            child: FeedScope(
              child: AppMaterialContext(),
            ),
          ),
        ),
      );
}
