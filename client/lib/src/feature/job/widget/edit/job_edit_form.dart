import 'dart:async';
import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/country_picker.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_description_field.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_edit_buttons.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_employments_input.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_levels_input.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_relocation_input.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_remote_input.dart';
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

  static JobData? getJobDataOrNull(BuildContext context) =>
      context.findAncestorStateOfType<_JobEditFormState>()!.getJobDataOrNull();

  @override
  State<JobEditForm> createState() => _JobEditFormState();
}

class _JobEditFormState extends State<JobEditForm> {
  late final JobBLoC _bloc;

  StreamSubscription<JobState>? _subscription;

  /// TODO: добавить контроллеры ошибок формы
  final TextEditingController _titleController = TextEditingController();
  final FocusNode _titleFocus = FocusNode();
  final TextEditingController _companyController = TextEditingController();
  final FocusNode _companyFocus = FocusNode();
  final ValueNotifier<Country> _countryController = ValueNotifier<Country>(Countries.unknown);
  final TextEditingController _addressController = TextEditingController();
  final FocusNode _addressFocus = FocusNode();
  final ValueNotifier<bool> _remoteController = ValueNotifier<bool>(true);
  final TextEditingController _englishDescriptionController = TextEditingController();
  final TextEditingController _russianDescriptionController = TextEditingController();
  final ValueNotifier<List<DeveloperLevel>> _levelsController = ValueNotifier<List<DeveloperLevel>>(<DeveloperLevel>[]);
  final ValueNotifier<List<String>> _skillsController = ValueNotifier<List<String>>(<String>[]);
  final ValueNotifier<Relocation> _relocationController = ValueNotifier<Relocation>(const Relocation.possible());
  final ValueNotifier<List<String>> _contactsController = ValueNotifier<List<String>>(<String>[]);
  final ValueNotifier<List<Employment>> _employmentsController = ValueNotifier<List<Employment>>(<Employment>[]);
  final ValueNotifier<List<String>> _tagsController = ValueNotifier<List<String>>(<String>[]);

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
    _addressController.text = jobData.address;
    _remoteController.value = jobData.remote;
    _englishDescriptionController.text = jobData.englishDescription;
    _russianDescriptionController.text = jobData.russianDescription;
    _levelsController.value = List<DeveloperLevel>.of(jobData.levels);
    _skillsController.value = List<String>.of(jobData.skills);
    _relocationController.value = jobData.relocation;
    _contactsController.value = List<String>.of(jobData.contacts);
    _employmentsController.value = List<Employment>.of(jobData.employments);
    _tagsController.value = List<String>.of(jobData.tags);
  }

  JobData? getJobDataOrNull() {
    final errors = <String>[];
    final localization = context.localization;
    if (_titleController.text.isEmpty) {
      if (errors.isEmpty) {
        _titleFocus.requestFocus();
      }
      errors.add(localization.job_form_error_title);
    }
    if (_companyController.text.isEmpty) {
      if (errors.isEmpty) {
        _companyFocus.requestFocus();
      }
      errors.add(localization.job_form_error_company);
    }
    if (_countryController.value == Countries.unknown) {
      errors.add(localization.job_form_error_country);
    }
    if (_englishDescriptionController.text.isEmpty && _russianDescriptionController.text.isEmpty) {
      errors.add(localization.job_form_error_description);
    }
    if (_levelsController.value.isEmpty) {
      errors.add(localization.job_form_error_levels);
    }
    if (_employmentsController.value.isEmpty) {
      errors.add(localization.job_form_error_employments);
    }
    if (errors.isNotEmpty) {
      _showSnackBarError(errors);
      return null;
    }
    return _bloc.state.job.data.copyWith(
      title: _titleController.text,
      company: _companyController.text,
      country: _countryController.value.code,
      remote: _remoteController.value,
      relocation: _relocationController.value,
      address: _addressController.text,
      descriptions: Description.fromLanguages(
        english: _englishDescriptionController.text,
        russian: _russianDescriptionController.text,
      ),
      levels: _levelsController.value,
      skills: _skillsController.value,
      contacts: _contactsController.value,
      employments: _employmentsController.value,
      tags: _tagsController.value,
    );
  }

  void _showSnackBarError(List<String> errors) {
    final length = errors.length;
    if (length < 1) return;
    final error = context.localization.job_form_error;
    //final theme = Theme.of(context);
    //ScaffoldFeatureController? controller;
    //controller =
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        //action: length > 1
        //    ? SnackBarAction(
        //        label: '${context.localization.next} ($length)',
        //        textColor: Colors.white,
        //        onPressed: () {
        //          controller?.close();
        //          _showSnackBarError(errors.sublist(1));
        //        },
        //      )
        //    : null,
        backgroundColor: Colors.redAccent,
        content: SizedBox(
          height: 48,
          child: Center(
            child: Text(
              error,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        duration: const Duration(milliseconds: 6000),
        margin: EdgeInsets.symmetric(
          horizontal: math.max<double>(
            (MediaQuery.of(context).size.width - kBodyWidth) / 2 + 4,
            12,
          ),
          vertical: 16,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _titleController.dispose();
    _titleFocus.dispose();
    _companyController.dispose();
    _companyFocus.dispose();
    _countryController.dispose();
    _addressController.dispose();
    _addressFocus.dispose();
    _remoteController.dispose();
    _englishDescriptionController.dispose();
    _russianDescriptionController.dispose();
    _levelsController.dispose();
    _skillsController.dispose();
    _relocationController.dispose();
    _contactsController.dispose();
    _employmentsController.dispose();
    _tagsController.dispose();
    super.dispose();
  }
  //endregion

  /// Сбросить контроллеры к текущему состоянию
  void reset() => _onStateChanged(_bloc.state);

  /// TODO: оформить поля через InputDecorator
  @override
  Widget build(BuildContext context) {
    final localization = context.localization;
    final ru = context.locale.languageCode == 'ru';
    final optional = localization.optional.toLowerCase();
    return _JobEditFormLayout(
      buttons: const JobEditButtons(),
      fields: <Widget>[
        /// Заголовок
        JobSingleLineTextField(
          key: const ValueKey<String>('title'),
          label: '${localization.job_field_title}${ru ? ' (на английском)' : ''}',
          hint: 'Flutter/Dart Developer', // _WorkTitleRandomizer.instance().next(),
          controller: _titleController,
          focusNode: _titleFocus,
        ),

        /// Название компании
        JobSingleLineTextField(
          key: const ValueKey<String>('company_title'),
          label: localization.job_field_company_title,
          hint: 'Google',
          controller: _companyController,
          focusNode: _companyFocus,
          denyCyrillic: false,
        ),

        /// Местоположение
        JobSingleLineTextField(
          key: const ValueKey<String>('address'),
          label: '${localization.job_field_location_address} ($optional)',
          hint: 'California, USA',
          controller: _addressController,
          focusNode: _addressFocus,
          maxLength: 256,
          next: false,
          denyCyrillic: false,
        ),

        /// Страна
        CountryPicker(
          controller: _countryController,
        ),

        /// Удаленная работа
        JobRemoteInput(
          controller: _remoteController,
        ),

        /// Ожидаемый уровень разработчика
        JobLevelsInput(
          controller: _levelsController,
        ),

        /// Возможное трудоустройство
        JobEmploymentsInput(
          controller: _employmentsController,
        ),

        /// Возможность релокации
        JobRelocationInput(
          controller: _relocationController,
        ),

        /// Заполнение текста на английском
        JobDescriptionInput(
          title: localization.job_field_english_description,
          label: '${localization.job_field_english_description} ($optional)',
          controller: _englishDescriptionController,
        ),

        /// Заполнение текста на русском
        JobDescriptionInput(
          title: localization.job_field_russian_description,
          label: '${localization.job_field_russian_description} ($optional)',
          controller: _russianDescriptionController,
          denyCyrillic: false,
        ),

        /// TODO: Дополнительные условия
        /// skillsController: _skillsController,
        /// contactsController: _contactsController,
        /// contactsController: _tagsController,
      ],
    );
  }
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
              height: 48,
              width: math.min(MediaQuery.of(context).size.width - 32, kBodyWidth),
              bottom: 16,
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
    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      cacheExtent: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(
        top: 14,
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: 80,
      ),
      itemCount: fields.length,
      itemBuilder: (context, index) => Center(child: fields[index]),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 12),
    );
  }
}

// ignore: unused_element
class _WorkTitleRandomizer {
  _WorkTitleRandomizer._();
  static _WorkTitleRandomizer? _instance;
  // ignore: unused_element
  factory _WorkTitleRandomizer.instance() => _instance ??= _WorkTitleRandomizer._();
  static const List<String> _variants = <String>[
    'Best work ever',
    'Your ad is here',
    "Let's work together",
    'Dart superhero required',
    'Most wanted',
    'Payment by cookies',
    'Hiring for everyone',
    'Dart goez fasta, brrr',
  ];
  final math.Random _rnd = math.Random();
  final int _max = _variants.length - 1;
  String next() => _variants[_rnd.nextInt(_max)];
}
