import 'package:dart_jobs_client/src/feature/initialization/model/initialization_progress.dart';
import 'package:flutter/widgets.dart';

export 'package:dart_jobs_client/src/feature/initialization/bloc/initialization_bloc.dart';
export 'package:dart_jobs_client/src/feature/initialization/model/initialization_progress.dart';

@immutable
class RepositoryScope extends StatelessWidget {
  const RepositoryScope({
    required final this.repositoryStore,
    required this.builder,
    final Key? key,
  }) : super(key: key);

  final RepositoryStore repositoryStore;
  final WidgetBuilder builder;

  /// Получить результат инициализации из контекста
  /// Работает только в контексте проинициализированного приложения
  static RepositoryStore of(final BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedRepositoryScope>()?.widget;
    final store = inhW is _InheritedRepositoryScope ? inhW.repositoryStore : null;
    return store ?? _throwNotInitializedYet();
  }

  static Never _throwNotInitializedYet() => throw UnsupportedError('The application has not been initialized yet');

  @override
  Widget build(final BuildContext context) => _InheritedRepositoryScope(
        repositoryStore: repositoryStore,
        child: Builder(
          builder: builder,
        ),
      );
}

@immutable
class _InheritedRepositoryScope extends InheritedWidget {
  const _InheritedRepositoryScope({
    required final this.repositoryStore,
    required final Widget child,
    final Key? key,
  }) : super(key: key, child: child);

  final RepositoryStore repositoryStore;

  @override
  bool updateShouldNotify(final _InheritedRepositoryScope oldWidget) => false;
}
