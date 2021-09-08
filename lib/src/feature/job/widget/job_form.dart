import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

@immutable
class JobForm extends StatefulWidget {
  final Widget child;
  final JobFormStatus status;

  const JobForm({
    required final this.child,
    final this.status = JobFormStatus.read,
    Key? key,
  }) : super(key: key);

  static JobFormStatus statusOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedJobForm>()?.status ?? JobFormStatus.read;
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedJobForm>()?.widget;
      return inhW is _InheritedJobForm ? inhW.status : JobFormStatus.read;
    }
  }

  static void switchToEdit(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedJobForm>()?.widget;
    if (inhW is! _InheritedJobForm) return;
    inhW.state.switchToEdit();
  }

  static void switchToRead(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedJobForm>()?.widget;
    if (inhW is! _InheritedJobForm) return;
    inhW.state.switchToRead();
  }

  static void toggle(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedJobForm>()?.widget;
    if (inhW is! _InheritedJobForm) return;
    switch (inhW.status) {
      case JobFormStatus.edit:
        inhW.state.switchToRead();
        break;
      case JobFormStatus.read:
      default:
        inhW.state.switchToEdit();
        break;
    }
  }

  @override
  State<JobForm> createState() => _JobFormState();
}

class _JobFormState extends State<JobForm> {
  JobFormStatus _status = JobFormStatus.read;

  void switchToEdit() {
    if (_status == JobFormStatus.edit) return;
    setState(() => _status = JobFormStatus.edit);
  }

  void switchToRead() {
    if (_status == JobFormStatus.read) return;
    setState(() => _status = JobFormStatus.read);
  }

  @override
  Widget build(BuildContext context) => _InheritedJobForm(
        status: _status,
        state: this,
        child: widget.child,
      );
}

@immutable
class _InheritedJobForm extends InheritedWidget {
  final JobFormStatus status;
  final _JobFormState state;

  const _InheritedJobForm({
    required this.status,
    required this.state,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedJobForm oldWidget) => status != oldWidget.status;
}

enum JobFormStatus {
  read,
  edit,
}
