import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/constant/layout_constraints.dart';
import '../bloc/job_bloc.dart';
import '../model/job.dart';
import 'job_scope.dart';

@immutable
class JobForm extends StatefulWidget {
  final Widget child;
  const JobForm({
    required this.child,
    Key? key,
  }) : super(key: key);

  /// Для поиска _JobFormState в контексте
  @protected
  @internal
  static _JobFormState of(BuildContext context) => context.findAncestorStateOfType<_JobFormState>()!;

  /// Получить текущую работу исходя из контроллеров полей ввода
  static Job getCurrentJob(BuildContext context) => of(context).getCurrentJob();

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final TextEditingController jobTitleController = TextEditingController(text: '');
  final TextEditingController companyTitleController = TextEditingController(text: '');
  final TextEditingController locationCountryController = TextEditingController(text: '');
  final TextEditingController locationAddressController = TextEditingController(text: '');
  final TextEditingController descriptionController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _refillControllers(JobScope.jobOf(context));
  }

  void _refillControllers(Job job) {
    jobTitleController.text = job.title;
    companyTitleController.text = job.getAttribute<CompanyJobAttribute>()?.title ?? '';
    locationCountryController.text = job.getAttribute<LocationJobAttribute>()?.country ?? '';
    locationAddressController.text = job.getAttribute<LocationJobAttribute>()?.address ?? '';
    descriptionController.text = job.getAttribute<DescriptionJobAttribute>()?.description ?? '';
  }

  Job getCurrentJob() => JobScope.jobOf(context).copyWith(
        newTitle: jobTitleController.text,
        newAttributes: JobAttributes(
          <JobAttribute>[
            CompanyJobAttribute(
              title: companyTitleController.text,
            ),
            LocationJobAttribute(
              country: locationCountryController.text,
              address: locationAddressController.text,
            ),
            DescriptionJobAttribute(
              description: descriptionController.text,
            ),
          ],
        ),
      );

  @override
  void dispose() {
    jobTitleController.dispose();
    companyTitleController.dispose();
    locationCountryController.dispose();
    locationAddressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocListener<JobBLoC, JobState>(
        listener: (context, state) => _refillControllers(state.job),
        child: widget.child,
      );
}

@immutable
class JobFields extends StatelessWidget {
  const JobFields({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.findAncestorStateOfType<_JobFormState>()!;
    return ListView(
      physics: const ClampingScrollPhysics(),
      cacheExtent: MediaQuery.of(context).size.height,
      padding: EdgeInsets.symmetric(
        horizontal: math.max((MediaQuery.of(context).size.width - maxFeedWidth) / 2, 8), // 550 px - max width
        vertical: 24,
      ),
      children: <Widget>[
        /// Заголовок
        _JobTextField.singleLine(
          state.jobTitleController,
          label: 'Название',
          maxLength: 64,
          finishEditing: false,
          enabled: true,
          key: const ValueKey<String>('jobTitle'),
        ),

        /// Название компании
        _JobTextField.singleLine(
          state.companyTitleController,
          label: 'Название компании',
          key: const ValueKey<String>('companyTitle'),
        ),

        /// Местоположение
        _JobTextField.singleLine(
          state.locationCountryController,
          label: 'Страна',
          key: const ValueKey<String>('locationCountry'),
        ),
        _JobTextField.singleLine(
          state.locationAddressController,
          label: 'Адрес',
          key: const ValueKey<String>('locationAddress'),
        ),

        /// Описание
        _JobTextField.multiLine(
          state.descriptionController,
          label: 'Описание',
          maxLength: 64,
          maxLines: 12,
          finishEditing: false,
          enabled: true,
          key: const ValueKey<String>('description'),
        ),
      ],
    );
  }
}

@immutable
abstract class _JobTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool enabled;
  final bool finishEditing;

  const _JobTextField._({
    required final this.controller,
    this.label,
    this.finishEditing = false,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  const factory _JobTextField.singleLine(
    final TextEditingController controller, {
    String? label,
    int? maxLength,
    bool finishEditing,
    bool enabled,
    Key? key,
  }) = _JobSingleLineText;

  const factory _JobTextField.multiLine(
    final TextEditingController controller, {
    String? label,
    int? maxLength,
    int? maxLines,
    bool finishEditing,
    bool enabled,
    Key? key,
  }) = _JobMultiLineText;
}

class _JobSingleLineText extends _JobTextField {
  final int? maxLength;
  const _JobSingleLineText(
    final TextEditingController controller, {
    String? label,
    this.maxLength = 64,
    bool finishEditing = false,
    bool enabled = true,
    Key? key,
  }) : super._(
          controller: controller,
          label: label,
          finishEditing: finishEditing,
          enabled: enabled,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final editing = JobScope.editingOf(context, listen: true);
    final readOnly = !enabled || !editing;
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) => readOnly && value.text.isEmpty ? const SizedBox.shrink() : child!,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        enabled: !readOnly,
        maxLines: 1,
        minLines: 1,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          border: readOnly ? InputBorder.none : null,
          counterText: '',
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter,
          //LengthLimitingTextInputFormatter(maxLength),
        ],
        keyboardType: TextInputType.text,
        textInputAction: finishEditing ? TextInputAction.done : TextInputAction.next,
        onEditingComplete: () {
          if (finishEditing) {
            FocusScope.of(context).unfocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}

class _JobMultiLineText extends _JobTextField {
  final int? maxLength;
  final int? maxLines;
  const _JobMultiLineText(
    final TextEditingController controller, {
    String? label,
    this.maxLength = 1024,
    this.maxLines,
    bool finishEditing = false,
    bool enabled = true,
    Key? key,
  }) : super._(
          controller: controller,
          label: label,
          finishEditing: finishEditing,
          enabled: enabled,
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    final editing = JobScope.editingOf(context, listen: true);
    final readOnly = !enabled || !editing;
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, child) => readOnly && value.text.isEmpty ? const SizedBox.shrink() : child!,
      child: TextField(
        controller: controller,
        readOnly: readOnly,
        enabled: !readOnly,
        minLines: 4,
        maxLines: maxLines,
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        maxLength: maxLength,
        decoration: InputDecoration(
          labelText: label,
          border: readOnly ? InputBorder.none : null,
          counterText: readOnly ? '' : null,
        ),
        inputFormatters: const <TextInputFormatter>[
          //FilteringTextInputFormatter.singleLineFormatter,
          //LengthLimitingTextInputFormatter(maxLength),
        ],
        keyboardType: TextInputType.multiline,
        textInputAction: finishEditing ? TextInputAction.done : TextInputAction.newline,
        onEditingComplete: () {
          if (finishEditing) {
            FocusScope.of(context).unfocus();
          } else {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }
}
