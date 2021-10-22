import 'dart:math' as math;

import 'package:dart_jobs/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs/src/common/localization/localizations.dart';
import 'package:dart_jobs/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs/src/feature/job/widget/job_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:meta/meta.dart';

@immutable
class JobForm extends StatefulWidget {
  final Widget child;
  const JobForm({
    required this.child,
    final Key? key,
  }) : super(key: key);

  /// Для поиска _JobFormState в контексте
  @protected
  @internal
  static _JobFormState of(final BuildContext context) => context.findAncestorStateOfType<_JobFormState>()!;

  /// Получить текущую работу исходя из контроллеров полей ввода
  static Job getCurrentJob(final BuildContext context) => of(context).getCurrentJob();

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final TextEditingController jobTitleController = TextEditingController(text: '');
  final TextEditingController companyTitleController = TextEditingController(text: '');
  final TextEditingController locationCountryController = TextEditingController(text: '');
  final TextEditingController locationAddressController = TextEditingController(text: '');
  final TextEditingController descriptionController = TextEditingController(text: '');
  final TextEditingController descriptionRuController = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    _refillControllers(JobScope.jobOf(context));
  }

  void _refillControllers(final Job job) {
    jobTitleController.text = job.title;
    companyTitleController.text = job.getAttribute<CompanyJobAttribute>(CompanyJobAttribute.signature)?.title ?? '';
    locationCountryController.text =
        job.getAttribute<LocationJobAttribute>(LocationJobAttribute.signature)?.country ?? '';
    locationAddressController.text =
        job.getAttribute<LocationJobAttribute>(LocationJobAttribute.signature)?.address ?? '';
    descriptionController.text =
        job.getAttribute<DescriptionJobAttribute>(DescriptionJobAttribute.signature)?.description ?? '';
    descriptionRuController.text =
        job.getAttribute<DescriptionRuJobAttribute>(DescriptionRuJobAttribute.signature)?.description ?? '';
  }

  Job getCurrentJob() => JobScope.jobOf(context).copyWith(
        newTitle: jobTitleController.text.trim(),
        newAttributes: JobAttributes(
          <JobAttribute>[
            CompanyJobAttribute(
              title: companyTitleController.text.trim(),
            ),
            LocationJobAttribute(
              country: locationCountryController.text.trim(),
              address: locationAddressController.text.trim(),
            ),
            DescriptionJobAttribute(
              description: descriptionController.text.trim(),
            ),
            DescriptionRuJobAttribute(
              description: descriptionRuController.text.trim(),
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
    descriptionRuController.dispose();
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) => BlocListener<JobBLoC, JobState>(
        listener: (final context, final state) => _refillControllers(state.job),
        child: widget.child,
      );
}

@immutable
class JobFields extends StatelessWidget {
  const JobFields({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
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
          label: context.localization.job_field_title,
          maxLength: 64,
          finishEditing: false,
          inputFormatters: <TextInputFormatter>[_denyCyrillic],
          enabled: true,
          key: const ValueKey<String>('jobTitle'),
        ),

        /// Название компании
        _JobTextField.singleLine(
          state.companyTitleController,
          label: context.localization.job_field_company_title,
          key: const ValueKey<String>('companyTitle'),
        ),

        /// Местоположение
        _JobTextField.singleLine(
          state.locationCountryController,
          label: context.localization.job_field_location_country,
          inputFormatters: <TextInputFormatter>[_denyCyrillic],
          key: const ValueKey<String>('locationCountry'),
        ),

        _JobTextField.singleLine(
          state.locationAddressController,
          label: context.localization.job_field_location_address,
          inputFormatters: <TextInputFormatter>[_denyCyrillic],
          key: const ValueKey<String>('locationAddress'),
        ),

        /// Описание на английском
        _JobTextField.multiLine(
          state.descriptionController,
          label: context.localization.job_field_description,
          maxLength: 2600,
          maxLines: 12,
          finishEditing: false,
          enabled: true,
          inputFormatters: <TextInputFormatter>[_denyCyrillic],
          key: const ValueKey<String>('description'),
        ),

        /// Описание на русском
        _JobTextField.multiLine(
          state.descriptionRuController,
          label: context.localization.job_field_description,
          maxLength: 2600,
          maxLines: 12,
          finishEditing: false,
          enabled: true,
          key: const ValueKey<String>('description_ru'),
        ),
      ],
    );
  }
}

final _denyCyrillic = FilteringTextInputFormatter.deny(RegExp('[а-яА-Я]'));

@immutable
abstract class _JobTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? label;
  final bool enabled;
  final bool finishEditing;
  final List<TextInputFormatter> inputFormatters;

  const _JobTextField._({
    required final this.controller,
    this.label,
    this.finishEditing = false,
    this.enabled = true,
    this.inputFormatters = const <TextInputFormatter>[],
    final Key? key,
  }) : super(key: key);

  const factory _JobTextField.singleLine(
    final TextEditingController controller, {
    final String? label,
    final int? maxLength,
    final bool finishEditing,
    final bool enabled,
    final List<TextInputFormatter> inputFormatters,
    final Key? key,
  }) = _JobSingleLineText;

  const factory _JobTextField.multiLine(
    final TextEditingController controller, {
    final String? label,
    final int? maxLength,
    final int? maxLines,
    final bool finishEditing,
    final bool enabled,
    final List<TextInputFormatter> inputFormatters,
    final Key? key,
  }) = _JobMultiLineText;
}

class _JobSingleLineText extends _JobTextField {
  final int? maxLength;
  const _JobSingleLineText(
    final TextEditingController controller, {
    final String? label,
    this.maxLength = 64,
    bool finishEditing = false,
    bool enabled = true,
    List<TextInputFormatter> inputFormatters = const <TextInputFormatter>[],
    final Key? key,
  }) : super._(
          controller: controller,
          label: label,
          finishEditing: finishEditing,
          enabled: enabled,
          inputFormatters: inputFormatters,
          key: key,
        );

  @override
  Widget build(final BuildContext context) {
    final editing = JobScope.editingOf(context, listen: true);
    final readOnly = !enabled || !editing;
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (final context, final value, final child) =>
          readOnly && value.text.isEmpty ? const SizedBox.shrink() : child!,
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
          ...inputFormatters,
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
    final String? label,
    this.maxLength = 1024,
    this.maxLines,
    bool finishEditing = false,
    bool enabled = true,
    List<TextInputFormatter> inputFormatters = const <TextInputFormatter>[],
    final Key? key,
  }) : super._(
          controller: controller,
          label: label,
          finishEditing: finishEditing,
          enabled: enabled,
          inputFormatters: inputFormatters,
          key: key,
        );

  @override
  Widget build(final BuildContext context) {
    final editing = JobScope.editingOf(context, listen: true);
    final readOnly = !enabled || !editing;
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (final context, final value, final child) =>
          readOnly && value.text.isEmpty ? const SizedBox.shrink() : child!,
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
        inputFormatters: inputFormatters,
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
