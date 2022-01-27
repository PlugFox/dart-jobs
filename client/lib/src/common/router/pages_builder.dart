import 'package:dart_jobs_client/src/common/router/pages.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:flutter/widgets.dart';
import 'package:l/l.dart';

/// {@template pages_builder.PagesBuilder}
/// Собирает список маршрутов из текущей конфигурации роутера приложения
/// Также сокращает или перенаправляет недоступные роуты в текущем контексте
/// {@endtemplate}
@immutable
class PagesBuilder extends StatefulWidget {
  /// {@macro pages_builder.PagesBuilder}
  const PagesBuilder({
    required final this.configuration,
    required final this.builder,
    final this.child,
    Key? key,
  }) : super(key: key);

  /// Текущая конфигурация навигации
  final IRouteConfiguration configuration;

  final ValueWidgetBuilder<List<AppPage<Object?>>> builder;
  final Widget? child;

  /// Вызывается для создания из конфигурации страниц, проверки и исключения дубликатов и не разрешенных пользователю
  static List<AppPage<Object?>> buildAndReduce(
    BuildContext context,
    IRouteConfiguration configuration,
  ) {
    final segments = Uri.parse(configuration.location).pathSegments;
    final state = Map<String, Object?>.of(
      configuration.state ?? <String, Object?>{},
    );
    final feed = FeedPage();
    final pages = <String, AppPage<Object?>>{
      feed.location: feed,
    };
    for (final path in segments) {
      try {
        if (path.isEmpty) continue;
        final page = AppPage.fromPath(
          location: path,
          arguments: state.remove(path),
        );
        pages[page.location] = page;
      } on Object catch (err) {
        l.w('Ошибка разбора роута "$path": $err');
      }
    }
    l.v6('PagesBuilder.buildAndReduce(ctx, $configuration) => [${pages.keys.join(',')}]');
    assert(pages.values.isNotEmpty, 'Список роутов не может быть пустым');
    assert(pages.values.first is FeedPage, 'Первым роутом всегда должен быть домашний роут');
    return pages.values.toList(growable: false);
  }

  @override
  State<PagesBuilder> createState() => _PagesBuilderState();
}

class _PagesBuilderState extends State<PagesBuilder> {
  late IRouteConfiguration? configuration;
  List<AppPage<Object?>> pages = <AppPage<Object?>>[];

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    _preparePages();
  }

  @override
  void didUpdateWidget(PagesBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (configuration?.location != widget.configuration.location) {
      _preparePages();
    }
  }

  void _preparePages() {
    configuration = widget.configuration;
    pages = PagesBuilder.buildAndReduce(context, widget.configuration);
  }
  //endregion

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        pages,
        widget.child,
      );
}
