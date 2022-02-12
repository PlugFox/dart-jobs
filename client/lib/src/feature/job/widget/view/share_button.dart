import 'dart:math' as math;

import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class ShareButton extends StatelessWidget {
  const ShareButton({
    required final this.job,
    Key? key,
  }) : super(
          key: key,
        );

  final Job job;

  @override
  Widget build(BuildContext context) => job.hasID ? _ShareButton(job: job) : const SizedBox.shrink();
}

@immutable
class _ShareButton extends StatefulWidget {
  const _ShareButton({
    required final this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  State<_ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<_ShareButton> with SingleTickerProviderStateMixin {
  static const double _iconSize = 64;
  late final AnimationController _controller;
  late final FlowDelegate _flowDelegate;

  final List<Widget> _actions = <Widget>[
    _ShareIconButton(id: 1),
    _ShareIconButton(id: 2),
    _ShareIconButton(id: 3),
    _ShareIconButton(id: 4),
  ];

  bool get opened {
    switch (_controller.status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        return false;
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
    }
  }

  bool get closed => !opened;

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _flowDelegate = _ShareButtonFlowDelegate(controller: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  //endregion

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          width: constraints.biggest.shortestSide,
          height: constraints.biggest.shortestSide,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Flow(
              delegate: _flowDelegate,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => AnimatedCrossFade(
                    duration: const Duration(milliseconds: 350),
                    firstChild: FloatingActionButton(
                      onPressed: _controller.reverse,
                      backgroundColor: Colors.blueGrey,
                      child: const Icon(Icons.close),
                    ),
                    secondChild: FloatingActionButton(
                      onPressed: _controller.forward,
                      child: const Icon(Icons.share),
                    ),
                    crossFadeState: opened ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                  ),
                ),
                ..._actions,
              ],
            ),
          ),
        ),
      );
}

class _ShareButtonFlowDelegate extends FlowDelegate {
  _ShareButtonFlowDelegate({required final this.controller}) : super(repaint: controller);

  final ValueListenable<double> controller;

  @override
  void paintChildren(FlowPaintingContext context) {
    final totalCount = context.childCount;
    if (totalCount == 0) return;
    const iconSize = _ShareButtonState._iconSize;
    const offset = iconSize * 1.75;
    final size = context.size;

    final centerX = size.width - iconSize;
    final centerY = size.height - iconSize;

    context.paintChild(
      0,
      transform: Matrix4.translationValues(
        centerX,
        centerY,
        0,
      ),
    );

    final radialCount = totalCount - 1;
    const lastPositionAngle = math.pi * 3 / 2;
    final offsetAngle = (90 / (radialCount - 1)) * math.pi / 180;
    final transition = math.pi / 2 * (1 - controller.value);

    for (var i = 0; i < radialCount; i++) {
      final x = offset * math.cos(lastPositionAngle - i * offsetAngle - transition);
      final y = offset * math.sin(lastPositionAngle - i * offsetAngle - transition);
      context.paintChild(
        i + 1,
        transform: Matrix4.translationValues(
          centerX + x,
          centerY + y,
          0,
        ),
        opacity: controller.value,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

@immutable
class _ShareIconButton extends StatelessWidget {
  const _ShareIconButton({
    required final this.id,
    Key? key,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () {},
        child: Text(id.toString()),
      );
}
