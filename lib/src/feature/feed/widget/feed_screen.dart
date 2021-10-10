import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:l/l.dart';

import '../../../common/router/page_router.dart';
import '../../../common/widget/custom_scroll_view_smooth.dart';
import '../../../common/widget/error_snackbar.dart';
import '../../job/bloc/job_manager_bloc.dart';
import '../bloc/feed_bloc.dart';
import 'feed_bar.dart';
import 'feed_creation_buttons.dart';
import 'feed_list.dart';
import 'feed_scope.dart';
import 'feed_tile.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Scaffold(
        body: _FeedScrollable(),
      );
}

@immutable
class _FeedScrollable extends StatefulWidget {
  const _FeedScrollable({
    Key? key,
  }) : super(key: key);

  @override
  State<_FeedScrollable> createState() => _FeedScrollableState();
}

class _FeedScrollableState extends State<_FeedScrollable> {
  final ScrollController controller = ScrollController();
  double _screenHeight = 0;

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    controller.addListener(_checkPagination);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newScreenHeight = MediaQuery.of(context).size.height;
    if (newScreenHeight != _screenHeight) {
      // Изменилась высота экрана
      _screenHeight = newScreenHeight;
      WidgetsBinding.instance?.addPostFrameCallback((_) => _checkPagination());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  //endregion

  /// Необходимо вызывать этот метод при скролле
  /// При изменении высоты экрана
  /// При окончании загрузки очередной порции
  void _checkPagination() {
    final screenHeight = _screenHeight;
    var triggerFetchMoreSize = .0;
    try {
      triggerFetchMoreSize = controller.position.maxScrollExtent - screenHeight;
    } on Object catch (err) {
      l.w('Не могу высчитать triggerFetchMoreSize: $err');
    }
    if (controller.position.pixels < triggerFetchMoreSize) return;
    // Загрузить еще контента на 5 экранов в высоту
    FeedScope.paginateOf(context, count: (screenHeight * 5) ~/ FeedTile.height);
  }

  @override
  Widget build(BuildContext context) => BlocListener<JobManagerBLoC, JobManagerState>(
        listener: (context, state) => state.maybeMap<void>(
          orElse: () {},
          created: (state) {
            l.i('Была создана новая работа - запросим обновление списка и перейдем к редактированию элемента.');
            BlocScope.of<FeedBLoC>(context).add(const FeedEvent.fetchRecent());
            PageRouter.navigate(
              context,
              (_) => JobPageConfiguration(
                jobId: state.job.id,
                jobTitle: state.job.id,
                edit: true,
              ),
            );
          },
          error: (error) => ErrorSnackBar.show(context),
        ),
        child: BlocListener<FeedBLoC, FeedState>(
          listenWhen: (prev, next) => next.maybeMap<bool>(
            orElse: () => true,
            pagination: (_) => false,
          ),
          listener: (context, state) => _checkPagination(),
          child: CustomScrollViewSmooth(
            physics: const ClampingScrollPhysics(),
            scrollBehavior: const ScrollBehavior(),
            controller: controller,
            slivers: const <Widget>[
              /// Шапка с поиском
              FeedBar(),

              /// Создание новой работы
              FeedCreationButtons(),

              /// Лента
              FeedList(),
            ],
          ),
        ),
      );
}
