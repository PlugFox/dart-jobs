import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:l/l.dart';

import '../../../common/model/proposal.dart';
import '../../../common/router/page_router.dart';
import '../../authentication/model/user_entity.dart';
import '../../initialization/widget/initialization_scope.dart';
import '../../job/bloc/job_manager_bloc.dart';
import '../bloc/feed_bloc.dart';

@immutable
class FeedScope extends StatelessWidget {
  final Widget child;
  const FeedScope({
    required final this.child,
    Key? key,
  }) : super(key: key);

  /// Запросить следующую порцию данных
  static void paginateOf(
    BuildContext context, {
    required final int count,
  }) {
    // ignore: close_sinks
    final bloc = BlocScope.of<FeedBLoC>(
      context,
      listen: false,
    );
    // Имеет смысл сейчас запрашивать?
    // Не имеет если достигнут конец списка
    // Не имеет если уже выполняется запрос
    if (bloc.state.maybeWhen<bool>(
      orElse: () => true,
      idle: (_, endOfList) => endOfList,
    )) return;
    bloc.add(
      FeedEvent.paginate(
        count: count,
      ),
    );
  }

  /// Получить предложение удовлетворяющее условию
  static R? proposalOf<R extends Proposal>(
    BuildContext context,
    bool Function(R proposal) test,
  ) {
    // ignore: close_sinks
    final bloc = BlocScope.of<FeedBLoC>(
      context,
      listen: false,
    );
    return bloc.state.list.whereType<R>().firstWhereOrNull(test);
  }

  /// Создать новую работу
  static void createJobOf(
    BuildContext context, {
    required String title,
    required AuthenticatedUser user,
    JobAttributes attributes = const JobAttributes.empty(),
  }) =>
      BlocScope.of<JobManagerBLoC>(
        context,
        listen: false,
      ).add(
        JobManagerEvent.create(
          title: title,
          user: user,
          attributes: attributes,
        ),
      );

  @override
  Widget build(BuildContext context) => BlocScope<FeedBLoC>.create(
        create: (context) => FeedBLoC(
          repository: InitializationScope.storeOf(context).feedRepository,
        ),
        child: BlocScope<JobManagerBLoC>.create(
          create: (context) => JobManagerBLoC(
            repository: InitializationScope.storeOf(context).jobRepository,
          ),
          child: BlocListener<JobManagerBLoC, JobManagerState>(
            listener: (context, state) => state.maybeMap<void>(
              orElse: () {},
              created: (state) {
                l.i('Была создана новая работа - запросим обновление списка и перейдем к редактированию элемента.');
                BlocScope.of<FeedBLoC>(context).add(const FeedEvent.fetchRecent());
                PageRouter.navigate(
                  context,
                  (_) => JobPageConfiguration(
                    id: state.job.id,
                    edit: true,
                  ),
                );
              },
            ),
            child: child,
          ),
        ),
      );
}
