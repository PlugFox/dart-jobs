import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../authentication/model/user_entity.dart';
import '../../authentication/widget/authentication_scope.dart';
import '../bloc/job_bloc.dart';
import 'job_form.dart';
import 'job_scope.dart';

@immutable
class JobScreen extends StatelessWidget {
  const JobScreen({
    required final this.id,
    this.edit = false,
    Key? key,
  }) : super(key: key);

  /// Идентификатор работы
  final String id;

  /// Изначальное состояние (если true - открыть форму в режиме редактирования)
  final bool edit;

  @override
  Widget build(BuildContext context) => BlocBuilder<JobBLoC, JobState>(
        builder: (context, state) => JobForm(
          job: state.job,
          edit: edit,
          child: BlocListener<JobBLoC, JobState>(
            listener: (context, state) {
              // Если состояние загрузки - забираем возможность редактировать
              state.maybeMap<Object?>(
                orElse: () => null,
                fetching: (_) => JobForm.switchToRead(context),
              );
            },
            child: Scaffold(
              appBar: AppBar(
                title: Text('Job #$id'),
                actions: const <Widget>[
                  _CancelEditAppBarButton(),
                  SizedBox(width: 15),
                ],
              ),
              body: const SafeArea(
                child: JobFields(),
              ),
              floatingActionButton: const _JobScreenFloatingActionButton(),
            ),
          ),
        ),
      );
}

@immutable
class _JobScreenFloatingActionButton extends StatelessWidget {
  const _JobScreenFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<JobBLoC, JobState>(
        builder: (context, state) {
          final user = AuthenticationScope.userOf(context, listen: true);
          if (user is! AuthenticatedUser) {
            // Пользователь не аутентифицирован - не позволяем редактировать
            return const SizedBox.shrink();
          }
          if (state.job.creatorId.isNotEmpty && state.job.creatorId != user.uid) {
            // Это элемент не этого пользователя - не позволяем редактировать
            return const SizedBox.shrink();
          }
          final themeData = Theme.of(context);
          final fetching = state.maybeMap<bool>(orElse: () => false, fetching: (_) => true);
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: ValueListenableBuilder<bool>(
              valueListenable: JobForm.readOnlyStatusOf(context),
              builder: (context, readOnly, child) => readOnly
                  ? FloatingActionButton(
                      key: ValueKey<bool>(readOnly),
                      onPressed: fetching ? null : () => JobForm.switchToEdit(context),
                      backgroundColor:
                          fetching ? themeData.disabledColor : themeData.floatingActionButtonTheme.backgroundColor,
                      child: const Icon(
                        Icons.edit,
                        size: 30,
                      ),
                    )
                  : FloatingActionButton(
                      key: ValueKey<bool>(readOnly),
                      onPressed: fetching
                          ? null
                          : () {
                              // Сейчас статус - редактирование, следовательно мы хотим сохранить результат
                              final currentData = JobForm.currentJobOf(context);
                              JobScope.saveJobOf(context, currentData);
                            },
                      backgroundColor:
                          fetching ? themeData.disabledColor : themeData.floatingActionButtonTheme.backgroundColor,
                      child: const Icon(
                        Icons.save,
                        size: 30,
                      ),
                    ),
            ),
          );
        },
      );
}

@immutable
class _CancelEditAppBarButton extends StatelessWidget {
  const _CancelEditAppBarButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: JobForm.readOnlyStatusOf(context),
        builder: (context, readOnly, child) => readOnly ? const SizedBox.shrink() : child!,
        child: SizedBox.square(
          dimension: kToolbarHeight,
          child: IconButton(
            icon: const CircleAvatar(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Icon(
                  Icons.cancel_outlined,
                  size: 30,
                ),
              ),
            ),
            onPressed: () {
              BlocScope.of<JobBLoC>(context).add(const JobEvent.fetch());
              JobForm.switchToRead(context);
            },
          ),
        ),
      );
}
