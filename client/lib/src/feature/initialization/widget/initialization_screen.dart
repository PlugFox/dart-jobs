import 'package:dart_jobs/src/feature/initialization/widget/initialization_scope.dart';
import 'package:flutter/material.dart';

@immutable
class InitializationScreen extends StatefulWidget {
  const InitializationScreen({
    final Key? key,
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
  Widget build(final BuildContext context) => Directionality(
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
              builder: (final context, final snapshot) =>
                  snapshot.data?.map<Widget>(
                    initialized: (final _) => const InitializationProgressWidget(
                      progress: 0,
                      message: 'Initialized',
                    ),
                    initializationInProgress: (final state) => InitializationProgressWidget(
                      message: state.message,
                      progress: state.progress,
                    ),
                    error: (final state) => InitializationErrorWidget(
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
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
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
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Column(
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
