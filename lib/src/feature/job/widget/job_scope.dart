import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../../../common/model/proposal.dart';
import '../../authentication/bloc/authentication_bloc.dart';
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
  /// Нужен для установления первоначального владельца, если работа не найдена в скоупе по идентификатору,
  /// например если это только что созданная работа
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

  /// Обновить работу (без подписки)
  static void saveJobOf(BuildContext context, Job job) {
    final user = AuthenticationScope.userOf(context, listen: false);
    if (user is! AuthenticatedUser) return;
    if (user.uid != job.creatorId) return;
    AuthenticationScope.authenticateOr(
      context,
      (user) => _of(context, listen: false)?.bloc.add(JobEvent.update(job, user.uid)),
    );
  }

  /// Получить текущую работу (без подписки)
  static Job jobOf(BuildContext context) => BlocScope.of<JobBLoC>(context, listen: false).state.job;

  /// Состояние формы просмотр/редактирование
  /// true - редактирование
  /// false - просмотр
  /// По умолчанию оформляет подписку на [JobScope] и [AuthenticationScope]
  static bool editingOf(BuildContext context, {bool listen = true}) {
    final state = _of(context, listen: listen)?.bloc.state;
    if (state == null || state.viewing) return false;
    return AuthenticationScope.isSameUid(context, state.job.creatorId, listen: listen);
  }

  /// Переключиться в режим редактирования
  static void edit(BuildContext context) => AuthenticationScope.authenticateOr(
        context,
        (user) => _of(context, listen: false)?.bloc.add(JobEvent.edit(user.uid)),
      );

  /// Переключиться в режим просмотра
  static void view(BuildContext context) => _of(context, listen: false)?.bloc.add(const JobEvent.view());

  @override
  Element createElement() => _JobScopeState(this);
}

class _JobScopeState extends ComponentElement {
  _JobScopeState(Widget widget) : super(widget);

  late JobBLoC bloc;

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
    // Если единственное что известно о текущей работе это идентификатор
    // создадим изначальное заполненние пустой работой
    final job = jobOrNull ??
        Job(
          id: id,
          creatorId: widget.creatorId ?? '',
          title: 'Job #$id',
          updated: DateTime.utc(1970),
          created: DateTime.utc(1970),
        );
    bloc = JobBLoC(
      initialState: JobState.idle(
        job: job,
        editing: job.creatorId == widget.creatorId,
      ),
      repository: store.jobRepository,
    )..add(const JobEvent.fetch());
  }

  @override
  void unmount() {
    _mounted = false;
    bloc.close();
    super.unmount();
  }
  //endregion

  @override
  Widget build() {
    if (!_mounted) {
      initState();
    }
    return BlocBuilder<JobBLoC, JobState>(
      bloc: bloc,
      buildWhen: (prev, next) => prev.editing != next.editing,
      builder: (context, jobState) => _InheritedJobScope(
        state: this,
        editing: jobState.editing,
        child: BlocListener<AuthenticationBLoC, AuthenticationState>(
          listener: (context, authState) {
            if (jobState.viewing) return;
            if (jobState.job.creatorId != authState.user.authenticatedOrNull?.uid) {
              bloc.add(const JobEvent.view());
            }
          },
          child: BlocScope<JobBLoC>.value(
            value: bloc,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

@immutable
class _InheritedJobScope extends InheritedWidget {
  final _JobScopeState state;
  final bool editing;

  const _InheritedJobScope({
    required final this.state,
    required final this.editing,
    required final Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedJobScope oldWidget) => editing != oldWidget.editing;
}
