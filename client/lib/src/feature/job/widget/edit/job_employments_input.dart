import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_bottom_sheet.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

/// TODO: на высоких экранах использовать DropDownButton

@immutable
class JobEmploymentsInput extends StatefulWidget {
  const JobEmploymentsInput({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<List<Employment>> controller;

  @override
  State<JobEmploymentsInput> createState() => _JobEmploymentsInputState();
}

class _JobEmploymentsInputState extends State<JobEmploymentsInput> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      height: 60,
      child: GestureDetector(
        onTap: () {
          JobBottomSheet.show(
            context: context,
            height: 56 * 6,
            child: _EmploymentsBottomSheet(
              controller: widget.controller,
            ),
          ).then<void>(
            (_) => setState(() => _focus = false),
          );
          FocusScope.of(context).unfocus();
          setState(() => _focus = true);
        },
        child: ValueListenableBuilder<List<Employment>>(
          valueListenable: widget.controller,
          builder: (context, value, child) => InputDecorator(
            isFocused: _focus,
            expands: true,
            isHovering: true,
            decoration: InputDecoration(
              labelText: context.localization.job_field_contract_type,
            ),
            isEmpty: value.isEmpty,
            child: Text(
              _employmentRepresentation(context, value),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: themeData.textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  String _employmentRepresentation(BuildContext context, List<Employment> levels) {
    if (levels.isEmpty) return '';
    if (levels.length == Employment.values.length) return context.localization.job_type_any;

    String representation(Employment level) => level.when(
          fullTime: () => context.localization.job_type_full_time,
          partTime: () => context.localization.job_type_part_time,
          oneTime: () => context.localization.job_type_one_time,
          contract: () => context.localization.job_type_contract,
          openSource: () => context.localization.job_type_open_source,
          collaboration: () => context.localization.job_type_collaboration,
        );

    if (levels.length == 1) return representation(levels.first);
    return levels.map<String>(representation).join(', ');
  }
}

@immutable
class _EmploymentsBottomSheet extends StatelessWidget {
  const _EmploymentsBottomSheet({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<List<Employment>> controller;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<List<Employment>>(
        valueListenable: controller,
        builder: (context, value, child) => ListView(
          physics: const BouncingScrollPhysics(),
          itemExtent: 56,
          children: <Widget>[
            _EmploymentTile(
              label: context.localization.job_type_full_time,
              selected: value.any((e) => e.name == const Employment.fullTime().name),
              onSelected: (value) => onSelected(value: value, employment: const Employment.fullTime()),
            ),
            _EmploymentTile(
              label: context.localization.job_type_part_time,
              selected: value.any((e) => e.name == const Employment.partTime().name),
              onSelected: (value) => onSelected(value: value, employment: const Employment.partTime()),
            ),
            _EmploymentTile(
              label: context.localization.job_type_one_time,
              selected: value.any((e) => e.name == const Employment.oneTime().name),
              onSelected: (value) => onSelected(value: value, employment: const Employment.oneTime()),
            ),
            _EmploymentTile(
              label: context.localization.job_type_contract,
              selected: value.any((e) => e.name == const Employment.contract().name),
              onSelected: (value) => onSelected(value: value, employment: const Employment.contract()),
            ),
            _EmploymentTile(
              label: context.localization.job_type_open_source,
              selected: value.any((e) => e.name == const Employment.openSource().name),
              onSelected: (value) => onSelected(value: value, employment: const Employment.openSource()),
            ),
            _EmploymentTile(
              label: context.localization.job_type_collaboration,
              selected: value.any((e) => e.name == const Employment.collaboration().name),
              onSelected: (value) => onSelected(value: value, employment: const Employment.collaboration()),
            ),
          ],
        ),
      );

  void onSelected({required bool? value, required Employment employment}) =>
      controller.value = (value ?? !controller.value.contains(employment))
          ? <Employment>[...controller.value.where((e) => e.name != employment.name), employment]
          : List<Employment>.of(controller.value.where((e) => e != employment));
}

@immutable
class _EmploymentTile extends StatelessWidget {
  const _EmploymentTile({
    required final this.label,
    required final this.selected,
    required final this.onSelected,
    Key? key,
  }) : super(key: key);

  final String label;
  final bool selected;
  final void Function(bool? value) onSelected;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 56,
        child: CheckboxListTile(
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
          value: selected,
        ),
      );
}
