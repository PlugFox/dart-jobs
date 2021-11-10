import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

class JobFormData {
  /// Форма грязная (измененная) и требуется сохранение
  ValueListenable<bool> get isDirty => _isDirty;
  final ValueNotifier<bool> _isDirty;

  /// Текущий статус формы: чтение, заблокирована, редактирование
  ValueListenable<FormStatus> get status => _status;
  final ValueNotifier<FormStatus> _status;

  /// Работа (значение обновляется только при получении или установке реузультата)
  /// Лучше вместо этого использовать `BlocScope.of<JobBLoC>(context).state.job` или BlocBuilder
  /// Для получения состояния текущей работы у стейт машины
  ValueListenable<JobData> get lastJob => _lastJob;
  final ValueNotifier<JobData> _lastJob;

  /// СПИСОК КОНТРОЛЛЕРОВ ВВОДА ФОРМЫ - НАЧАЛО

  final List<JobInputControllerMixin> _controllers = <JobInputControllerMixin>[];
  final JobFieldTitleController titleController = JobFieldTitleController();
  final JobFieldCompanyController companyController = JobFieldCompanyController();
  final JobFieldCountryController countryController = JobFieldCountryController();
  final JobFieldAddressController addressController = JobFieldAddressController();
  final JobFieldRemoteController remoteController = JobFieldRemoteController();
  final JobFieldTagsController tagsController = JobFieldTagsController();
  final JobFieldSkillsController skillsController = JobFieldSkillsController();
  final JobFieldLevelsController levelsController = JobFieldLevelsController();
  final JobFieldEmploymentController employmentController = JobFieldEmploymentController();
  final JobFieldContactsController contactsController = JobFieldContactsController();
  final JobFieldDescriptionsController descriptionsController = JobFieldDescriptionsController();

  /// СПИСОК КОНТРОЛЛЕРОВ ВВОДА ФОРМЫ - КОНЕЦ

  JobFormData({
    required final JobData data,
    required final FormStatus status,
  })  : _isDirty = ValueNotifier<bool>(false),
        _status = ValueNotifier<FormStatus>(status),
        _lastJob = ValueNotifier<JobData>(data) {
    updateFormData(data);
    _controllers.addAll(
      <JobInputControllerMixin>[
        titleController,
        companyController,
        countryController,
        addressController,
        remoteController,
        tagsController,
        skillsController,
        levelsController,
        employmentController,
        contactsController,
        descriptionsController,
      ],
    );
    for (final controller in _controllers) {
      controller.addListener(() {
        _isDirty.value = true;
      });
    }
  }

  /// Обновить контроллеры из актуального значения работы
  void updateFormData(JobData data) {
    for (final controller in _controllers) {
      controller.update(data);
    }
    _lastJob.value = data;
    _isDirty.value = false;
  }

  /// Обновить работу из текущего состояния контроллеров
  JobData updateJob(JobData data) => _lastJob.value = data.copyWith(
        title: titleController.text,
        company: companyController.text,
        country: countryController.text,
        address: addressController.text,
        remote: remoteController.value,
        tags: tagsController.value,
        skills: skillsController.value,
        levels: levelsController.value,
        employment: employmentController.value,
        descriptions: descriptionsController.value,
        contacts: contactsController.value,
      );

  /// Проверить заполненние контроллеров
  /// Если все верно и достаточно для сохранения работы - true
  bool validate() {
    var result = true;
    for (final controller in _controllers) {
      result = controller.validate() && result;
    }
    return result;
  }

  /// Установить новое состояние
  @internal
  @nonVirtual
  void setState({
    final bool? newIsDirty,
    final FormStatus? newStatus,
  }) {
    if (newIsDirty != null) _isDirty.value = newIsDirty;
    if (newStatus != null) _status.value = newStatus;
  }

  @mustCallSuper
  void dispose() {
    _isDirty.dispose();
    _status.dispose();
    for (final controller in _controllers) {
      controller.dispose();
    }
  }
}

/// Состояние формы
enum FormStatus {
  /// Обрабатывается / не доступна
  /// (во время обновления, сохранения, удаления и загрузки)
  processed,

  /// Только чтение
  readOnly,

  /// Редактирование
  editing,
}

/// Миксин для всех контроллеров
mixin JobInputControllerMixin<T extends Object> implements ValueNotifier<T> {
  /// Лиснер отвечающий за ошибки
  /// Если есть строка - ошибка
  /// Если null - ошибки нет
  ValueListenable<String?> get error => _error;
  final ValueNotifier<String?> _error = ValueNotifier<String?>(null);

  /// Фокус нода для установки соответсвующему полю
  final FocusNode focusNode = FocusNode();

  /// Проверить заполненние
  /// Если все верно и достаточно для сохранения работы - null
  /// В противном случае - текст ошибки
  @visibleForOverriding
  String? checkValue(T value);

  @protected
  @nonVirtual
  bool validate() {
    final result = checkValue(value);
    _error.value = result;
    return result == null;
  }

  void update(JobData data);
}

abstract class JobTextFieldSingleLineController
    implements TextEditingController, JobInputControllerMixin<TextEditingValue> {
  /// Максимальная длинна поля ввода
  int get maxLength;
}

/// Title controller
class JobFieldTitleController extends TextEditingController
    with JobInputControllerMixin<TextEditingValue>
    implements JobTextFieldSingleLineController {
  @override
  final int maxLength = 64;

  @override
  String? checkValue(TextEditingValue value) {
    final text = value.text.trim();
    if (text.isEmpty) return 'Must be filled';
    if (text.length > maxLength) return 'Must be less than 65 characters';
    return null;
  }

  @override
  void update(JobData data) => text = data.title;
}

