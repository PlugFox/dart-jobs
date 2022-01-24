import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:flutter/material.dart';

@immutable
class FeedRemoteFilter extends StatelessWidget {
  const FeedRemoteFilter({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<bool?> controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 70,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
              child: Center(
                child: Text(
                  context.localization.job_field_remote,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ),
            SizedBox(
              height: 40,
              child: ValueListenableBuilder<bool?>(
                valueListenable: controller,
                builder: (context, value, child) => LayoutBuilder(
                  builder: (context, constraints) => ToggleButtons(
                    constraints: BoxConstraints(
                      minWidth: math.min(constraints.maxWidth / 3, 100),
                      minHeight: 30,
                      maxHeight: 30,
                    ),
                    onPressed: (i) {
                      switch (i) {
                        case 0:
                          controller.value = null;
                          break;
                        case 1:
                          controller.value = true;
                          break;
                        case 2:
                          controller.value = false;
                          break;
                      }
                      FocusScope.of(context).unfocus();
                    },
                    isSelected: <bool>[
                      value == null,
                      value ?? false,
                      value == false,
                    ],
                    children: <Widget>[
                      Text(
                        context.localization.none,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.yes,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        //style: Theme.of(context).textTheme.subtitle1,
                      ),
                      Text(
                        context.localization.no,
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
