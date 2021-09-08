import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fox_flutter_bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:platform_info/platform_info.dart';

import '../../../common/constant/layout_constraints.dart';
import '../../../common/widget/proposal_field.dart';
import '../../../common/widget/proposal_form.dart';
import '../../authentication/model/user_entity.dart';
import '../../authentication/widget/authentication_scope.dart';
import '../bloc/job_bloc.dart';
import '../model/job.dart';
import 'job_scope.dart';

@immutable
class JobScreen extends StatelessWidget {
  const JobScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<JobBLoC, JobState>(
        builder: (context, state) => ProposalForm<Job>(
          initialData: state.job,
          child: BlocListener<JobBLoC, JobState>(
            listener: (context, state) {
              // Если состояние загрузки - забираем возможность редактировать
              state.maybeMap<void>(
                orElse: () {},
                fetching: (_) => ProposalForm.switchToRead(context),
              );
            },
            child: Scaffold(
              appBar: AppBar(
                title: state.when<Widget>(
                  fetching: (job) => const Text('Job loading...'),
                  filled: (job) => Text('Job #${job.id}'),
                  error: (job, message) => const Text('Job error'),
                  removed: (job) => const Text('Removed'),
                ),
                actions: const <Widget>[
                  _CancelEditAppBarButton(),
                  SizedBox(width: 15),
                ],
              ),
              body: const SafeArea(
                child: _JobScreenBody(),
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

  void _onPressed(BuildContext context) {
    final status = ProposalForm.statusOf(context, listen: false);
    switch (status) {
      case ProposalFormStatus.read:
        // Сейчас статус - редактирование, следовательно мы хотим начать редактировать
        ProposalForm.switchToEdit(context);
        break;
      case ProposalFormStatus.edit:
      default:
        // Сейчас статус - редактирование, следовательно мы хотим сохранить результат
        final currentData = ProposalForm.getDataOf<Job>(context, listen: false);
        JobScope.saveJobOf(context, currentData);
        //ProposalForm.switchToRead(context);
        break;
    }
    //ProposalForm.toggle(context);
  }

  @override
  Widget build(BuildContext context) {
    final status = ProposalForm.statusOf(context);
    return BlocBuilder<JobBLoC, JobState>(
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
        final fetching = state.maybeMap<bool>(orElse: () => false, fetching: (_) => true);
        return FloatingActionButton(
          onPressed: fetching ? null : () => _onPressed(context),
          backgroundColor:
              fetching ? Theme.of(context).disabledColor : Theme.of(context).floatingActionButtonTheme.backgroundColor,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: child,
            ),
            child: Icon(
              status == ProposalFormStatus.read ? Icons.edit : Icons.cancel_outlined,
              key: ValueKey(status),
              size: 30,
            ),
          ),
        );
      },
    );
  }
}

@immutable
class _CancelEditAppBarButton extends StatelessWidget {
  const _CancelEditAppBarButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ProposalForm.statusOf(context) == ProposalFormStatus.edit
      ? SizedBox.square(
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
              ProposalForm.switchToRead(context);
            },
          ),
        )
      : const SizedBox.shrink();
}

@immutable
class _JobScreenBody extends StatelessWidget {
  const _JobScreenBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FocusScope(
        child: ListView(
          physics: const ClampingScrollPhysics(),
          cacheExtent: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(
            horizontal: math.max((MediaQuery.of(context).size.width - maxFeedWidth) / 2, 8), // 550 px - max width
            vertical: 24,
          ),
          children: <Widget>[
            if (platform.buildMode.isDebug) ...<Widget>[
              ProposalFormTextField<Job>.singleLine(
                (job) => job.id,
                label: 'id',
                enabled: true,
                onLostFocus: (text, job) => Job(
                  id: text,
                  creatorId: job.creatorId,
                  title: job.title,
                  updated: job.updated,
                  created: job.created,
                  attributes: job.attributes,
                  pinned: job.pinned,
                ),
              ),
              ProposalFormTextField<Job>.singleLine(
                (job) => job.creatorId,
                label: 'creatorId',
                onLostFocus: (text, job) => Job(
                  id: job.id,
                  creatorId: text,
                  title: job.title,
                  updated: job.updated,
                  created: job.created,
                  attributes: job.attributes,
                  pinned: job.pinned,
                ),
              ),
              ProposalFormTextField<Job>.singleLine(
                (job) => job.created.toIso8601String(),
                label: 'created',
                enabled: false,
              ),
              ProposalFormTextField<Job>.singleLine(
                (job) => job.updated.toIso8601String(),
                label: 'updated',
                enabled: false,
              ),
              ProposalFormTextField<Job>.singleLine(
                (job) => job.pinned ? 'yes' : 'no',
                label: 'pinned',
                enabled: false,
              ),
            ],

            /// Заголовок
            ProposalFormTextField<Job>.singleLine(
              (job) => job.title,
              label: 'Заголовок',
            ),

            /// Название компании
            ProposalFormTextField<Job>.singleLine(
              (job) => job.getAttribute<CompanyJobAttribute>()?.title ?? '',
              label: 'Название компании',
              onLostFocus: (text, job) => job.setAttribute(
                CompanyJobAttribute(
                  title: text,
                ),
              ),
            ),

            /// Местоположение
            ProposalFormTextField<Job>.singleLine(
              (job) => job.getAttribute<LocationJobAttribute>()?.country ?? '',
              label: 'Страна',
              onLostFocus: (text, job) => job.setAttribute(
                LocationJobAttribute(
                  country: text,
                  address: job.getAttribute<LocationJobAttribute>()?.address ?? '',
                ),
              ),
            ),
            ProposalFormTextField<Job>.singleLine(
              (job) => job.getAttribute<LocationJobAttribute>()?.address ?? '',
              label: 'Адрес',
              onLostFocus: (text, job) => job.setAttribute(
                LocationJobAttribute(
                  country: job.getAttribute<LocationJobAttribute>()?.country ?? '',
                  address: text,
                ),
              ),
            ),

            /// Описание
            ProposalFormTextField<Job>.multiLine(
              (job) => job.getAttribute<DescriptionJobAttribute>()?.description ?? '',
              label: 'Описание',
              finishEditing: true,
              onLostFocus: (text, job) => job.setAttribute(
                DescriptionJobAttribute(
                  description: text,
                ),
              ),
            ),
          ],
        ),
      );
}