/// Company controller
class JobFieldCompanyController extends TextEditingController
    with JobInputControllerMixin<TextEditingValue>
    implements JobTextFieldSingleLineController {
  @override
  final int maxLength = 64;

  @override
  String? checkValue(TextEditingValue value) {
    final text = value.text.trim();
    if (text.isEmpty) return 'Must be filled';
    if (text.length > maxLength) return 'Must be less than 65 characters';
    return null;
  }

  @override
  void update(JobData data) => text = data.company;
}

/// Country controller
class JobFieldCountryController extends TextEditingController
    with JobInputControllerMixin<TextEditingValue>
    implements JobTextFieldSingleLineController {
  @override
  final int maxLength = 64;

  @override
  String? checkValue(TextEditingValue value) {
    final text = value.text.trim();
    if (text.isEmpty) return 'Must be filled';
    if (text.length > maxLength) return 'Must be less than 65 characters';
    return null;
  }

  @override
  void update(JobData data) => text = data.country;
}

/// Location controller
class JobFieldAddressController extends TextEditingController
    with JobInputControllerMixin<TextEditingValue>
    implements JobTextFieldSingleLineController {
  @override
  final int maxLength = 64;

  @override
  String? checkValue(TextEditingValue value) {
    final text = value.text.trim();
    if (text.length > maxLength) return 'Must be less than 65 characters';
    return null;
  }

  @override
  void update(JobData data) => text = data.address;
}

/// Remote controller
class JobFieldRemoteController extends ValueNotifier<bool> with JobInputControllerMixin<bool> {
  JobFieldRemoteController() : super(true);

  @override
  String? checkValue(bool value) => null;

  @override
  void update(JobData data) => value = data.remote;
}

/// Tags controller
class JobFieldTagsController extends ValueNotifier<List<String>> with JobInputControllerMixin<List<String>> {
  JobFieldTagsController() : super(<String>[]);

  @override
  String? checkValue(List<String> value) => null;

  @override
  void update(JobData data) => value = data.tags;
}

/// Skills controller
class JobFieldSkillsController extends ValueNotifier<List<Skill>> with JobInputControllerMixin<List<Skill>> {
  JobFieldSkillsController() : super(<Skill>[]);

  @override
  String? checkValue(List<Skill> value) => null;

  @override
  void update(JobData data) => value = data.skills;
}

/// Levels controller
class JobFieldLevelsController extends ValueNotifier<List<DeveloperLevel>>
    with JobInputControllerMixin<List<DeveloperLevel>> {
  JobFieldLevelsController() : super(<DeveloperLevel>[]);

  @override
  String? checkValue(List<DeveloperLevel> value) => null;

  @override
  void update(JobData data) => value = data.levels;
}

/// Employment controller
class JobFieldEmploymentController extends ValueNotifier<List<Employment>>
    with JobInputControllerMixin<List<Employment>> {
  JobFieldEmploymentController() : super(<Employment>[]);

  @override
  String? checkValue(List<Employment> value) => null;

  @override
  void update(JobData data) => value = data.employment;
}

/// Contacts controller
class JobFieldContactsController extends ValueNotifier<List<Contact>> with JobInputControllerMixin<List<Contact>> {
  JobFieldContactsController() : super(<Contact>[]);

  @override
  String? checkValue(List<Contact> value) => null;

  @override
  void update(JobData data) => value = data.contacts;
}

/// Descriptions controller
class JobFieldDescriptionsController extends ChangeNotifier
    with JobInputControllerMixin<Description>
    implements ValueListenable<Description> {
  JobFieldDescriptionsController();

  /// Русский язык
  final TextEditingController russian = TextEditingController(text: '');

  /// Английский язык
  final TextEditingController english = TextEditingController(text: '');

  @override
  String? checkValue(Description value) {
    final ru = russian.text.trim();
    final en = english.text.trim();
    if (ru.isEmpty && en.isEmpty) {
      return 'Must be filled';
    } else if (ru.length > 2600 || en.length > 2600) {
      return 'Must be less than 2601 characters';
    }
  }

  @override
  Description get value => Description(
        <String, String>{
          'en': english.text.trim(),
          'ru': russian.text.trim(),
        },
      );

  @override
  set value(Description value) {
    russian.text = value['ru']?.trim() ?? '';
    english.text = value['en']?.trim() ?? '';
    notifyListeners();
  }

  @override
  void update(JobData data) => value = data.descriptions;

  @override
  void dispose() {
    russian.dispose();
    english.dispose();
    super.dispose();
  }
}

/*
/// Salary From - To controller
class JobFieldSalaryController extends ValueNotifier<MoneyTuple> with JobInputControllerMixin<MoneyTuple> {
  JobFieldSalaryController() : super(MoneyTuple.undefine());

  @override
  String? checkValue(MoneyTuple value) {
    if (value.from > value.to) return 'From must be lower then To';
    if (value.from.minorUnits.toInt() > 100000000) return 'Too much';
    if (value.to.minorUnits.toInt() > 100000000) return 'Too much';
    return null;
  }

  @override
  void update(JobData data) => value = MoneyTuple(data.salaryFrom, data.salaryTo);
}
/// Salary tuple
/// Контроллер зарплатной вилки
class MoneyTuple {
  MoneyTuple(final Money from, final Money to)
      : from = from > to ? to : from,
        to = from > to ? from : to;

  MoneyTuple.undefine()
      : from = MoneyUtil.zeroMoney,
        to = MoneyUtil.zeroMoney;

  /// Зарплата начиная с
  final Money from;

  /// Зарплата заканчивая по
  final Money to;
}
*/
