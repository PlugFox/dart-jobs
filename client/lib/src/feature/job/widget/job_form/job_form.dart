import 'dart:async';

import 'package:dart_jobs/src/common/router/page_router.dart';
import 'package:dart_jobs/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs/src/feature/job/widget/job_form/job_form_actions.dart';
import 'package:dart_jobs/src/feature/job/widget/job_form/job_form_data.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';

@immutable
class JobForm extends StatefulWidget {
  final JobBLoC bloc;
  final Widget child;

  const JobForm({
    required this.bloc,
    required this.child,
    Key? key,
  }) : super(key: key);

  /// Получить контроллер/данные формы из контекста
  static JobFormData formDataOf(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedJobForm>()!.widget;
    return (inhW as _InheritedJobForm).formData;
  }

  /// Переключиться на чтение текущей работы
  /// Также обновить поля из переданого [Job]
  static void switchToRead(BuildContext context, JobData data) =>
      Actions.invoke<ReadJobIntent>(context, ReadJobIntent(data));

  /// Переключиться на редактирование текущей работы
  /// Также обновить поля из переданого [Job]
  static void switchToEdit(BuildContext context, JobData data) =>
      Actions.invoke<EditJobIntent>(context, EditJobIntent(data));

  /// Заблокировать форму ввода
  static void switchToDisable(BuildContext context, Job job) =>
      Actions.invoke<DisableJobIntent>(context, const DisableJobIntent());

  /// Проверить текущую работу
  /// Возвращает истину, если работа успешно заполненна
  static bool validate(BuildContext context) =>
      Actions.invoke<ValidateJobIntent>(context, const ValidateJobIntent()) == true;

  /// Обновить работу из контроллеров
  static JobData? getUpdatedJob(BuildContext context, JobData data) {
    final result = Actions.invoke<GetUpdatedJobIntent>(context, GetUpdatedJobIntent(data));
    if (result is JobData) {
      return result;
    }
    return null;
  }

  /// Сохранить текущую работу
  /// Внимание, перед вызовом этого метода - проверьте валидность заполнения работы с помощью [ValidateJobIntent]
  static void save(BuildContext context, JobData data) =>
      Actions.invoke<SaveJobIntent>(context, SaveJobIntent(data)) == true;

  /// Удалить текущую работу
  static void delete(BuildContext context) => Actions.invoke<DeleteJobIntent>(context, const DeleteJobIntent());

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  final ActionDispatcher _dispatcher = const ActionDispatcher();
  late final JobFormData _formData;
  // ignore: close_sinks
  late final JobBLoC _bloc;
  late final StreamSubscription<JobState> _subscription;

  @override
  void initState() {
    super.initState();
    // Получаем блок из контекста
    _bloc = widget.bloc;

    // Изначальное состояние формы
    _formData = JobFormData(
      data: _bloc.state.job.data,
      status: _bloc.state.maybeMap<FormStatus>(
        // Если это создание работы - редактируем, в противном случае просматриваем
        orElse: () => _bloc.state.job.hasNotID ? FormStatus.editing : FormStatus.readOnly,
        // Если сейчас выполняем действие - блокируем форму
        processed: (_) => FormStatus.processed,
      ),
    );

    // Устанавливаем коллбэки на состояния блока
    _subscription = _bloc.stream.listen(
      (state) => state.when<void>(
        saved: _onSaved,
        deleted: _onDeleted,
        error: _onError,
        notFound: _onNotFound,
        processed: _onProcessed,
        idle: _onIdle,
      ),
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void _onSaved(Job job) => _dispatcher.invokeAction(
        FetchJobAction(_formData),
        ReadJobIntent(job.data),
      );

  void _onDeleted(Job job) => PageRouter.goHome(context);

  void _onError(Job job, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    if (_formData.status.value == FormStatus.processed) {
      _formData.setState(newStatus: job.hasNotID ? FormStatus.editing : FormStatus.readOnly);
    }
  }

  void _onNotFound(Job job) {
    //PageRouter.goHome(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Not found')),
    );
  }

  void _onProcessed(Job job) => _formData.setState(newStatus: FormStatus.processed);

  void _onIdle(Job job) {
    if (_formData.status.value == FormStatus.processed) {
      _formData.setState(newStatus: job.hasNotID ? FormStatus.editing : FormStatus.readOnly);
    }
    _formData.updateFormData(job.data);
  }

  /// Сохранить/Создать работу
  void save(JobData data) => AuthenticationScope.authenticateOr(
        context,
        (user) => _bloc.add(
          _bloc.state.job.hasNotID
              ? JobEvent.create(
                  data: data,
                )
              : JobEvent.update(
                  data: data,
                ),
        ),
      );

  /// Удалить работу
  void delete() => AuthenticationScope.authenticateOr(context, (user) => _bloc.add(const JobEvent.delete()));

  @override
  Widget build(BuildContext context) => _InheritedJobForm(
        formData: _formData,
        child: Actions(
          dispatcher: _dispatcher,
          actions: <Type, Action<Intent>>{
            ReadJobIntent: FetchJobAction(_formData),
            EditJobIntent: EditJobAction(_formData),
            DisableJobIntent: DisableJobAction(_formData),
            ValidateJobIntent: ValidateJobAction(_formData),
            GetUpdatedJobIntent: GetUpdatedJobAction(_formData),
            SaveJobIntent: SaveJobAction(_formData, save),
            DeleteJobIntent: DeleteJobAction(delete),
          },
          child: widget.child,
        ),
      );
}

@immutable
class _InheritedJobForm extends InheritedWidget {
  final JobFormData formData;

  const _InheritedJobForm({
    required this.formData,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedJobForm oldWidget) => false;
}
