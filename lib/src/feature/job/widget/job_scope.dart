import 'package:dart_jobs/src/common/model/proposal.dart';
import 'package:dart_jobs/src/feature/authentication/bloc/authentication_bloc.dart';
import 'package:dart_jobs/src/feature/authentication/model/user_entity.dart';
import 'package:dart_jobs/src/feature/authentication/widget/authentication_scope.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:dart_jobs/src/feature/job/bloc/job_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

export 'package:dart_jobs/src/common/model/proposal.dart';

@immutable
class JobScope extends ProxyWidget {
  JobScope({
    required final this.id,
    required final Widget child,
    final this.creatorId,
    final Key? key,
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
  static _JobScopeState? _of(final BuildContext context, {bool listen = false}) {
    if (listen) {
      return context.dependOnInheritedWidgetOfExactType<_InheritedJobScope>()?.state;
    } else {
      final inheritedWidget = context.getElementForInheritedWidgetOfExactType<_InheritedJobScope>()?.widget;
      return inheritedWidget is _InheritedJobScope ? inheritedWidget.state : null;
    }
  }

  /// Обновить работу (без подписки)
  static void saveJobOf(final BuildContext context, final Job job) {
    final user = AuthenticationScope.userOf(context, listen: false);
    if (user is! AuthenticatedUser) return;
    if (user.uid != job.creatorId) return;
    AuthenticationScope.authenticateOr(
      context,
      (final user) => _of(context, listen: false)?.bloc.add(JobEvent.update(job, user.uid)),
    );
  }

  /// Получить текущую работу (без подписки)
  static Job jobOf(final BuildContext context) => BlocScope.of<JobBLoC>(context, listen: false).state.job;

  /// Состояние формы просмотр/редактирование
  /// true - редактирование
  /// false - просмотр
  /// По умолчанию оформляет подписку на [JobScope] и [AuthenticationScope]
  static bool editingOf(final BuildContext context, {bool listen = true}) {
    final state = _of(context, listen: listen)?.bloc.state;
    if (state == null || state.viewing) return false;
    return AuthenticationScope.isSameUid(context, state.job.creatorId, listen: listen);
  }

  /// Переключиться в режим редактирования
  static void edit(final BuildContext context) => AuthenticationScope.authenticateOr(
        context,
        (final user) => _of(context, listen: false)?.bloc.add(JobEvent.edit(user.uid)),
      );

  /// Переключиться в режим просмотра
  static void view(final BuildContext context) => _of(context, listen: false)?.bloc.add(const JobEvent.view());

  @override
  Element createElement() => _JobScopeState(this);
}

class _JobScopeState extends ComponentElement {
  _JobScopeState(final Widget widget) : super(widget);

  late JobBLoC bloc;

  @override
  JobScope get widget => super.widget as JobScope;

  bool _mounted = false;

  //region Lifecycle
  @override
  void mount(final Element? parent, final Object? newSlot) {
    super.mount(parent, newSlot);
    _mounted = true;
  }

  void initState() {
    final id = widget.id;
    final jobOrNull = FeedScope.proposalOf<Job>(this, (final p) => p.id == id);
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
          company: '',
          country: '',
          location: '',
          remote: true,
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
      buildWhen: (final prev, final next) => prev.editing != next.editing,
      builder: (final context, final jobState) => _InheritedJobScope(
        state: this,
        editing: jobState.editing,
        child: BlocListener<AuthenticationBLoC, AuthenticationState>(
          listener: (final context, final authState) {
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
    final Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(final _InheritedJobScope oldWidget) => editing != oldWidget.editing;
}
