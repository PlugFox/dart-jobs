import 'package:dart_jobs/src/feature/job/model/job.dart';
import 'package:dart_jobs/src/feature/job/widget/job_form/job_form_data.dart';
import 'package:flutter/widgets.dart';

/// READ
class ReadJobIntent extends Intent {
  const ReadJobIntent(this.job);

  final Job job;
}

class ReadJobAction extends Action<EditJobIntent> {
  ReadJobAction(JobFormData formData) : _formData = formData;

  final JobFormData _formData;

  @override
  void invoke(covariant EditJobIntent intent) {
    final job = intent.job;
    _formData
      ..updateFormData(intent.job)
      ..setState(newStatus: job.isEmpty ? FormStatus.editing : FormStatus.readOnly);
  }
}

/// EDIT
class EditJobIntent extends Intent {
  const EditJobIntent(this.job);

  final Job job;
}

class EditJobAction extends Action<EditJobIntent> {
  EditJobAction(JobFormData formData) : _formData = formData;

  final JobFormData _formData;

  @override
  void invoke(covariant EditJobIntent intent) {
    _formData
      ..updateFormData(intent.job)
      ..setState(newStatus: FormStatus.editing);
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
  void invoke(covariant ValidateJobIntent intent) => _formData.validate();
}

/// SAVE
class SaveJobIntent extends Intent {
  const SaveJobIntent(this.job);

  final Job job;
}

class SaveJobAction extends Action<SaveJobIntent> {
  SaveJobAction(
    JobFormData formData,
    void Function(Job job) save,
  )   : _formData = formData,
        _save = save;

  final JobFormData _formData;
  final void Function(Job job) _save;

  @override
  void invoke(covariant SaveJobIntent intent) {
    if (!_formData.validate()) {
      return;
    }
    final newJob = _formData.updateJob(intent.job);
    _save(newJob);
  }
}

/// DELETE
class DeleteJobIntent extends Intent {
  const DeleteJobIntent(this.job);

  final Job job;
}

class DeleteJobAction extends Action<DeleteJobIntent> {
  DeleteJobAction(void Function(Job job) delete) : _delete = delete;

  final void Function(Job job) _delete;

  @override
  void invoke(covariant DeleteJobIntent intent) => _delete(intent.job);
}
