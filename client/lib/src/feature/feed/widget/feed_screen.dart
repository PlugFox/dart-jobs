import 'package:dart_jobs/src/common/router/page_router.dart';
import 'package:dart_jobs/src/common/router/router_delegate.dart';
import 'package:dart_jobs/src/common/widget/custom_scroll_view_smooth.dart';
import 'package:dart_jobs/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_bar.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_creation_buttons.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_list.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_tile.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:l/l.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => const Scaffold(
        body: _FeedScrollable(),
      );
}

@immutable
class _FeedScrollable extends StatefulWidget {
  const _FeedScrollable({
    final Key? key,
  }) : super(key: key);

  @override
  State<_FeedScrollable> createState() => _FeedScrollableState();
}

// ignore: prefer_mixin
class _FeedScrollableState extends State<_FeedScrollable> with RouteAware {
  final ScrollController controller = ScrollController();
  double _screenHeight = 0;
  ModalObserver? _routeObserver;

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
      WidgetsBinding.instance?.addPostFrameCallback((final _) => _checkPagination());
    }
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      _routeObserver = PageRouter.modalObserverOf(context)..subscribe(this, modalRoute);
    }
  }

  @override
  void didPopNext() {
    // При возвращении на страницу запрашиваем обновление списка
    //context.read<FeedBLoC>().add(const FeedEvent.fetchRecent());
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
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
  Widget build(final BuildContext context) => BlocListener<FeedBLoC, FeedState>(
        listenWhen: (final prev, final next) => next.maybeMap<bool>(
          orElse: () => true,
          pagination: (final _) => false,
        ),
        listener: (final context, final state) => _checkPagination(),
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
      );
}
