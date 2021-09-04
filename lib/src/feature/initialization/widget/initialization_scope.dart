import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../bloc/initialization_bloc.dart';
import '../data/initialization_helper.dart';
import '../model/initialization_progress.dart';

@immutable
class InitializationScope extends StatefulWidget {
  final Widget initializationScreen;
  final Widget child;

  const InitializationScope({
    required final this.initializationScreen,
    required final this.child,
    Key? key,
  }) : super(key: key);

  /// Find _InitializationScopeState in BuildContext
  static _InheritedInitialization? _of(BuildContext context) {
    final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedInitialization>()?.widget;
    return inheritedWidget is _InheritedInitialization ? inheritedWidget : null;
  }

  /// Find Stream<InitializationState> in BuildContext
  static Stream<InitializationState> of(BuildContext context) =>
      _of(context)?.bloc.stream ?? const Stream<InitializationState>.empty();

  /// Получить результат инициализации из контекста
  /// Работает только в контексте проинициализированного приложения
  static RepositoryStore storeOf(BuildContext context) =>
      _of(context)?.bloc.state.maybeWhen<RepositoryStore>(
            orElse: _throwNotInitializedYet,
            initialized: (store) => store,
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
  Widget build(BuildContext context) {
    final bloc = _bloc;
    if (bloc == null) return const SizedBox.shrink();
    return BlocBuilder<InitializationBLoC, InitializationState>(
      bloc: bloc,
      buildWhen: (prev, next) => prev != next,
      builder: (context, state) => _InheritedInitialization(
        state: this,
        bloc: bloc,
        child: state.maybeWhen<Widget>(
          orElse: () => widget.initializationScreen,
          initialized: (_) => widget.child,
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
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedInitialization oldWidget) => false;
}
