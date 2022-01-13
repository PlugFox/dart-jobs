import 'package:flutter/material.dart';

@immutable
class JobBottomSheet extends StatelessWidget implements PreferredSizeWidget {
  const JobBottomSheet({
    required final this.height,
    required final this.child,
    Key? key,
  }) : super(key: key);

  static Future<void> show({
    required final BuildContext context,
    required final double height,
    required final Widget child,
  }) =>
      showModalBottomSheet<void>(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(10),
          ),
        ),
        builder: (context) => JobBottomSheet(
          height: height,
          child: child,
        ),
      );

  /// Высота контента (без учета заголовка)
  final double height;

  /// Контент
  final Widget child;

  @override
  Size get preferredSize => Size.fromHeight(24 + height + 16);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 24 + 16 + height,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 24,
              child: Center(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFD6DBE0),
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                  ),
                  child: SizedBox(
                    width: 38,
                    height: 4,
                  ),
                ),
              ),
            ),
            Expanded(
              child: child,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      );
}
