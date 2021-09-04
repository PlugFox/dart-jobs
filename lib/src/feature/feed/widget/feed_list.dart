import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:fox_flutter_bloc/bloc.dart';

import '../../job/model/job.dart';
import '../bloc/feed_bloc.dart';
import 'feed_tile.dart';

@immutable
class FeedList extends StatelessWidget {
  const FeedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<FeedBLoC, FeedState>(
        //buildWhen: (prev, next) => prev.list.length != next.list.length,
        builder: (context, state) {
          final length = state.list.length;
          return SliverFixedExtentList(
            itemExtent: FeedTile.height,
            delegate: SliverChildBuilderDelegate(
              (context, index) {
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
                processed: (processed) => length + processed.loadingCount,
              ),
            ),
          );
        },
      );
}
