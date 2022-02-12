import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/widget/adaptive_scaffold.dart';
import 'package:dart_jobs_client/src/common/widget/error_snackbar.dart';
import 'package:dart_jobs_client/src/feature/job/bloc/job_bloc.dart';
import 'package:dart_jobs_client/src/feature/job/widget/view/share_button.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Просмотр существующей работы
@immutable
class JobView extends StatelessWidget {
  const JobView({
    required final this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) => AdaptiveScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            job.data.title,
            maxLines: 1,
          ),
        ),
        floatingActionButton: ShareButton(job: job),
        body: BlocListener<JobBLoC, JobState>(
          listener: (context, state) => state.mapOrNull<void>(
            error: (state) => ScaffoldMessenger.of(context).showSnackBar(
              ErrorSnackBar(
                error: state.message,
              ),
            ),
          ),
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: FocusScope(
                child: _JobContent(
                  job: job,
                ),
              ),
            ),
          ),
        ),
      );
}

/// Предпросмотр редактируемой работы
@immutable
class JobPreview extends StatelessWidget {
  const JobPreview({
    required final this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) => AdaptiveScaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            job.data.title,
            maxLines: 1,
          ),
        ),
        floatingActionButton: ShareButton(job: job),
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: FocusScope(
              child: _JobContent(
                job: job,
              ),
            ),
          ),
        ),
      );
}

@immutable
class _JobContent extends StatelessWidget {
  const _JobContent({
    required final this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    // 620 px - max width
    final horizontalPadding = math.max<double>(
      (MediaQuery.of(context).size.width - kBodyWidth) / 2,
      8,
    );
    return ListView(
      physics: const ClampingScrollPhysics(),
      cacheExtent: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(
        top: 14,
        left: horizontalPadding,
        right: horizontalPadding,
        bottom: 80,
      ),
      children: <Widget>[
        /// ID
        //Text(job.id.toString()),

        /// Updated
        //Text(LocaleUtil.dateToString(context, job.updated)),

        /// Основные данные
        _JobViewHeader(
          job: job,
        ),

        const SizedBox(height: 12),

        /// Описание работы
        if (job.data.descriptions.isNotEmpty)
          _JobViewDescription(
            job: job,
          ),
      ],
    );
  }
}

@immutable
class _JobViewHeader extends StatelessWidget {
  const _JobViewHeader({
    required final this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              /// Название компании
              _JobViewHeaderRow(
                icon: Icons.group,
                title: context.localization.job_field_company_title,
                content: job.data.company,
              ),

              /// Страна
              _JobViewHeaderRow(
                icon: Icons.language,
                title: context.localization.job_field_location_country,
                content: Country.byCode(job.data.country).title,
              ),

              /// Местоположение
              if (job.data.address.isNotEmpty)
                _JobViewHeaderRow(
                  icon: Icons.map,
                  title: context.localization.job_field_location_address,
                  content: job.data.address,
                ),

              /// Локация работы
              _JobViewHeaderRow(
                icon: Icons.location_on_rounded,
                title: context.localization.job_field_location,
                content: _locationRepresentation(context),
              ),

              /// Возможное трудоустройство
              _JobViewHeaderRow(
                icon: Icons.work,
                title: context.localization.job_type,
                content: _employmentRepresentation(context),
              ),

              /// Уровень разработчика
              _JobViewHeaderRow(
                icon: Icons.code,
                title: context.localization.developer_level,
                content: _levelRepresentation(context),
              ),
            ],
          ),
        ),
      );

  String _locationRepresentation(BuildContext context) =>
      '${job.data.remote ? context.localization.job_field_remote : context.localization.job_field_office} '
      '\u2022 '
      '${job.data.relocation.when<String>(
        impossible: () => context.localization.job_field_relocation_impossible,
        possible: () => context.localization.job_field_relocation_possible,
        required: () => context.localization.job_field_relocation_required,
      )}';

  String _employmentRepresentation(BuildContext context) {
    final employments = job.data.employments;
    if (employments.isEmpty) return '';
    if (employments.length == Employment.values.length) return context.localization.job_type_any;

    String representation(Employment level) => level.when(
          fullTime: () => context.localization.job_type_full_time,
          partTime: () => context.localization.job_type_part_time,
          oneTime: () => context.localization.job_type_one_time,
          contract: () => context.localization.job_type_contract,
          openSource: () => context.localization.job_type_open_source,
          collaboration: () => context.localization.job_type_collaboration,
        );

    if (employments.length == 1) return representation(employments.first);
    return employments.map<String>(representation).join(' \u2022 ');
  }

  String _levelRepresentation(BuildContext context) {
    final levels = job.data.levels;
    if (levels.isEmpty) return '';
    if (levels.length == DeveloperLevel.values.length) return context.localization.developer_level_any;

    String representation(DeveloperLevel level) => level.when<String>(
          intern: () => context.localization.developer_level_intern,
          junior: () => context.localization.developer_level_junior,
          middle: () => context.localization.developer_level_middle,
          senior: () => context.localization.developer_level_senior,
          lead: () => context.localization.developer_level_lead,
        );

    if (levels.length == 1) return representation(levels.first);
    levels.sort((a, b) => a.value.compareTo(b.value));
    if (levels.length < 5) {
      return levels.map<String>(representation).join(' \u2022 ');
    }
    return '${representation(levels.first)} - ${representation(levels.last)}';
  }
}

@immutable
class _JobViewHeaderRow extends StatelessWidget {
  const _JobViewHeaderRow({
    required final this.icon,
    required final this.title,
    required final this.content,
    Key? key,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 42,
        child: Tooltip(
          message: content,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  size: 28,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.caption?.copyWith(height: 1),
                      ),
                      Text(
                        content,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(height: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}

@immutable
class _JobViewDescription extends StatelessWidget {
  const _JobViewDescription({
    required final this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
            left: 12,
            right: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  context.localization.job_field_description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        height: 1,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                _getDescription(context),
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ),
      );

  String _getDescription(BuildContext context) {
    final description = job.data.descriptions[Localizations.localeOf(context).languageCode];
    if (description != null && description.isNotEmpty) return description;
    if (job.data.englishDescription.isNotEmpty) return job.data.englishDescription;
    return (job.data.descriptions.values.toList()..sort((a, b) => b.length.compareTo(a.length))).first;
  }
}
