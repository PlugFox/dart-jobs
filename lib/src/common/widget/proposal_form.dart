// ignore_for_file: deprecated_member_use_from_same_package

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../../feature/authentication/widget/authentication_scope.dart';
import '../model/proposal.dart';

@experimental
@Deprecated('Пересмотреть реализацию')
@immutable
class ProposalForm<T extends Proposal> extends StatefulWidget {
  final Widget child;
  final ProposalFormStatus initialStatus;
  final T initialData;

  const ProposalForm({
    required final this.child,
    required final this.initialData,
    final this.initialStatus = ProposalFormStatus.read,
    Key? key,
  }) : super(key: key);

  static T getDataOf<T extends Proposal>(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedProposalFormData<T>>()!.data;
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedProposalFormData<T>>()!.widget;
      return (inhW as _InheritedProposalFormData<T>).data;
    }
  }

  static void setDataOf<T extends Proposal>(BuildContext context, T data) => sinkOf<T>(context).add(data);

  static Sink<T> sinkOf<T extends Proposal>(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedProposalFormData<T>>()!.widget;
    return (inhW as _InheritedProposalFormData<T>).sink;
  }

  static Stream<T> streamOf<T extends Proposal>(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedProposalFormData<T>>()!.widget;
    return (inhW as _InheritedProposalFormData<T>).stream;
  }

  static ProposalFormStatus statusOf(BuildContext context, {bool listen = true}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedProposalFormStatus>()?.status ??
          ProposalFormStatus.read;
    } else {
      final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedProposalFormStatus>()?.widget;
      return inhW is _InheritedProposalFormStatus ? inhW.status : ProposalFormStatus.read;
    }
  }

  static void switchToEdit(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedProposalFormStatus>()?.widget;
    if (inhW is! _InheritedProposalFormStatus) return;
    inhW.state.switchToEdit();
  }

  static void switchToRead(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedProposalFormStatus>()?.widget;
    if (inhW is! _InheritedProposalFormStatus) return;
    inhW.state.switchToRead();
  }

  static void toggle(BuildContext context) {
    final inhW = context.getElementForInheritedWidgetOfExactType<_InheritedProposalFormStatus>()?.widget;
    if (inhW is! _InheritedProposalFormStatus) return;
    switch (inhW.status) {
      case ProposalFormStatus.edit:
        inhW.state.switchToRead();
        break;
      case ProposalFormStatus.read:
      default:
        inhW.state.switchToEdit();
        break;
    }
  }

  @override
  State<ProposalForm> createState() => _ProposalFormState<T>();
}

class _ProposalFormState<T extends Proposal> extends State<ProposalForm<T>> {
  ProposalFormStatus _status = ProposalFormStatus.read;
  late T _data;
  T get data => _data;
  final StreamController<T> _controller = StreamController<T>.broadcast();
  late final StreamSubscription<T> _subscription;

  @override
  void initState() {
    super.initState();
    _status = widget.initialStatus;
    _data = widget.initialData;
    _subscription = _controller.stream.listen((data) => _data = data);
  }

  @override
  void didUpdateWidget(covariant ProposalForm<T> oldWidget) {
    if (widget.initialData != oldWidget.initialData) {
      _data = widget.initialData;
      _controller.add(_data);
    }
    if (widget.initialStatus != oldWidget.initialStatus) {
      _status = widget.initialStatus;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    final user = AuthenticationScope.userOf(context, listen: true);
    if (user.isNotAuthenticated) {
      // Пользователь не аутентифицирован - не позволяем редактировать, только читать
      _status = ProposalFormStatus.read;
    }
    super.didChangeDependencies();
  }

  void switchToEdit() {
    final user = AuthenticationScope.userOf(context, listen: true);
    if (user.isNotAuthenticated) {
      // Пользователь не аутентифицирован - не позволяем редактировать, только читать
      if (_status == ProposalFormStatus.read) return;
      setState(() => _status = ProposalFormStatus.read);
      return;
    }
    if (_status == ProposalFormStatus.edit) return;
    setState(() => _status = ProposalFormStatus.edit);
  }

  void switchToRead() {
    if (_status == ProposalFormStatus.read) return;
    setState(() => _status = ProposalFormStatus.read);
  }

  @override
  void dispose() {
    _subscription.cancel();
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _InheritedProposalFormStatus(
        status: _status,
        state: this,
        child: StreamBuilder<T>(
          initialData: data,
          stream: _controller.stream,
          builder: (context, snapshot) => _InheritedProposalFormData<T>(
            data: snapshot.data ?? data,
            sink: _controller.sink,
            stream: _controller.stream,
            child: widget.child,
          ),
        ),
      );
}

@immutable
class _InheritedProposalFormData<T extends Proposal> extends InheritedWidget {
  final T data;
  final Sink<T> sink;
  final Stream<T> stream;

  const _InheritedProposalFormData({
    required this.data,
    required this.sink,
    required this.stream,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedProposalFormData<T> oldWidget) => data != oldWidget.data;
}

@immutable
class _InheritedProposalFormStatus extends InheritedWidget {
  final ProposalFormStatus status;
  final _ProposalFormState state;

  const _InheritedProposalFormStatus({
    required this.status,
    required this.state,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedProposalFormStatus oldWidget) => status != oldWidget.status;
}

enum ProposalFormStatus {
  read,
  edit,
}
