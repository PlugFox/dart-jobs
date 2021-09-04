import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

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
      empty: (_) => false,
      filled: (_, endOfList) => endOfList,
    )) return;
    bloc.add(
      FeedEvent.paginate(
        count: count,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => BlocScope<FeedBLoC>.create(
        create: (context) => FeedBLoC(),
        child: child,
      );
}
