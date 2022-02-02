import 'package:dart_jobs_client/src/feature/cloud_messaging/bloc/cloud_messaging_bloc.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class CloudMessagingScope extends StatelessWidget {
  const CloudMessagingScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => BlocProvider<CloudMessagingBLoC>(
        create: (context) {
          final bloc = CloudMessagingBLoC(
            service: RepositoryScope.of(context).cloudMessagingService,
          )..add(const CloudMessagingEvent.check());
          // Через 5 секунд после инициализации блока - запросить разрешение на пуши
          // если оно еще не запрашивалось
          /*
          Future<void>.delayed(
            const Duration(seconds: 5),
            () {
              if (bloc.isClosed) return;
              bloc.add(const CloudMessagingEvent.request(ifNotAlreadyRequested: true));
            },
          );
          */
          return bloc;
        },
        child: child,
      );
}
