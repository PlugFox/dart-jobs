import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:platform_info/platform_info.dart';

import '../../../common/constant/layout_constraints.dart';
import '../bloc/job_bloc.dart';
import '../model/job.dart';
import 'job_field.dart';
import 'job_form.dart';

@immutable
class JobScreen extends StatelessWidget {
  const JobScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => JobForm(
        child: Scaffold(
          appBar: AppBar(
            title: BlocBuilder<JobBLoC, JobState>(
              builder: (context, state) => state.when<Widget>(
                fetching: (job) => const Text('Job loading...'),
                filled: (job) => Text('Job #${job.id}'),
                error: (job, message) => const Text('Job error'),
                removed: (job) => const Text('Removed'),
              ),
            ),
          ),
          body: SafeArea(
            child: BlocBuilder<JobBLoC, JobState>(
              builder: (context, state) => state.maybeMap<Widget>(
                orElse: () => _JobScreenBody(
                  job: state.job,
                  processing: true,
                ),
                fetching: (_) => _JobScreenBody(
                  job: state.job,
                  processing: true,
                ),
              ),
            ),
          ),
          floatingActionButton: const _JobScreenFloatingActionButton(),
        ),
      );
}

@immutable
class _JobScreenFloatingActionButton extends StatelessWidget {
  const _JobScreenFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final status = JobForm.statusOf(context);
    return FloatingActionButton(
      onPressed: () => JobForm.toggle(context),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 350),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: animation,
          child: child,
        ),
        child: Icon(
          status == JobFormStatus.read ? Icons.edit : Icons.save,
          key: ValueKey(status),
        ),
      ),
    );
  }
}

@immutable
class _JobScreenBody extends StatefulWidget {
  final bool processing;
  final Job job;
  const _JobScreenBody({
    required this.job,
    required this.processing,
    Key? key,
  }) : super(key: key);

  @override
  State<_JobScreenBody> createState() => _JobScreenBodyState();
}

class _JobScreenBodyState extends State<_JobScreenBody> {
  // Текущее состояние которое мы мутируем для последующего сохранения
  late Job _job;

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    _job = widget.job;
  }

  @override
  void didUpdateWidget(_JobScreenBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    _job = widget.job;
  }
  //endregion

  @override
  Widget build(BuildContext context) => ListView(
        physics: const ClampingScrollPhysics(),
        cacheExtent: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          horizontal: math.max((MediaQuery.of(context).size.width - maxFeedWidth) / 2, 8), // 550 px - max width
          vertical: 24,
        ),
        children: <Widget>[
          if (platform.buildMode.isDebug) ...<Widget>[
            JobTextField.singleLine(
              _job.id.isEmpty ? '<empty>' : _job.id,
              label: 'id',
              enabled: true,
              onChanged: (s) => _job = Job(
                id: s,
                creatorId: _job.creatorId,
                title: _job.title,
                updated: _job.updated,
                created: _job.created,
                attributes: _job.attributes,
                pinned: _job.pinned,
              ),
            ),
            JobTextField.singleLine(
              _job.creatorId,
              label: 'creatorId',
              onChanged: (s) => _job = Job(
                id: _job.id,
                creatorId: s,
                title: _job.title,
                updated: _job.updated,
                created: _job.created,
                attributes: _job.attributes,
                pinned: _job.pinned,
              ),
            ),
            JobTextField.singleLine(
              _job.created.toIso8601String(),
              label: 'created',
              enabled: false,
            ),
            JobTextField.singleLine(
              _job.updated.toIso8601String(),
              label: 'updated',
              enabled: false,
            ),
            JobTextField.singleLine(
              _job.pinned ? 'yes' : 'no',
              label: 'pinned',
              enabled: false,
            ),
          ],
          JobTextField.singleLine(
            _job.title,
            label: 'title',
          ),
        ],
      );
}
