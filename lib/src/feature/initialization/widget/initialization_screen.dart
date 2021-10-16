import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../bloc/initialization_bloc.dart' show InitializationState;
import '../widget/initialization_scope.dart';
import 'initialization_scope.dart';

@immutable
class InitializationScreen extends StatefulWidget {
  const InitializationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<InitializationScreen> createState() => _InitializationScreenState();
}

class _InitializationScreenState extends State<InitializationScreen> {
  Stream<InitializationState>? _stream;

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    _stream = InitializationScope.of(context);
  }
  //endregion

  @override
  Widget build(BuildContext context) => Directionality(
        textDirection: TextDirection.ltr,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: StreamBuilder<InitializationState>(
              initialData: const InitializationState.initializationInProgress(
                progress: 0,
                message: 'Preparing for initialization',
              ),
              stream: _stream,
              builder: (context, snapshot) =>
                  snapshot.data?.map<Widget>(
                    initialized: (_) => const InitializationProgressWidget(
                      progress: 0,
                      message: 'Initialized',
                    ),
                    initializationInProgress: (state) => InitializationProgressWidget(
                      message: state.message,
                      progress: state.progress,
                    ),
                    error: (state) => InitializationErrorWidget(
                      message: state.message,
                      error: state.error,
                      stackTrace: state.stackTrace,
                    ),
                  ) ??
                  InitializationErrorWidget(
                    message: 'Initialization error',
                    error: 'Unknown initialization state',
                    stackTrace: StackTrace.current,
                  ),
            ),
          ),
        ),
      );
}

@immutable
class InitializationProgressWidget extends StatelessWidget {
  final int progress;
  final String message;
  const InitializationProgressWidget({
    required this.progress,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(24),
        child: FittedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(
                value: progress.toDouble(),
              ),
              Text(message),
            ],
          ),
        ),
      );
}

@immutable
class InitializationErrorWidget extends StatelessWidget {
  final String message;
  final Object error;
  final StackTrace stackTrace;
  const InitializationErrorWidget({
    required final this.message,
    required final this.error,
    required final this.stackTrace,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.error,
            color: Colors.red,
            size: 48,
          ),
          Text(message),
          const Divider(),
          Text(error.toString()),
          Text(stackTrace.toString()),
        ],
      );
}
