import 'package:dart_jobs_client/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs_client/src/feature/feed/widget/feed_tile.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

@immutable
class FeedList extends StatelessWidget {
  const FeedList({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => BlocBuilder<FeedBLoC, FeedState>(
        //buildWhen: (prev, next) => prev.list.length != next.list.length,
        builder: (final context, final state) {
          final length = state.list.length;
          return SliverFixedExtentList(
            itemExtent: FeedTile.height,
            delegate: SliverChildBuilderDelegate(
              (final context, final index) {
                if (index >= length) {
                  return const FeedTile.loading();
                }
                final job = state.list[index];
                return FeedTile.job(
                  job: job,
                  key: ValueKey<String>('${job.id}_${job.updated.millisecondsSinceEpoch}'),
                );
              },
              childCount: state.maybeMap<int>(
                orElse: () => length,
                pagination: (final processed) => length + processed.filter.limit,
              ),
            ),
          );
        },
      );
}
