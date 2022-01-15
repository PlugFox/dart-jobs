import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_bottom_sheet.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

/// TODO: на высоких экранах использовать DropDownButton

@immutable
class JobLevelsInput extends StatefulWidget {
  const JobLevelsInput({
    required final this.controller,
    required final this.error,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<List<DeveloperLevel>> controller;
  final ValueNotifier<String?> error;

  @override
  State<JobLevelsInput> createState() => _JobLevelsInputState();
}

class _JobLevelsInputState extends State<JobLevelsInput> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Align(
      alignment: Alignment.topLeft,
      child: GestureDetector(
        onTap: () {
          JobBottomSheet.show(
            context: context,
            height: 56 * 5,
            child: _DeveloperBottomSheet(
              controller: widget.controller,
            ),
          ).then<void>(
            (_) => setState(() => _focus = false),
          );
          FocusScope.of(context).unfocus();
          setState(() => _focus = true);
        },
        child: ValueListenableBuilder<List<DeveloperLevel>>(
          valueListenable: widget.controller,
          builder: (context, value, _) => ValueListenableBuilder<String?>(
            valueListenable: widget.error,
            builder: (context, errorText, child) => SizedBox(
              height: errorText == null ? 60 : 80,
              child: InputDecorator(
                isFocused: _focus,
                expands: true,
                isHovering: true,
                decoration: InputDecoration(
                  labelText: context.localization.job_field_developer_level,
                  errorText: errorText,
                ),
                isEmpty: value.isEmpty,
                child: child,
              ),
            ),
            child: Text(
              _levelRepresentation(context, value),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: themeData.textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }

  String _levelRepresentation(BuildContext context, List<DeveloperLevel> levels) {
    if (levels.isEmpty) return '';
    if (levels.length == DeveloperLevel.values.length) return context.localization.developer_level_any;

    String representation(DeveloperLevel level) => level.when<String>(
          intern: () => context.localization.developer_level_intern,
          junior: () => context.localization.developer_level_junior,
          middle: () => context.localization.developer_level_middle,
          senior: () => context.localization.developer_level_senior,
          lead: () => context.localization.developer_level_lead,
        );

    if (levels.length == 1) return representation(levels.first);
    levels.sort((a, b) => a.value.compareTo(b.value));
    if (levels.length < 5) {
      return levels.map<String>(representation).join(', ');
    }
    return '${representation(levels.first)} - ${representation(levels.last)}';
  }
}

@immutable
class _DeveloperBottomSheet extends StatelessWidget {
  const _DeveloperBottomSheet({
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<List<DeveloperLevel>> controller;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<List<DeveloperLevel>>(
        valueListenable: controller,
        builder: (context, value, child) => ListView(
          physics: const BouncingScrollPhysics(),
          itemExtent: 56,
          children: <Widget>[
            _DeveloperLevelTile(
              label: context.localization.developer_level_intern,
              selected: value.any((e) => e.name == const DeveloperLevel.intern().name),
              onSelected: (value) => onSelected(value: value, level: const DeveloperLevel.intern()),
            ),
            _DeveloperLevelTile(
              label: context.localization.developer_level_junior,
              selected: value.any((e) => e.name == const DeveloperLevel.junior().name),
              onSelected: (value) => onSelected(value: value, level: const DeveloperLevel.junior()),
            ),
            _DeveloperLevelTile(
              label: context.localization.developer_level_middle,
              selected: value.any((e) => e.name == const DeveloperLevel.middle().name),
              onSelected: (value) => onSelected(value: value, level: const DeveloperLevel.middle()),
            ),
            _DeveloperLevelTile(
              label: context.localization.developer_level_senior,
              selected: value.any((e) => e.name == const DeveloperLevel.senior().name),
              onSelected: (value) => onSelected(value: value, level: const DeveloperLevel.senior()),
            ),
            _DeveloperLevelTile(
              label: context.localization.developer_level_lead,
              selected: value.any((e) => e.name == const DeveloperLevel.lead().name),
              onSelected: (value) => onSelected(value: value, level: const DeveloperLevel.lead()),
            ),
          ],
        ),
      );

  void onSelected({required bool? value, required DeveloperLevel level}) =>
      controller.value = (value ?? !controller.value.contains(level))
          ? <DeveloperLevel>[...controller.value.where((e) => e.name != level.name), level]
          : List<DeveloperLevel>.of(controller.value.where((e) => e != level));
}

@immutable
class _DeveloperLevelTile extends StatelessWidget {
  const _DeveloperLevelTile({
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
          contentPadding: EdgeInsets.symmetric(
            horizontal: math.max<double>(
              (MediaQuery.of(context).size.width - kBodyWidth) / 2,
              16,
            ),
            vertical: 0,
          ),
          onChanged: onSelected,
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
