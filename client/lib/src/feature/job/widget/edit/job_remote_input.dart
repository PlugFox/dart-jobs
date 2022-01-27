import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:flutter/material.dart';

@immutable
class JobRemoteInput extends StatelessWidget {
  const JobRemoteInput({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<bool> controller;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60,
        child: Center(
          child: ValueListenableBuilder<bool>(
            valueListenable: controller,
            builder: (context, value, child) => LayoutBuilder(
              builder: (context, constraints) => ToggleButtons(
                constraints: BoxConstraints(
                  minWidth: math.min(constraints.maxWidth / 3, 150),
                  minHeight: 45,
                  maxHeight: 45,
                ),
                onPressed: (i) {
                  controller.value = i == 0;
                  FocusScope.of(context).unfocus();
                },
                isSelected: [
                  value,
                  !value,
                ],
                children: <Widget>[
                  Text(
                    context.localization.job_field_remote,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    //style: Theme.of(context).textTheme.subtitle1,
                  ),
                  Text(
                    context.localization.job_field_office,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    //style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
