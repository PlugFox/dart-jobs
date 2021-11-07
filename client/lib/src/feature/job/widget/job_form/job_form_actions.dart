import 'package:dart_jobs/src/feature/job/widget/job_form/job_form_data.dart';
import 'package:dart_jobs_shared/models.dart';
import 'package:flutter/widgets.dart';

/// READ
class ReadJobIntent extends Intent {
  const ReadJobIntent(this.data);

  final JobData data;
}

class FetchJobAction extends Action<ReadJobIntent> {
  FetchJobAction(JobFormData formData) : _formData = formData;

  final JobFormData _formData;

  @override
  void invoke(covariant ReadJobIntent intent) {
    _formData
      ..updateFormData(intent.data)
      ..setState(newStatus: FormStatus.readOnly);
  }
}

/// EDIT
class EditJobIntent extends Intent {
  const EditJobIntent(this.data);

  final JobData data;
}

class EditJobAction extends Action<EditJobIntent> {
  EditJobAction(
    JobFormData formData,
  ) : _formData = formData;

  final JobFormData _formData;

  @override
  void invoke(covariant EditJobIntent intent) {
    _formData
      ..updateFormData(intent.data)
      ..setState(newStatus: FormStatus.editing);
  }
}

/// DISABLE
class DisableJobIntent extends Intent {
  const DisableJobIntent();
}

class DisableJobAction extends Action<DisableJobIntent> {
  DisableJobAction(
    JobFormData formData,
  ) : _formData = formData;

  final JobFormData _formData;

  @override
  void invoke(covariant DisableJobIntent intent) {
    _formData.setState(newStatus: FormStatus.processed);
  }
}

/// VALIDATE
class ValidateJobIntent extends Intent {
  const ValidateJobIntent();
}

class ValidateJobAction extends Action<ValidateJobIntent> {
  ValidateJobAction(JobFormData formData) : _formData = formData;

  final JobFormData _formData;

  @override
  bool invoke(covariant ValidateJobIntent intent) => _formData.validate();
}

/// GET UPDATED JOB FROM CONTROLLER
class GetUpdatedJobIntent extends Intent {
  const GetUpdatedJobIntent(this.data);

  final JobData data;
}

class GetUpdatedJobAction extends Action<GetUpdatedJobIntent> {
  GetUpdatedJobAction(JobFormData formData) : _formData = formData;

  final JobFormData _formData;

  @override
  JobData invoke(covariant GetUpdatedJobIntent intent) => _formData.updateJob(intent.data);
}

/// SAVE
/// Внимание, перед вызовом этого метода - проверьте
/// валидность заполнения работы с помощью [ValidateJobIntent]
class SaveJobIntent extends Intent {
  const SaveJobIntent(this.data);

  final JobData data;
}

class SaveJobAction extends Action<SaveJobIntent> {
  SaveJobAction(
    JobFormData formData,
    void Function(JobData data) save,
  )   : _formData = formData,
        _save = save;

  final JobFormData _formData;
  final void Function(JobData data) _save;

  @override
  void invoke(covariant SaveJobIntent intent) {
    if (!_formData.validate()) {
      return;
    }
    final newJob = _formData.updateJob(intent.data);
    _save(newJob);
    return;
  }
}

/// DELETE
class DeleteJobIntent extends Intent {
  const DeleteJobIntent();
}

class DeleteJobAction extends Action<DeleteJobIntent> {
  DeleteJobAction(void Function() delete) : _delete = delete;

  final void Function() _delete;

  @override
  void invoke(covariant DeleteJobIntent intent) => _delete();
}
