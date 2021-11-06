import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/job/widget/job_form/job_form_data.dart';
import 'package:dart_jobs_shared/models.dart';
import 'package:flutter/widgets.dart';

/// READ
class ReadJobIntent extends Intent {
  const ReadJobIntent(this.job);

  final Job job;
}

class ReadJobAction extends Action<ReadJobIntent> {
  ReadJobAction(JobFormData formData) : _formData = formData;

  final JobFormData _formData;

  @override
  void invoke(covariant ReadJobIntent intent) {
    final job = intent.job;
    if (job.isEmpty) {
      return;
    }
    _formData
      ..updateFormData(intent.job)
      ..setState(newStatus: job.isEmpty ? FormStatus.editing : FormStatus.readOnly);
  }
}

/// EDIT
class EditJobIntent extends Intent {
  const EditJobIntent(
    this.job,
    this.user,
  );

  final Job job;
  final AuthenticatedUser user;
}

class EditJobAction extends Action<EditJobIntent> {
  EditJobAction(
    JobFormData formData,
  ) : _formData = formData;

  final JobFormData _formData;

  @override
  void invoke(covariant EditJobIntent intent) {
    if (intent.job.creatorId != intent.user.uid) {
      return;
    }
    _formData
      ..updateFormData(intent.job)
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
  const GetUpdatedJobIntent(this.job);

  final Job job;
}

class GetUpdatedJobAction extends Action<GetUpdatedJobIntent> {
  GetUpdatedJobAction(JobFormData formData) : _formData = formData;

  final JobFormData _formData;

  @override
  Job invoke(covariant GetUpdatedJobIntent intent) => _formData.updateJob(intent.job);
}

/// SAVE
/// Внимание, перед вызовом этого метода - проверьте
/// валидность заполнения работы с помощью [ValidateJobIntent]
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
    return;
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
