import 'package:dart_jobs_client/src/common/constant/pubspec.yaml.g.dart' as pubspec;
import 'package:flutter/material.dart';

@immutable
class StatusesOverlay extends StatelessWidget {
  const StatusesOverlay({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => Stack(
        children: <Positioned>[
          Positioned.fill(child: child),
          Positioned(
            left: 8,
            bottom: 4,
            height: 12,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //Tooltip(
                //  message: context.localization.connection_status,
                //  child: Icon(
                //    Icons.signal_cellular_null,
                //    size: 12,
                //    color: Colors.black26,
                //  ),
                //),
                //SizedBox(width: 4),
                Text(
                  'v${pubspec.major}.${pubspec.minor}.${pubspec.patch}',
                  style: Theme.of(context).primaryTextTheme.caption?.copyWith(
                        color: Colors.black26,
                        height: 1,
                      ),
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.clip,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ),
        ],
      );
}
