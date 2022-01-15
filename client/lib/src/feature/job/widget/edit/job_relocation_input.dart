import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_bottom_sheet.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

/// TODO: на высоких экранах использовать DropDownButton

@immutable
class JobRelocationInput extends StatefulWidget {
  const JobRelocationInput({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<Relocation> controller;

  @override
  State<JobRelocationInput> createState() => _JobRelocationInputState();
}

class _JobRelocationInputState extends State<JobRelocationInput> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      height: 60,
      child: Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            JobBottomSheet.show(
              context: context,
              height: 56 * 3,
              child: _RelocationBottomSheet(
                controller: widget.controller,
              ),
            ).then<void>(
              (_) => setState(() => _focus = false),
            );
            FocusScope.of(context).unfocus();
            setState(() => _focus = true);
          },
          child: ValueListenableBuilder<Relocation>(
            valueListenable: widget.controller,
            builder: (context, value, child) => InputDecorator(
              isFocused: _focus,
              expands: true,
              isHovering: true,
              decoration: InputDecoration(
                labelText: context.localization.job_field_relocation,
              ),
              isEmpty: false,
              child: Text(
                _relocationRepresentation(context, value),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: themeData.textTheme.subtitle1,
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _relocationRepresentation(BuildContext context, Relocation relocation) => relocation.when<String>(
        impossible: () => context.localization.job_field_relocation_impossible,
        possible: () => context.localization.job_field_relocation_possible,
        required: () => context.localization.job_field_relocation_required,
      );
}

@immutable
class _RelocationBottomSheet extends StatelessWidget {
  const _RelocationBottomSheet({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<Relocation> controller;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<Relocation>(
        valueListenable: controller,
        builder: (context, value, child) => ListView(
          physics: const BouncingScrollPhysics(),
          itemExtent: 56,
          children: <Widget>[
            _RelocationTile(
              label: context.localization.job_field_relocation_impossible,
              current: value,
              value: const Relocation.impossible(),
              onSelected: onSelected,
            ),
            _RelocationTile(
              label: context.localization.job_field_relocation_possible,
              current: value,
              value: const Relocation.possible(),
              onSelected: onSelected,
            ),
            _RelocationTile(
              label: context.localization.job_field_relocation_required,
              current: value,
              value: const Relocation.required(),
              onSelected: onSelected,
            ),
          ],
        ),
      );

  void onSelected(Relocation? relocation) {
    if (relocation != null) {
      controller.value = relocation;
    }
  }
}

@immutable
class _RelocationTile extends StatelessWidget {
  const _RelocationTile({
    required final this.label,
    required final this.current,
    required final this.value,
    required final this.onSelected,
    Key? key,
  }) : super(key: key);

  final String label;
  final Relocation current;
  final Relocation value;
  final void Function(Relocation? relocation) onSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 56,
        child: RadioListTile<Relocation>(
          groupValue: current,
          value: value,
          onChanged: onSelected,
          contentPadding: EdgeInsets.symmetric(
            horizontal: math.max<double>(
              (MediaQuery.of(context).size.width - kBodyWidth) / 2,
              16,
            ),
            vertical: 0,
          ),
          title: Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.clip,
          ),
        ),
      );
}
