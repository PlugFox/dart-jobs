import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

@immutable
class FeedEmploymentFilter extends StatelessWidget {
  const FeedEmploymentFilter({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<Employment?> controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  context.localization.job_type,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ValueListenableBuilder<Employment?>(
                valueListenable: controller,
                builder: (context, level, child) => LayoutBuilder(
                  builder: (context, constraints) => ToggleButtons(
                    constraints: BoxConstraints(
                      minWidth: math.min(constraints.maxWidth / 2, 150),
                      minHeight: 40,
                      maxHeight: 40,
                    ),
                    onPressed: (i) {
                      switch (i) {
                        case 0:
                          controller.value = null;
                          break;
                        case 1:
                          controller.value = const Employment.fullTime();
                          break;
                      }
                      FocusScope.of(context).unfocus();
                    },
                    isSelected: <bool>[
                      level == null,
                      level == const Employment.fullTime(),
                    ],
                    children: <Widget>[
                      Text(
                        context.localization.none,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.job_type_full_time,
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
              child: ValueListenableBuilder<Employment?>(
                valueListenable: controller,
                builder: (context, level, child) => LayoutBuilder(
                  builder: (context, constraints) => ToggleButtons(
                    constraints: BoxConstraints(
                      minWidth: math.min(constraints.maxWidth / 2, 150),
                      minHeight: 40,
                      maxHeight: 40,
                    ),
                    onPressed: (i) {
                      switch (i) {
                        case 0:
                          controller.value = const Employment.partTime();
                          break;
                        case 1:
                          controller.value = const Employment.contract();
                          break;
                      }
                      FocusScope.of(context).unfocus();
                    },
                    isSelected: <bool>[
                      level == const Employment.partTime(),
                      level == const Employment.contract(),
                    ],
                    children: <Widget>[
                      Text(
                        context.localization.job_type_part_time,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.job_type_contract,
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
              child: ValueListenableBuilder<Employment?>(
                valueListenable: controller,
                builder: (context, level, child) => LayoutBuilder(
                  builder: (context, constraints) => ToggleButtons(
                    constraints: BoxConstraints(
                      minWidth: math.min(constraints.maxWidth / 2, 150),
                      minHeight: 40,
                      maxHeight: 40,
                    ),
                    onPressed: (i) {
                      switch (i) {
                        case 0:
                          controller.value = const Employment.collaboration();
                          break;
                        case 1:
                          controller.value = const Employment.oneTime();
                          break;
                      }
                      FocusScope.of(context).unfocus();
                    },
                    isSelected: <bool>[
                      level == const Employment.collaboration(),
                      level == const Employment.oneTime(),
                    ],
                    children: <Widget>[
                      Text(
                        context.localization.job_type_collaboration,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.job_type_one_time,
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
