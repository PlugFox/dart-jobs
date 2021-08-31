import 'package:flutter/material.dart';

import '../../../common/localization/localizations.dart';

/// Шапка
class FeedBar extends StatelessWidget {
  const FeedBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SliverAppBar(
        pinned: true,
        floating: true,
        expandedHeight: 150,
        //elevation: 4,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(
            context.localization.title,
          ),
        ),
      );
}
