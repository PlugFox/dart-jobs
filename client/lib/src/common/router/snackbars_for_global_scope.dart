import 'package:dart_jobs_client/src/common/widget/error_snackbar.dart';
import 'package:dart_jobs_client/src/feature/authentication/bloc/authentication_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class SnackBarsForGlobalScope extends StatelessWidget {
  const SnackBarsForGlobalScope({
    required final this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) => BlocListener<AuthenticationBLoC, AuthenticationState>(
        listener: (context, state) => state.mapOrNull<void>(
          error: (error) => ErrorSnackBar.show(
            context,
            error: error.message,
          ),
        ),
        child: child,
      );
}
