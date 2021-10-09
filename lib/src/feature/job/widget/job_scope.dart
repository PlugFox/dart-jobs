import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../../../common/model/proposal.dart';
import '../../authentication/model/user_entity.dart';
import '../../authentication/widget/authentication_scope.dart';
import '../../feed/widget/feed_scope.dart';
import '../../initialization/widget/initialization_scope.dart';
import '../bloc/job_bloc.dart';

@immutable
class JobScope extends ProxyWidget {
  JobScope({
    required final this.id,
    required final Widget child,
    final this.creatorId,
    Key? key,
  })  : assert(id.isNotEmpty, 'ID работы должно быть заполненно'),
        super(
          key: key,
          child: child,
        );

  /// Идентификатор работы
  final String id;

  /// Идентификатор владельца, если не указан - null
  final String? creatorId;

  /// Find _JobScopeState in BuildContext
  static _JobScopeState? _of(BuildContext context, {bool listen = false}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedJobScope>()?.state;
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedJobScope>()?.widget;
      return inheritedWidget is _InheritedJobScope ? inheritedWidget.state : null;
    }
  }

  /// Обновить работу
  static void saveJobOf(BuildContext context, Job job) {
    final user = AuthenticationScope.userOf(context, listen: false);
    if (user is! AuthenticatedUser) return;
    if (user.uid != job.creatorId) return;
    _of(context, listen: false)?.bloc?.add(JobEvent.update(job));
  }

  @override
  Element createElement() => _JobScopeState(this);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) => super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'JobScope ProxyWidget',
            ),
          ),
      );
}

class _JobScopeState extends ComponentElement {
  _JobScopeState(Widget widget) : super(widget);

  JobBLoC? bloc;

  @override
  JobScope get widget => super.widget as JobScope;

  bool _mounted = false;

  //region Lifecycle
  @override
  void mount(Element? parent, Object? newSlot) {
    super.mount(parent, newSlot);
    _mounted = true;
  }

  void initState() {
    final id = widget.id;
    final jobOrNull = FeedScope.proposalOf<Job>(this, (p) => p.id == id);
    final store = InitializationScope.storeOf(this);
    bloc = JobBLoC(
      initialState: JobState.idle(
        job: jobOrNull ??
            Job(
              id: id,
              creatorId: widget.creatorId ?? '',
              title: 'Job #$id',
              updated: DateTime.utc(1970),
              created: DateTime.utc(1970),
            ),
      ),
      repository: store.jobRepository,
    )..add(const JobEvent.fetch());
  }

  @override
  void unmount() {
    _mounted = false;
    bloc?.close();
    super.unmount();
  }
  //endregion

  @override
  Widget build() {
    if (!_mounted) {
      initState();
    }
    return _InheritedJobScope(
      state: this,
      child: BlocScope<JobBLoC>.value(
        value: bloc!,
        child: widget.child,
      ),
    );
  }
}

@immutable
class _InheritedJobScope extends InheritedWidget {
  final _JobScopeState state;

  const _InheritedJobScope({
    required final this.state,
    required final Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedJobScope oldWidget) => false;
}
