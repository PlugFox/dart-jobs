import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/localization/localizations.dart';
import '../../../common/router/page_router.dart';
import '../../authentication/model/user_entity.dart';
import '../../authentication/widget/authentication_scope.dart';
import '../../feed/widget/feed_scope.dart';
import '../bloc/job_bloc.dart';
import '../model/job.dart';
import 'job_form.dart';
import 'job_not_found.dart';
import 'job_scope.dart';

@immutable
class JobScreen extends StatelessWidget {
  const JobScreen({
    required final this.id,
    required final this.title,
    this.edit = false,
    Key? key,
  }) : super(key: key);

  /// Идентификатор работы
  final String id;

  /// Идентификатор работы
  final String title;

  /// Изначальное состояние (если true - открыть форму в режиме редактирования)
  final bool edit;

  @override
  Widget build(BuildContext context) => BlocBuilder<JobBLoC, JobState>(
        buildWhen: (prev, next) => prev.job.title != next.job.title,
        builder: (context, state) => state.maybeMap<Widget>(
          notFound: (_) => const JobNotFound(),
          orElse: () => JobForm(
            child: Scaffold(
              appBar: AppBar(
                title: Text(state.job.title),
                actions: const <Widget>[
                  _DeleteAppBarButton(),
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
            child: Builder(builder: (context) {
              final readOnly = !JobScope.editingOf(context, listen: true);
              return readOnly
                  ? FloatingActionButton(
                      tooltip: 'Edit job',
                      key: const ValueKey<String>('edit_job_floating_action_button'),
                      onPressed: fetching ? null : () => JobScope.edit(context),
                      backgroundColor:
                          fetching ? themeData.disabledColor : themeData.floatingActionButtonTheme.backgroundColor,
                      child: const Icon(
                        Icons.edit,
                        size: 30,
                      ),
                    )
                  : FloatingActionButton(
                      tooltip: 'Save job',
                      key: const ValueKey<String>('save_job_floating_action_button'),
                      onPressed: fetching
                          ? null
                          : () {
                              // Сейчас статус - редактирование, следовательно мы хотим сохранить результат
                              final currentData = JobForm.getCurrentJob(context);
                              JobScope.saveJobOf(context, currentData);
                            },
                      backgroundColor:
                          fetching ? themeData.disabledColor : themeData.floatingActionButtonTheme.backgroundColor,
                      child: const Icon(
                        Icons.save,
                        size: 30,
                      ),
                    );
            }),
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
  Widget build(BuildContext context) {
    final readOnly = !JobScope.editingOf(context, listen: true);
    return readOnly
        ? const SizedBox.shrink()
        : SizedBox.square(
            dimension: kToolbarHeight,
            child: IconButton(
              tooltip: 'Cancel without saving',
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
                JobScope.view(context);
              },
            ),
          );
  }
}

@immutable
class _DeleteAppBarButton extends StatelessWidget {
  const _DeleteAppBarButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readOnly = !JobScope.editingOf(context, listen: true);
    return readOnly
        ? const SizedBox.shrink()
        : SizedBox.square(
            dimension: kToolbarHeight,
            child: IconButton(
              tooltip: 'Delete job',
              icon: const CircleAvatar(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(
                    Icons.delete_outline,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
              ),
              onPressed: () {
                final job = context.read<JobBLoC>().state.job;
                PageRouter.showModalDialog(
                  context,
                  (context) => _DeleteJobDialog(
                    job: job,
                  ),
                );
              },
            ),
          );
  }
}

@immutable
class _DeleteJobDialog extends StatefulWidget {
  const _DeleteJobDialog({
    required this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  State<_DeleteJobDialog> createState() => _DeleteJobDialogState();
}

class _DeleteJobDialogState extends State<_DeleteJobDialog> {
  final TextEditingController controller = TextEditingController(text: '');

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(MaterialLocalizations.of(context).deleteButtonTooltip),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(AppLocalization.localize(context).delete_confirmation),
            TextField(
              decoration: InputDecoration(
                hintText: 'DELETE',
                prefixIcon: const Icon(
                  Icons.delete,
                ),
                suffixIcon: const Icon(
                  Icons.delete,
                ),
                helperText: AppLocalization.localize(context).irreversible_action,
              ),
              controller: controller,
              maxLines: 1,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => PageRouter.pop(context),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, child) => OutlinedButton(
              onPressed: value.text.toUpperCase() == 'DELETE' ? () => _delete(context, widget.job) : null,
              style: OutlinedButton.styleFrom(
                primary: Colors.red,
              ),
              child: child!,
            ),
            child: Text(MaterialLocalizations.of(context).deleteButtonTooltip),
          ),
        ],
      );

  void _delete(BuildContext context, Job job) {
    AuthenticationScope.authenticateOr(
      context,
      (user) {
        PageRouter.maybePop(context);
        PageRouter.goHome(context);
        FeedScope.deleteJobOf(
          context,
          user: user,
          job: job,
        );
      },
    );
  }
}
