import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
class AdaptiveScaffold extends StatefulWidget {
  const AdaptiveScaffold({
    required final this.body,
    final this.panel,
    final this.appBar,
    final this.maintainBottomViewPadding = false,
    Key? key,
  }) : super(key: key);

  /// Максимальная шириной 620 dip
  final Widget body;

  /// Боковая панель справа от тела, шириной 256 dip
  final Widget? panel;

  /// Шапка экрана
  /// Если AppBar не указан - верхний отступ у SafeArea использоваться не будет
  final PreferredSizeWidget? appBar;

  final bool maintainBottomViewPadding;

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
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    Widget? rail;
    if (width >= withExtendedRail) {
      rail = const _AdaptiveScaffoldExtendedRail(
        key: ValueKey<String>('AdaptiveScaffoldExtendedRail'),
      );
    } else if (width >= withCompactRail) {
      rail = const _AdaptiveScaffoldCompactRail(
        key: ValueKey<String>('AdaptiveScaffoldCompactRail'),
      );
    }
    return _InheritedAdaptiveScaffold(
      state: this,
      child: Scaffold(
        body: SafeArea(
          top: widget.appBar != null,
          maintainBottomViewPadding: widget.maintainBottomViewPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (rail != null) rail,
            ],
          ),
        ),
      ),
    );
  }

  /*
  /// Одна колонка с дравером, мобильный лейаут
  List<Widget> oneColumn(BuildContext context) => <Widget>[
        _AdaptiveScaffoldExpandedBody(
          key: const ValueKey<String>('AdaptiveScaffoldExpandedBody'),
          child: widget.body,
        ),
      ];

  /// Одна колонка с компактной рельсой
  List<Widget> withCompactRail(BuildContext context) => <Widget>[
        const _AdaptiveScaffoldCompactRail(
          key: ValueKey<String>('AdaptiveScaffoldCompactRail'),
        ),
        const SizedBox(width: sidePadding),
        _AdaptiveScaffoldExpandedBody(
          key: const ValueKey<String>('AdaptiveScaffoldExpandedBody'),
          child: widget.body,
        ),
        const SizedBox(width: sidePadding),
      ];

  /// Одна колонка с расширенной рельсой
  List<Widget> withExtendedRail(BuildContext context) => <Widget>[
        const _AdaptiveScaffoldExtendedRail(
          key: ValueKey<String>('AdaptiveScaffoldExtendedRail'),
        ),
        const SizedBox(width: sidePadding),
        _AdaptiveScaffoldExpandedBody(
          key: const ValueKey<String>('AdaptiveScaffoldExpandedBody'),
          child: widget.body,
        ),
        const SizedBox(width: sidePadding),
      ];

  /// Расширенная рельса + контент + правая панель
  List<Widget> withRightPanel(BuildContext context, Widget panel) => <Widget>[
        const _AdaptiveScaffoldExtendedRail(
          key: ValueKey<String>('AdaptiveScaffoldExtendedRail'),
        ),
        const SizedBox(width: sidePadding),
        _AdaptiveScaffoldExpandedBody(
          key: const ValueKey<String>('AdaptiveScaffoldExpandedBody'),
          child: widget.body,
        ),
        const SizedBox(width: sidePadding),
        _AdaptiveScaffoldRightPanel(
          key: const ValueKey<String>('AdaptiveScaffoldRightPanel'),
          child: panel,
        ),
        const SizedBox(width: sidePadding),
      ];
  */
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

/*
/// Drawer
@immutable
class _AdaptiveScaffoldDrawer extends StatelessWidget {
  const _AdaptiveScaffoldDrawer({
    Key? key,
  })  : super(key: key);

  @override
  Widget build(BuildContext context) =>
      const Drawer();
}
*/

/// Тело
@immutable
class _AdaptiveScaffoldExpandedBody extends StatelessWidget {
  const _AdaptiveScaffoldExpandedBody({
    required final this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Expanded(child: child);
}

/// Компактная рельса
@immutable
class _AdaptiveScaffoldCompactRail extends StatelessWidget {
  const _AdaptiveScaffoldCompactRail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => NavigationRail(destinations: destinations, selectedIndex: selectedIndex,);
}

/// Расширенная рельса
@immutable
class _AdaptiveScaffoldExtendedRail extends StatelessWidget {
  const _AdaptiveScaffoldExtendedRail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

/// Правая панель
@immutable
class _AdaptiveScaffoldRightPanel extends StatelessWidget {
  const _AdaptiveScaffoldRightPanel({
    required final this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Expanded(
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(child: child, width: ,),
        ),
      );
}
