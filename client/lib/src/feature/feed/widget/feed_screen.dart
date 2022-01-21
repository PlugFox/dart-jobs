import 'dart:math' as math;
import 'dart:ui';

import 'package:dart_jobs_client/src/common/router/navigator_observer.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:dart_jobs_client/src/common/widget/custom_scroll_view_smooth.dart';
import 'package:dart_jobs_client/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_bar.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_list.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_scope.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:l/l.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({final Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) => const AdaptiveScaffold(
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
  // ignore: close_sinks
  FeedBLoC? _bloc;
  final ScrollController _scrollController = ScrollController();
  // ignore: prefer_final_fields
  double _screenHeight = 0;
  ModalObserver? _routeObserver;

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_checkPagination);
    _bloc = BlocProvider.of<FeedBLoC>(context, listen: false)..add(const FeedEvent.paginate());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    /*
    /// TODO: в браузере может привести к спаму - сделать debounce
    final newScreenHeight = MediaQuery.of(context).size.height;
    _screenHeight ??= newScreenHeight;
    if (newScreenHeight != _screenHeight) {
      // Изменилась высота экрана
      _screenHeight = newScreenHeight;
      WidgetsBinding.instance?.addPostFrameCallback((final _) => _checkPagination());
    }
    */
    final modalRoute = ModalRoute.of(context);
    if (modalRoute != null) {
      _routeObserver?.unsubscribe(this);
      _routeObserver = AppRouter.modalObserverOf(context)..subscribe(this, modalRoute);
    }
  }

  @override
  void didPopNext() {
    /// TODO: можно будет закомментировать после того как сделаю подписку на изменение списка
    /// а также при состоянии "сохранено" буду отправлять Action Intent для запроса обновления списка
    // При возвращении на страницу запрашиваем обновление списка
    context.read<FeedBLoC>().add(const FeedEvent.fetchRecent());
  }

  @override
  void dispose() {
    _routeObserver?.unsubscribe(this);
    _scrollController.dispose();
    super.dispose();
  }
  //endregion

  /// Необходимо вызывать этот метод при скролле
  /// При изменении высоты экрана
  /// При окончании загрузки очередной порции
  void _checkPagination() {
    final state = _bloc?.state;
    if (state == null || state.isProcessed || state.endOfList) {
      // Блок уже в состоянии "запроса" или конец списка достигнут - игнорируем проверку на запрос очередной порции
      return;
    }
    final screenHeight = _screenHeight;
    var triggerFetchMoreSize = .0;
    try {
      triggerFetchMoreSize = _scrollController.position.maxScrollExtent - screenHeight;
    } on Object catch (err) {
      l.w('Не могу высчитать triggerFetchMoreSize: $err');
    }
    if (_scrollController.position.pixels < triggerFetchMoreSize) return;
    // Загрузить еще контента на 5 экранов в высоту
    l.v6('Загрузить еще контента на 5 экранов в высоту');
    FeedScope.paginateOf(context, count: math.max(math.min((screenHeight * 5) ~/ FeedTile.height, 100), 25));
  }

  @override
  Widget build(final BuildContext context) => BlocListener<FeedBLoC, FeedState>(
        listenWhen: (final prev, final next) => next.maybeMap<bool>(
          orElse: () => true,
          pagination: (final _) => false,
        ),
        listener: (final context, final state) => _checkPagination(),
        child: CustomScrollViewSmooth(
          physics: const BouncingScrollPhysics(),
          scrollBehavior: const _FeedListScrollBehavior(),
          controller: _scrollController,
          slivers: const <Widget>[
            /// Шапка с поиском
            FeedBar(),

            // Вынес это в drawer:
            // /// Создание новой работы
            //FeedCreationButtons(),

            /// Лента
            FeedList(),
          ],
        ),
      );
}

class _FeedListScrollBehavior extends MaterialScrollBehavior {
  const _FeedListScrollBehavior()
      : super(
          androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
        );

  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => <PointerDeviceKind>{
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.unknown,
      };
}
