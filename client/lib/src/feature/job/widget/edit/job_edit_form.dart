import 'dart:async';
import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/country_picker.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_description_field.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_edit_buttons.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_singleline_text_field.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class JobEditForm extends StatefulWidget {
  const JobEditForm({
    Key? key,
  }) : super(key: key);

  static void reset(BuildContext context) => context.findAncestorStateOfType<_JobEditFormState>()?.reset();

  @override
  State<JobEditForm> createState() => _JobEditFormState();
}

class _JobEditFormState extends State<JobEditForm> {
  late final JobBLoC _bloc;
  StreamSubscription<JobState>? _subscription;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final ValueNotifier<Country> _countryController = ValueNotifier<Country>(Countries.unknown);
  final ValueNotifier<bool> _remoteController = ValueNotifier<bool>(true);
  final TextEditingController _englishDescriptionController = TextEditingController();
  final TextEditingController _russianDescriptionController = TextEditingController();

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<JobBLoC>(context, listen: false);
    _subscription = _bloc.stream.listen(_onStateChanged, cancelOnError: false);
    _onStateChanged(_bloc.state);
  }

  void _onStateChanged(JobState state) {
    final jobData = state.job.data;
    _titleController.text = jobData.title;
    _companyController.text = jobData.company;
    _countryController.value = Country.byCode(jobData.country);
    _remoteController.value = jobData.remote;
    _englishDescriptionController.text = jobData.englishDescription;
    _russianDescriptionController.text = jobData.russianDescription;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _titleController.dispose();
    _companyController.dispose();
    _countryController.dispose();
    _remoteController.dispose();
    _englishDescriptionController.dispose();
    _russianDescriptionController.dispose();
    super.dispose();
  }
  //endregion

  /// Сбросить контроллеры к текущему состоянию
  void reset() => _onStateChanged(_bloc.state);

  @override
  Widget build(BuildContext context) => _JobEditFormLayout(
        buttons: const JobEditButtons(),
        fields: <Widget>[
          /// Заголовок
          JobSingleLineTextField(
            key: const ValueKey<String>('title'),
            label: context.localization.job_field_title,
            controller: _titleController,
          ),

          const SizedBox(height: 12),

          /// Название компании
          JobSingleLineTextField(
            key: const ValueKey<String>('company_title'),
            label: context.localization.job_field_company_title,
            controller: _companyController,
          ),

          const SizedBox(height: 12),

          /// Страна
          CountryPicker(
            controller: _countryController,
          ),

          const SizedBox(height: 12),

          /// Заполнение текста на английском
          JobDescriptionButton(
            label: context.localization.job_field_english_description,
            controller: _englishDescriptionController,
          ),

          const SizedBox(height: 12),

          /// Заполнение текста на русском
          JobDescriptionButton(
            label: context.localization.job_field_russian_description,
            controller: _russianDescriptionController,
          ),
        ],
      );
}

@immutable
class _JobEditFormLayout extends StatelessWidget {
  const _JobEditFormLayout({
    required final this.fields,
    final this.buttons,
    Key? key,
  }) : super(key: key);

  final List<Widget> fields;
  final Widget? buttons;

  @override
  Widget build(BuildContext context) => Stack(
        alignment: Alignment.topCenter,
        children: <Positioned>[
          Positioned.fill(
            child: _JobEditFormLayoutFields(
              fields: fields,
            ),
          ),
          if (buttons != null)
            Positioned(
              height: 50,
              width: math.min(MediaQuery.of(context).size.width - 16, kBodyWidth),
              bottom: 8,
              child: buttons!,
            ),
        ],
      );
}

@immutable
class _JobEditFormLayoutFields extends StatelessWidget {
  const _JobEditFormLayoutFields({
    required final this.fields,
    Key? key,
  }) : super(key: key);

  final List<Widget> fields;

  @override
  Widget build(BuildContext context) {
    // 620 px - max width
    final horizontalPadding = math.max<double>(
      (MediaQuery.of(context).size.width - kBodyWidth) / 2,
      8,
    );
    return ListView(
      physics: const ClampingScrollPhysics(),
      cacheExtent: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(
        top: 14,
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: 90,
      ),
      children: fields,
    );
  }
}
