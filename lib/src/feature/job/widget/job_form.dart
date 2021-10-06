import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../common/constant/layout_constraints.dart';
import '../../authentication/widget/authentication_scope.dart';
import '../model/job.dart';

@immutable
class JobForm extends StatefulWidget {
  const JobForm({
    required final this.job,
    required final this.child,
    this.edit = false,
    Key? key,
  }) : super(key: key);

  final Job job;

  /// Изначальное состояние (если true - открыть форму в режиме редактирования)
  final bool edit;

  final Widget child;

  static void switchToRead(BuildContext context) =>
      context.findAncestorStateOfType<_JobFormState>()?.readOnlyController.value = true;

  static void switchToEdit(BuildContext context) =>
      context.findAncestorStateOfType<_JobFormState>()?.readOnlyController.value = false;

  static ValueListenable<bool> readOnlyStatusOf(BuildContext context) =>
      context.findAncestorStateOfType<_JobFormState>()!.readOnlyController;

  static Job currentJobOf(BuildContext context) => context.findAncestorStateOfType<_JobFormState>()!.getCurrentJob();

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final ValueNotifier<bool> readOnlyController = ValueNotifier<bool>(true);
  final TextEditingController jobTitleController = TextEditingController(text: '');
  final TextEditingController companyTitleController = TextEditingController(text: '');
  final TextEditingController locationCountryController = TextEditingController(text: '');
  final TextEditingController locationAddressController = TextEditingController(text: '');
  final TextEditingController descriptionController = TextEditingController(text: '');

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    _fillControllers();
  }

  @override
  void didUpdateWidget(covariant JobForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.job != oldWidget.job) {
      _fillControllers();
    }
  }

  void _fillControllers() {
    final job = widget.job;
    if (widget.edit && AuthenticationScope.isSameUid(context, job.creatorId)) {
      readOnlyController.value = false;
    } else {
      readOnlyController.value = true;
    }
    jobTitleController.text = job.title;
    companyTitleController.text = job.getAttribute<CompanyJobAttribute>()?.title ?? '';
    locationCountryController.text = job.getAttribute<LocationJobAttribute>()?.country ?? '';
    locationAddressController.text = job.getAttribute<LocationJobAttribute>()?.address ?? '';
    descriptionController.text = job.getAttribute<DescriptionJobAttribute>()?.description ?? '';
  }

  @override
  void dispose() {
    readOnlyController.dispose();
    jobTitleController.dispose();
    companyTitleController.dispose();
    locationCountryController.dispose();
    locationAddressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
  //endregion

  Job getCurrentJob() => widget.job.copyWith(
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
  Widget build(BuildContext context) => FocusScope(
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
        ),

        /// Местоположение
        _JobTextField.singleLine(
          state.locationCountryController,
          label: 'Страна',
        ),
        _JobTextField.singleLine(
          state.locationAddressController,
          label: 'Адрес',
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
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: context.findAncestorStateOfType<_JobFormState>()!.readOnlyController,
        builder: (context, value, child) {
          final readOnly = !enabled || value;
          if (readOnly && controller.text.isEmpty) {
            return const SizedBox.shrink();
          }
          return TextField(
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
          );
        },
      );
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
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: context.findAncestorStateOfType<_JobFormState>()!.readOnlyController,
        builder: (context, value, child) {
          final readOnly = !enabled || value;
          if (readOnly && controller.text.isEmpty) {
            return const SizedBox.shrink();
          }
          return TextField(
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
          );
        },
      );
}
