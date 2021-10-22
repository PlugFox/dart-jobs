import 'package:flutter/material.dart';

@immutable
class FeedSearchBar extends StatelessWidget implements PreferredSizeWidget {
  static const Size searchBarSize = Size.fromHeight(kToolbarHeight);

  @override
  Size get preferredSize => searchBarSize;

  const FeedSearchBar({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => SizedBox.fromSize(
        size: searchBarSize,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Row(
              children: const <Widget>[
                Expanded(child: Placeholder()),
                Text(' SEARCH... '),
                Expanded(child: Placeholder()),
              ],
            ),
          ),
        ),
      );
}
