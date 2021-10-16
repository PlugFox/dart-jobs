import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:platform_info/platform_info.dart';

// https://github.com/flutter/flutter/issues/32120#issuecomment-725913608
// https://github.com/flutter/flutter/issues/83368
@immutable
class CustomScrollViewSmooth extends StatelessWidget {
  final ScrollController _controller;
  final ScrollPhysics? _physics;
  final ScrollBehavior? _scrollBehavior;
  final double? _cacheExtent;
  final List<Widget> _slivers;

  CustomScrollViewSmooth({
    required final ScrollController controller,
    required final List<Widget> slivers,
    ScrollPhysics? physics,
    ScrollBehavior? scrollBehavior,
    double? cacheExtent,
    Key? key,
  })  : _controller = controller,
        _slivers = slivers,
        _physics = platform.isWeb ? const NeverScrollableScrollPhysics() : physics,
        _scrollBehavior = scrollBehavior,
        _cacheExtent = cacheExtent,
        super(
          key: key,
        );

  @override
  Widget build(BuildContext context) => _CustomScrollViewSmoothWrap(
        controller: _controller,
        child: CustomScrollView(
          controller: _controller,
          physics: _physics,
          scrollBehavior: _scrollBehavior ??
              ScrollConfiguration.of(context).copyWith(
                scrollbars: false,
                dragDevices: <PointerDeviceKind>{
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.touch,
                  PointerDeviceKind.stylus,
                  PointerDeviceKind.invertedStylus,
                },
              ), // _scrollBehavior,
          cacheExtent: _cacheExtent,
          slivers: _slivers,
        ),
      );
}

@immutable
class _CustomScrollViewSmoothWrap extends StatelessWidget {
  final ScrollController controller;
  final Widget child;
  const _CustomScrollViewSmoothWrap({
    required final this.controller,
    required final this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => platform.isWeb
      ? _SmoothScrollWeb(
          controller: controller,
          child: child,
        )
      : child;
}

// 250
// ignore: constant_identifier_names
const int _DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS = 100;
// 130
// ignore: constant_identifier_names
const int _DEFAULT_SCROLL_SPEED = 50;

class _SmoothScrollWeb extends StatefulWidget {
  ///Same ScrollController as the child widget's.
  final ScrollController controller;

  ///Child scrollable widget.
  final Widget child;

  ///Scroll speed px/scroll.
  final int scrollSpeed;

  ///Scroll animation length in milliseconds.
  final int scrollAnimationLength;

  ///Curve of the animation.
  final Curve curve;

  const _SmoothScrollWeb({
    required final this.controller,
    required final this.child,
    this.scrollSpeed = _DEFAULT_SCROLL_SPEED,
    this.scrollAnimationLength = _DEFAULT_NORMAL_SCROLL_ANIMATION_LENGTH_MS,
    this.curve = Curves.linear,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SmoothScrollWebState();
}

class _SmoothScrollWebState extends State<_SmoothScrollWeb> {
  double _scroll = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_setScroll);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_setScroll);
    super.dispose();
  }

  void _setScroll() {
    if (!widget.controller.position.isScrollingNotifier.value) {
      _scroll = widget.controller.position.extentBefore;
    }
  }

  void onPointerSignal(PointerSignalEvent pointerSignal) {
    var millis = widget.scrollAnimationLength;
    if (pointerSignal is PointerScrollEvent) {
      // ignore: prefer-conditional-expressions
      if (pointerSignal.scrollDelta.dy > 0) {
        _scroll += widget.scrollSpeed;
      } else {
        _scroll -= widget.scrollSpeed;
      }
      if (_scroll > widget.controller.position.maxScrollExtent) {
        _scroll = widget.controller.position.maxScrollExtent;
        millis = widget.scrollAnimationLength ~/ 2;
      }
      if (_scroll < 0) {
        _scroll = 0;
        millis = widget.scrollAnimationLength ~/ 2;
      }

      widget.controller.animateTo(
        _scroll,
        duration: Duration(milliseconds: millis),
        curve: widget.curve,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Listener(
        onPointerSignal: onPointerSignal,
        child: widget.child,
      );
}

/*
// https://stackoverflow.com/questions/63581685/flutter-web-smooth-scrolling-on-wheelevent-within-a-pageview

class PageViewLab extends StatefulWidget {
  @override
  _PageViewLabState createState() => _PageViewLabState();
}

class _PageViewLabState extends State<PageViewLab> {
  final sink = StreamController<double>();
  final pager = PageController();

  @override
  void initState() {
    super.initState();
    throttle(sink.stream).listen((offset) {
      pager.animateTo(
        offset,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    sink.close();
    pager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mouse Wheel with PageView'),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Listener(
          onPointerSignal: _handlePointerSignal,
          child: _IgnorePointerSignal(
            child: PageView.builder(
              controller: pager,
              scrollDirection: Axis.vertical,
              itemCount: Colors.primaries.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(color: Colors.primaries[index]),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Stream<double> throttle(Stream<double> src) async* {
    double offset = pager.position.pixels;
    DateTime dt = DateTime.now();
    await for (var delta in src) {
      if (DateTime.now().difference(dt) > Duration(milliseconds: 200)) {
        offset = pager.position.pixels;
      }
      dt = DateTime.now();
      offset += delta;
      yield offset;
    }
  }

  void _handlePointerSignal(PointerSignalEvent e) {
    if (e is PointerScrollEvent && e.scrollDelta.dy != 0) {
      sink.add(e.scrollDelta.dy);
    }
  }
}

// workaround https://github.com/flutter/flutter/issues/35723
class _IgnorePointerSignal extends SingleChildRenderObjectWidget {
  _IgnorePointerSignal({Key key, Widget child}) : super(key: key, child: child);

  @override
  RenderObject createRenderObject(_) => _IgnorePointerSignalRenderObject();
}

class _IgnorePointerSignalRenderObject extends RenderProxyBox {
  @override
  bool hitTest(BoxHitTestResult result, {Offset position}) {
    final res = super.hitTest(result, position: position);
    result.path.forEach((item) {
      final target = item.target;
      if (target is RenderPointerListener) {
        target.onPointerSignal = null;
      }
    });
    return res;
  }
}
*/
