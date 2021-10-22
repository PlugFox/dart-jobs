import 'package:dart_jobs/src/feature/feed/bloc/feed_bloc.dart';
import 'package:dart_jobs/src/feature/feed/widget/feed_tile.dart';
import 'package:dart_jobs/src/feature/job/widget/job_scope.dart';
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
                final proposal = state.list[index];
                if (proposal is Job) {
                  return FeedTile.job(
                    job: proposal,
                    key: ValueKey<String>(proposal.id),
                  );
                }
                return ErrorWidget(
                  Exception('Unknown proposal type of $proposal'),
                );
              },
              childCount: state.maybeMap<int>(
                orElse: () => length,
                pagination: (final processed) => length + processed.loadingCount,
              ),
            ),
          );
        },
      );
}
