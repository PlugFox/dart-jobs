import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_bottom_sheet.dart';
import 'package:dart_jobs_client/src/feature/job/widget/edit/job_edit_form.dart';
import 'package:dart_jobs_client/src/feature/job/widget/view/job_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class JobEditButtons extends StatelessWidget {
  const JobEditButtons({
    Key? key,
  }) : super(key: key);

  /// TODO:
  /// сбросить
  /// предварительный просмотр
  /// создать новое
  /// обновить существующее (таймер)
  /// бампануть существующее (таймер)
  /// удалить существующее (таймер)
  ///
  /// Основная кнопка и квадрат [...] вызывающий боттом шит
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 48,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const <Widget>[
            Expanded(
              child: SizedBox(
                height: 48,
                child: _PrimaryButton(),
              ),
            ),
            SizedBox(width: 12),
            SizedBox.square(
              dimension: 48,
              child: _SecondaryButton(),
            ),
          ],
        ),
      );
}

@immutable
class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<JobBLoC, JobState>(
        builder: (context, state) => state.maybeMap<Widget>(
          orElse: () => const SizedBox.shrink(),
          processed: (state) => ElevatedButton(
            onPressed: null,
            child: Text(context.localization.job_button_update),
          ),
          idle: (state) {
            if (state.job.hasNotID) {
              return ElevatedButton(
                onPressed: () => _create(context),
                child: Text(context.localization.job_button_create),
              );
            }
            final allow = DateTime.now().difference(state.job.updated).inDays.abs() > 1;
            if (allow) {
              return ElevatedButton(
                onPressed: () => _update(context),
                child: Text(context.localization.job_button_update),
              );
            }
            return ElevatedButton(
              onPressed: null,
              child: _AllowedCountdown(
                updated: state.job.updated,
              ),
            );
          },
        ),
      );

  void _create(BuildContext context) {
    final jobData = JobEditForm.getJobDataOrNull(context);
    if (jobData == null) {
      return;
    }
    BlocProvider.of<JobBLoC>(context).add(JobEvent.create(data: jobData));
  }

  void _update(BuildContext context) {
    final jobData = JobEditForm.getJobDataOrNull(context);
    if (jobData == null) {
      return;
    }
    BlocProvider.of<JobBLoC>(context).add(JobEvent.update(data: jobData));
  }
}

@immutable
class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () => JobBottomSheet.show(
          context: context,
          height: 56 * 4,
          child: _ButtonsBottomSheet(
            reset: () {
              JobEditForm.reset(context);
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            view: () {
              FocusScope.of(context).unfocus();
              final jobData = JobEditForm.getJobDataOrNull(context);
              if (jobData == null) {
                return;
              }
              final job = BlocProvider.of<JobBLoC>(context).state.job.copyWith(data: jobData);
              AppRouter.push(
                context,
                (context) => JobView(job: job),
              );
            },
          ),
        ),
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xFFF2F3F5),
          ),
        ),
        child: Center(
          child: Icon(
            Icons.more_horiz,
            color: Theme.of(context).primaryColor,
          ),
        ),
      );
}

@immutable
class _ButtonsBottomSheet extends StatelessWidget {
  const _ButtonsBottomSheet({
    required final this.reset,
    required final this.view,
    Key? key,
  }) : super(key: key);

  final VoidCallback reset;
  final VoidCallback view;

  @override
  Widget build(BuildContext context) {
    final contentPadding = EdgeInsets.symmetric(
      horizontal: math.max<double>(
        (MediaQuery.of(context).size.width - kBodyWidth) / 2,
        16,
      ),
      vertical: 0,
    );
    return ListView(
      physics: const BouncingScrollPhysics(),
      itemExtent: 56,
      children: <Widget>[
        /// Сбросить изменения
        ListTile(
          enabled: true,
          contentPadding: contentPadding,
          title: Text(context.localization.job_button_reset),
          onTap: reset,
        ),

        /// Предварительный просмотр
        ListTile(
          contentPadding: contentPadding,
          enabled: true,
          title: Text(context.localization.job_button_preview),
          onTap: view,
        ),

        /// Поднять в выдаче
        ListTile(
          contentPadding: contentPadding,
          enabled: false,
          title: Text(context.localization.job_button_bump),
          onTap: null,
        ),

        /// Удалить
        ListTile(
          contentPadding: contentPadding,
          enabled: false,
          title: Text(context.localization.job_button_delete),
          onTap: null,
        ),
      ],
    );
  }
}

@immutable
class _AllowedCountdown extends StatefulWidget {
  const _AllowedCountdown({
    required final this.updated,
    Key? key,
  }) : super(key: key);

  final DateTime updated;

  @override
  State<_AllowedCountdown> createState() => _AllowedCountdownState();
}

class _AllowedCountdownState extends State<_AllowedCountdown> {
  final Stream<void> _ticker = Stream<void>.periodic(const Duration(seconds: 1));

  String get _countdown {
    final now = DateTime.now();
    final countdown = widget.updated.add(const Duration(days: 1)).difference(now);
    if (countdown.inHours > 0) {
      return '${countdown.inHours} ${context.localization.job_form_edit_countdown_hours}';
    } else if (countdown.inMinutes > 0) {
      return '${countdown.inMinutes} ${context.localization.job_form_edit_countdown_minutes}';
    } else {
      return '${countdown.inSeconds} ${context.localization.job_form_edit_countdown_seconds}';
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder(
        initialData: null,
        stream: _ticker,
        builder: (context, snapshot) => Text(
          '${context.localization.job_form_edit_countdown_available}\n'
          '$_countdown',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      );
}
