import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:money2/money2.dart';

import '../../../../../../../shared/lib/src/models/job.dart';
import '../../../../../../../shared/lib/src/utils/money_util.dart';

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
  ValueListenable<Job> get lastJob => _lastJob;
  final ValueNotifier<Job> _lastJob;

  /// СПИСОК КОНТРОЛЛЕРОВ ВВОДА ФОРМЫ - НАЧАЛО

  final List<JobInputControllerMixin> _controllers = <JobInputControllerMixin>[];
  final JobFieldTitleController titleController = JobFieldTitleController();
  final JobFieldCompanyController companyController = JobFieldCompanyController();
  final JobFieldCountryController countryController = JobFieldCountryController();
  final JobFieldLocationController locationController = JobFieldLocationController();
  final JobFieldRemoteController remoteController = JobFieldRemoteController();
  final JobFieldSalaryController salaryController = JobFieldSalaryController();

  /// СПИСОК КОНТРОЛЛЕРОВ ВВОДА ФОРМЫ - КОНЕЦ

  JobFormData({
    required final Job job,
    required final FormStatus status,
  })  : _isDirty = ValueNotifier<bool>(false),
        _status = ValueNotifier<FormStatus>(status),
        _lastJob = ValueNotifier<Job>(job) {
    updateFormData(job);
    _controllers.addAll(
      <JobInputControllerMixin>[
        titleController,
        companyController,
        countryController,
        locationController,
        remoteController,
        salaryController,
      ],
    );
    for (final controller in _controllers) {
      controller.addListener(() {
        _isDirty.value = true;
      });
    }
  }

  /// Обновить контроллеры из актуального значения работы
  void updateFormData(Job job) {
    for (final controller in _controllers) {
      controller.update(job);
    }
    if (job.isEmpty) {
      _status.value = FormStatus.editing;
    }
    _lastJob.value = job;
    _isDirty.value = false;
  }

  /// Обновить работу из текущего состояния контроллеров
  Job updateJob(Job job) => _lastJob.value = job.copyWith(
        newTitle: titleController.text,
        newCompany: companyController.text,
        newCountry: countryController.text,
        newLocation: locationController.text,
        newRemote: remoteController.value,
        newSalaryFrom: salaryController.value.from,
        newSalaryTo: salaryController.value.to,
        newAttributes: const JobAttributes.empty(),

        /// TODO: реализовать добавление аттрибутов
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

  void update(Job job);
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
  void update(Job job) => text = job.title;
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
  void update(Job job) => text = job.company;
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
  void update(Job job) => text = job.country;
}

/// Location controller
class JobFieldLocationController extends TextEditingController
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
  void update(Job job) => text = job.location;
}

/// Remote controller
class JobFieldRemoteController extends ValueNotifier<bool> with JobInputControllerMixin<bool> {
  JobFieldRemoteController() : super(true);

  @override
  String? checkValue(bool value) => null;

  @override
  void update(Job job) => value = job.remote;
}

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
  void update(Job job) => value = MoneyTuple(job.salaryFrom, job.salaryTo);
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

/// TODO: JobAttributes
