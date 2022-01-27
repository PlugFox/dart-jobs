import 'dart:async';

import 'package:dart_jobs_client/src/common/widget/drawer_scope.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:platform_info/platform_info.dart';

@immutable
class AdaptiveScaffold extends StatefulWidget {
  const AdaptiveScaffold({
    required final this.body,
    final this.appBar,
    final this.maintainBottomViewPadding = false,
    final this.isRootPage = false,
    Key? key,
  }) : super(key: key);

  /// Лейаут с двумя колонками
  factory AdaptiveScaffold.twoPane() => throw UnimplementedError('Не реализовано!');

  /// Предполагается, что основная колонка будет шириной 620 dip
  final Widget body;

  /// Это корневая страница
  final bool isRootPage;

  // /// Боковая панель справа от тела, шириной 320 dip
  // final Widget? panel;

  /// Шапка экрана
  /// Если AppBar не указан - верхний отступ у SafeArea использоваться не будет
  final PreferredSizeWidget? appBar;

  /// Specifies whether the SafeArea should maintain the MediaQueryData.viewPadding
  /// instead of the MediaQueryData.padding when consumed by the MediaQueryData.viewInsets
  /// of the current context's MediaQuery, defaults to false.
  ///
  /// For example, if there is an onscreen keyboard displayed above the SafeArea,
  /// the padding can be maintained below the obstruction rather than being consumed.
  /// This can be helpful in cases where your layout contains flexible widgets,
  /// which could visibly move when opening a software keyboard due to the change in the padding value.
  /// Setting this to true will avoid the UI shift.
  final bool maintainBottomViewPadding;

  /// Показывается дравер?
  /// Возвращает true если экран достаточно широк для показа боковой рельсы или если у Scaffold'а выдвинут Drawer
  bool isDrawerOpen(BuildContext context) =>
      DrawerScope.isDrawerShown(context) || (Scaffold.maybeOf(context)?.isDrawerOpen ?? false);

  /// Find _AdaptiveScaffoldState in BuildContext
  @protected
  @doNotStore
  // ignore: unused_element
  static _AdaptiveScaffoldState _stateOf(BuildContext context, {bool listen = false}) {
    _AdaptiveScaffoldState? state;
    if (listen) {
      state = context.dependOnInheritedWidgetOfExactType<_InheritedAdaptiveScaffold>()?.state;
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedAdaptiveScaffold>()?.widget;
      state = inheritedWidget is _InheritedAdaptiveScaffold ? inheritedWidget.state : null;
    }
    return state ?? _notInScope();
  }

  @alwaysThrows
  static Never _notInScope() => throw UnsupportedError('Not in AdaptiveScaffold scope');

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  @override
  Widget build(BuildContext context) => _InheritedAdaptiveScaffold(
        state: this,
        child: Scaffold(
          appBar: widget.appBar,
          drawer: (!widget.isRootPage &&
                      platform.operatingSystem.maybeWhen<bool>(
                        orElse: () => false,
                        iOS: () => true,
                      )) ||
                  DrawerScope.isDrawerShown(context)
              ? null
              : const _DrawerCloser(
                  child: AppDrawer(),
                ),
          body: SafeArea(
            top: widget.appBar != null,
            maintainBottomViewPadding: widget.maintainBottomViewPadding,
            child: Align(
              alignment: Alignment.topCenter,
              child: widget.body,
            ),
          ),
        ),
      );
}

@immutable
class _InheritedAdaptiveScaffold extends InheritedWidget {
  final _AdaptiveScaffoldState state;

  const _InheritedAdaptiveScaffold({
    required final this.state,
    required final Widget child,
    Key? key,
  }) : super(
          key: key,
          child: child,
        );

  @override
  bool updateShouldNotify(_InheritedAdaptiveScaffold oldWidget) => false;
}

@immutable
class _DrawerCloser extends StatefulWidget {
  const _DrawerCloser({
    required final this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  State<_DrawerCloser> createState() => _DrawerCloserState();
}

class _DrawerCloserState extends State<_DrawerCloser> {
  bool _firstBuild = true;
  DrawerControllerState? _controllerState;
  bool _closing = false;

  @override
  void initState() {
    super.initState();
    _controllerState = context.findAncestorStateOfType<DrawerControllerState>();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_closing || _controllerState == null) return;
    if (_firstBuild) {
      context.dependOnInheritedWidgetOfExactType<MediaQuery>();
      _firstBuild = false;
      return;
    }
    _closing = true;
    Future<void>.delayed(
      const Duration(seconds: 2),
      () => _closing = false,
    );
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        final controller = _controllerState;
        if (controller == null || !controller.mounted) return;
        controller.close();
      },
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
