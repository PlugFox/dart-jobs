import 'package:dart_jobs/src/feature/initialization/bloc/initialization_bloc.dart';
import 'package:dart_jobs/src/feature/initialization/data/initialization_helper.dart';
import 'package:dart_jobs/src/feature/initialization/model/initialization_progress.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

export 'package:dart_jobs/src/feature/initialization/bloc/initialization_bloc.dart';
export 'package:dart_jobs/src/feature/initialization/model/initialization_progress.dart';

@immutable
class InitializationScope extends StatefulWidget {
  final Widget initializationScreen;
  final Widget child;

  const InitializationScope({
    required final this.initializationScreen,
    required final this.child,
    final Key? key,
  }) : super(key: key);

  /// Find InitializationBLoC in BuildContext
  static InitializationBLoC? _blocOf(final BuildContext context) {
    final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedInitialization>()?.widget;
    return inheritedWidget is _InheritedInitialization ? inheritedWidget.bloc : null;
  }

  /// Find Stream<InitializationState> in BuildContext
  static Stream<InitializationState> of(final BuildContext context) =>
      _blocOf(context)?.stream ?? const Stream<InitializationState>.empty();

  /// Получить результат инициализации из контекста
  /// Работает только в контексте проинициализированного приложения
  static RepositoryStore storeOf(final BuildContext context) =>
      _blocOf(context)?.state.maybeWhen<RepositoryStore>(
            orElse: _throwNotInitializedYet,
            initialized: (final store) => store,
          ) ??
      _throwNotInitializedYet();

  static Never _throwNotInitializedYet() => throw UnsupportedError('The application has not been initialized yet');

  @override
  State<InitializationScope> createState() => _InitializationScopeState();
}

class _InitializationScopeState extends State<InitializationScope> {
  InitializationBLoC? _bloc;

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    final _initializationHelper = InitializationHelper();
    _bloc = InitializationBLoC(initializationHelper: _initializationHelper)
      ..add(const InitializationEvent.initialize());
  }

  @override
  void dispose() {
    _bloc?.close();
    super.dispose();
  }
  //endregion

  @override
  Widget build(final BuildContext context) {
    final bloc = _bloc;
    if (bloc == null) return const SizedBox.shrink();
    return BlocBuilder<InitializationBLoC, InitializationState>(
      bloc: bloc,
      buildWhen: (final prev, final next) => prev != next,
      builder: (final context, final state) => _InheritedInitialization(
        state: this,
        bloc: bloc,
        child: state.maybeWhen<Widget>(
          orElse: () => widget.initializationScreen,
          initialized: (final _) => widget.child,
        ),
      ),
    );
  }
}

@immutable
class _InheritedInitialization extends InheritedWidget {
  final _InitializationScopeState state;
  final InitializationBLoC bloc;

  const _InheritedInitialization({
    required final this.state,
    required final this.bloc,
    required final Widget child,
    final Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(final _InheritedInitialization oldWidget) => false;
}
