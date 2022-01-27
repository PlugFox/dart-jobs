import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

@immutable
class FeedLevelFilter extends StatelessWidget {
  const FeedLevelFilter({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<DeveloperLevel?> controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 110,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  context.localization.job_field_developer_level,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ValueListenableBuilder<DeveloperLevel?>(
                valueListenable: controller,
                builder: (context, level, child) => LayoutBuilder(
                  builder: (context, constraints) => ToggleButtons(
                    constraints: BoxConstraints(
                      minWidth: math.min(constraints.maxWidth / 3, 100),
                      minHeight: 40,
                      maxHeight: 40,
                    ),
                    onPressed: (i) {
                      switch (i) {
                        case 0:
                          controller.value = null;
                          break;
                        case 1:
                          controller.value = const DeveloperLevel.intern();
                          break;
                        case 2:
                          controller.value = const DeveloperLevel.junior();
                          break;
                      }
                      FocusScope.of(context).unfocus();
                    },
                    isSelected: <bool>[
                      level == null,
                      level == const DeveloperLevel.intern(),
                      level == const DeveloperLevel.junior(),
                    ],
                    children: <Widget>[
                      Text(
                        context.localization.none,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.developer_level_intern,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.developer_level_junior,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ValueListenableBuilder<DeveloperLevel?>(
                valueListenable: controller,
                builder: (context, level, child) => LayoutBuilder(
                  builder: (context, constraints) => ToggleButtons(
                    constraints: BoxConstraints(
                      minWidth: math.min(constraints.maxWidth / 3, 100),
                      minHeight: 40,
                      maxHeight: 40,
                    ),
                    onPressed: (i) {
                      switch (i) {
                        case 0:
                          controller.value = const DeveloperLevel.middle();
                          break;
                        case 1:
                          controller.value = const DeveloperLevel.senior();
                          break;
                        case 2:
                          controller.value = const DeveloperLevel.lead();
                          break;
                      }
                      FocusScope.of(context).unfocus();
                    },
                    isSelected: <bool>[
                      level == const DeveloperLevel.middle(),
                      level == const DeveloperLevel.senior(),
                      level == const DeveloperLevel.lead(),
                    ],
                    children: <Widget>[
                      Text(
                        context.localization.developer_level_middle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.developer_level_senior,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.developer_level_lead,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
