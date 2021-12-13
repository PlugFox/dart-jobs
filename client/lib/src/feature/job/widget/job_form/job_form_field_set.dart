import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/country_picker.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_form/job_descriptions_field.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_form/job_form.dart';
import 'package:dart_jobs_client/src/feature/job/widget/job_form/job_form_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

@immutable
class JobFormFieldSet extends StatelessWidget {
  const JobFormFieldSet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formData = JobForm.formDataOf(context);
    return Align(
      alignment: Alignment.topCenter,
      child: FocusScope(
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Positioned>[
            Positioned.fill(
              child: ListView(
                physics: const ClampingScrollPhysics(),
                cacheExtent: MediaQuery.of(context).size.height,
                padding: EdgeInsets.symmetric(
                  horizontal: math.max((MediaQuery.of(context).size.width - maxFeedWidth) / 2, 8), // 550 px - max width
                  vertical: 14,
                ),
                children: <Widget>[
                  /// Заголовок
                  _JobSingleLineText(
                    context.localization.job_field_title,
                    formData.titleController,
                    inputFormatters: <TextInputFormatter>[_denyCyrillic],
                    key: const ValueKey<String>('job_field_title'),
                  ),

                  /// Название компании
                  _JobSingleLineText(
                    context.localization.job_field_company_title,
                    formData.companyController,
                    inputFormatters: <TextInputFormatter>[_denyCyrillic],
                    key: const ValueKey<String>('job_field_company_title'),
                  ),

                  /// Страна
                  _CountryPicker(
                    controller: formData.countryController,
                  ),
                  //_JobSingleLineText(
                  //  context.localization.job_field_location_country,
                  //  formData.countryController,
                  //  inputFormatters: <TextInputFormatter>[_denyCyrillic],
                  //  key: const ValueKey<String>('job_field_location_country'),
                  //),

                  /// Адрес
                  //_JobSingleLineText(
                  //  context.localization.job_field_location_address,
                  //  formData.addressController,
                  //  inputFormatters: <TextInputFormatter>[_denyCyrillic],
                  //  key: const ValueKey<String>('job_field_location_address'),
                  //),

                  /// Удаленка
                  //formData.remoteController;

                  /// Оклад
                  //formData.salaryController;

                  const SizedBox(height: 15),

                  /// Поле описания
                  JobDescriptionsField(
                    context.localization.job_field_description,
                    formData.descriptionsController,
                  ),

                  const SizedBox(height: 75),
                ],
              ),
            ),
            Positioned(
              height: 50,
              width: math.min(MediaQuery.of(context).size.width, maxFeedWidth),
              bottom: 8,
              child: _BottomButtons(
                formData: formData,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Не разрешать ввод кирилицы
final TextInputFormatter _denyCyrillic = FilteringTextInputFormatter.deny(RegExp('[а-яА-ЯёЁ]'));

class _JobSingleLineText extends StatelessWidget {
  const _JobSingleLineText(
    final this.label,
    final this.controller, {
    this.inputFormatters = const <TextInputFormatter>[],
    final Key? key,
  }) : super(key: key);

  final String label;
  final JobTextFieldSingleLineController controller;
  final List<TextInputFormatter> inputFormatters;

  @override
  Widget build(final BuildContext context) => ValueListenableBuilder<FormStatus>(
        valueListenable: JobForm.formDataOf(context).status,
        builder: (context, status, _) => Opacity(
          opacity: status == FormStatus.processed ? 0.5 : 1,
          child: ValueListenableBuilder<String?>(
            valueListenable: controller.error,
            builder: (context, errorText, _) => TextField(
              controller: controller,
              enabled: status == FormStatus.editing,
              readOnly: status != FormStatus.editing,
              focusNode: controller.focusNode,
              minLines: 1,
              maxLines: 1,
              maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
              maxLength: controller.maxLength,
              decoration: InputDecoration(
                labelText: label,
                border: status != FormStatus.editing ? InputBorder.none : null,
                counterText: '',
                errorText: errorText,
              ),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter,
                //LengthLimitingTextInputFormatter(maxLength),
                ...inputFormatters,
              ],
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              onEditingComplete: () => FocusScope.of(context).nextFocus(),
            ),
          ),
        ),
      );
}

@immutable
class _CountryPicker extends StatelessWidget {
  const _CountryPicker({
    required this.controller,
    Key? key,
  }) : super(key: key);

  final JobFieldCountryController controller;

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<FormStatus>(
        valueListenable: JobForm.formDataOf(context).status,
        builder: (context, status, _) => CountryPicker(
          controller: controller,
          enabled: status == FormStatus.editing,
        ),
      );
}

@immutable
class _BottomButtons extends StatelessWidget {
  const _BottomButtons({
    required final this.formData,
    Key? key,
  }) : super(key: key);
  final JobFormData formData;

  @override
  Widget build(BuildContext context) => AuthenticationScope.userOf(context, listen: true).when<Widget>(
        authenticated: (user) => BlocBuilder<JobBLoC, JobState>(
          builder: (context, state) =>
              state.job.creatorId != user.uid ? const SizedBox.shrink() : _BottomButtonsRow(formData: formData),
        ),
        notAuthenticated: () => const SizedBox.shrink(),
      );
}

@immutable
class _BottomButtonsRow extends StatelessWidget {
  const _BottomButtonsRow({
    required final this.formData,
    Key? key,
  }) : super(key: key);
  final JobFormData formData;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 0,
            horizontal: 8,
          ),
          child: Center(
            child: BlocBuilder<JobBLoC, JobState>(
              builder: (context, state) => ValueListenableBuilder<FormStatus>(
                valueListenable: formData.status,
                builder: (context, status, _) => ValueListenableBuilder<bool>(
                  valueListenable: formData.isDirty,
                  builder: (context, isDirty, _) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      if (status == FormStatus.readOnly) const Expanded(child: _EditButton()),
                      if (status == FormStatus.editing && state.job.hasID) const Expanded(child: _CancelButton()),
                      if (status == FormStatus.editing)
                        Expanded(
                          child: _SaveButton(
                            enabled: isDirty,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}

@immutable
class _EditButton extends StatelessWidget {
  const _EditButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 8,
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            FocusScope.of(context).unfocus();
            JobForm.switchToEdit(
              context,
              BlocProvider.of<JobBLoC>(
                context,
                listen: false,
              ).state.job.data,
            );
          },
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
        ),
      );
}

@immutable
class _CancelButton extends StatelessWidget {
  const _CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 8,
        ),
        child: OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          ),
          onPressed: () {
            FocusScope.of(context).unfocus();
            JobForm.switchToRead(
              context,
              BlocProvider.of<JobBLoC>(
                context,
                listen: false,
              ).state.job.data,
            );
          },
          icon: const Icon(Icons.cancel),
          label: const Text('Cancel'),
        ),
      );
}

@immutable
class _SaveButton extends StatelessWidget {
  const _SaveButton({
    final this.enabled = true,
    Key? key,
  }) : super(key: key);
  final bool enabled;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 8,
        ),
        child: ElevatedButton.icon(
          onPressed: enabled
              ? () {
                  FocusScope.of(context).unfocus();
                  if (!JobForm.validate(context)) {
                    l.i('Работа не до заполнена, не будет сохранена');
                    return;
                  }
                  final job = JobForm.getUpdatedJob(
                    context,
                    BlocProvider.of<JobBLoC>(context, listen: false).state.job.data,
                  );
                  if (job == null) {
                    l.i('Отсутсвует работа, не будет сохранена');
                    return;
                  }
                  JobForm.save(context, job);
                }
              : null,
          icon: const Icon(Icons.save),
          label: const Text('Save'),
        ),
      );
}
