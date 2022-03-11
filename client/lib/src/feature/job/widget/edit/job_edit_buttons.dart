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
            return _AllowedCountdown(
              updated: state.job.updated,
              child: ElevatedButton(
                onPressed: () => _update(context),
                child: Text(context.localization.job_button_update),
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
          height: 56 * 5,
          child: _ButtonsBottomSheet(
            reset: () {
              JobEditForm.reset(context);
              Navigator.pop(context);
              FocusScope.of(context).unfocus();
            },
            view: () {
              final jobData = JobEditForm.getJobDataOrNull(context);
              if (jobData == null) {
                return;
              }
              final job = BlocProvider.of<JobBLoC>(context, listen: false).state.job.copyWith(data: jobData);
              FocusScope.of(context).unfocus();
              AppRouter.push(
                context,
                (context) => JobPreview(job: job),
                name: 'job_preview',
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

        /// Поднять в выдаче (активно только если работа уже создана)
        ListTile(
          contentPadding: contentPadding,
          enabled: false,
          title: Text(context.localization.job_button_bump),
          onTap: null,
        ),

        /// Удалить (активно только если работа уже создана)
        ListTile(
          contentPadding: contentPadding,
          enabled: false,
          title: Text(context.localization.job_button_delete),
          onTap: null,
        ),

        /// Поделится (активно только если работа уже создана)
        ListTile(
          contentPadding: contentPadding,
          enabled: false,
          title: Text(context.localization.share),
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
    required final this.child,
    Key? key,
  }) : super(key: key);

  final DateTime updated;
  final Widget child;

  @override
  State<_AllowedCountdown> createState() => _AllowedCountdownState();
}

class _AllowedCountdownState extends State<_AllowedCountdown> {
  late final Stream<String?> _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Stream<String?>.periodic(const Duration(seconds: 1)).map<String?>(
      (_) => _getCountdown(),
    );
  }

  String? _getCountdown() {
    final now = DateTime.now();
    final countdown = widget.updated.add(const Duration(days: 1)).difference(now);
    if (countdown.inHours > 0) {
      return '${countdown.inHours} ${context.localization.job_form_edit_countdown_hours}';
    } else if (countdown.inMinutes > 0) {
      return '${countdown.inMinutes} ${context.localization.job_form_edit_countdown_minutes}';
    } else if (countdown.inSeconds > 0) {
      return '${countdown.inSeconds} ${context.localization.job_form_edit_countdown_seconds}';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) => StreamBuilder<String?>(
        initialData: _getCountdown(),
        stream: _ticker,
        builder: (context, snapshot) {
          final countdown = snapshot.data;
          if (countdown != null) {
            return ElevatedButton(
              onPressed: null,
              child: Text(
                '${context.localization.job_form_edit_countdown_available}\n'
                '$countdown',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            );
          }
          return widget.child;
        },
      );
}
