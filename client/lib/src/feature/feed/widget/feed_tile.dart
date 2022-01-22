import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/common/utils/locale_util.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

typedef FeedTileOnPressed = void Function(BuildContext context);

@immutable
abstract class FeedTile extends StatelessWidget implements PreferredSizeWidget {
  /// Высота карточки
  static double height = 180;

  @override
  Size get preferredSize => _preferredSize;
  static const Size _preferredSize = Size(
    kBodyWidth,
    180,
  );

  const FeedTile._({
    final Key? key,
  }) : super(key: key);

  const factory FeedTile.job({
    required final Job job,
    final Key? key,
  }) = _JobFeedTile;

  const factory FeedTile.loading({
    final Key? key,
  }) = _LoadingFeedTile;
}

@immutable
class _JobFeedTile extends FeedTile {
  const _JobFeedTile({
    required final this.job,
    final Key? key,
  }) : super._(key: key);

  final Job job;

  void _onTap(BuildContext context) {
    AppRouter.navigate(
      context,
      (final configuration) => JobRouteConfiguration(job.id),
    );
    RepositoryScope.of(context).analytics?.logViewItem(
      items: <AnalyticsEventItem>[
        AnalyticsEventItem(
          itemId: job.id.toString(),
          itemCategory: 'job',
          itemCategory2: job.data.remote ? 'remote' : 'office',
          itemCategory3: job.data.relocation.name.toLowerCase(),
          itemListName: 'jobs',
          itemBrand: job.data.company,
          locationId: job.data.country,
          itemName: job.data.title,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Center(
      child: SizedBox.fromSize(
        size: FeedTile._preferredSize,
        child: Card(
          color: themeData.cardColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 1,
          child: InkWell(
            onTap: () => _onTap(context),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 10,
                right: 8,
                bottom: 6,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Title (Job title)
                          _FeedTitle(job.data.title),
                          // Company
                          _FeedText(job.data.company),
                          // County, Address
                          _FeedText('${Country.byCode(job.data.country).title} '),
                          // Location
                          _FeedText(_locationRepresentation(context)),
                          // Level
                          _FeedText(_levelRepresentation(context)),
                        ],
                      ),
                    ),
                  ),
                  // Divider
                  const Divider(
                    height: 12,
                    thickness: 1,
                  ),
                  // Status bar
                  SizedBox(
                    height: 12,
                    child: DefaultTextStyle(
                      style: themeData.textTheme.overline!.copyWith(
                        fontSize: 10,
                        height: 1,
                        color: themeData.hintColor,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(width: 8),
                          _FeedTileFooterDate(job.updated),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _locationRepresentation(BuildContext context) =>
      '${job.data.remote ? context.localization.job_field_remote : context.localization.job_field_office} '
      '\u2022 '
      '${job.data.relocation.when<String>(
        impossible: () => context.localization.job_field_relocation_impossible,
        possible: () => context.localization.job_field_relocation_possible,
        required: () => context.localization.job_field_relocation_required,
      )}';

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
class _LoadingFeedTile extends FeedTile {
  const _LoadingFeedTile({
    final Key? key,
  }) : super._(key: key);

  @override
  Widget build(BuildContext context) => const Placeholder();
}

@immutable
class _FeedTitle extends StatelessWidget {
  const _FeedTitle(
    final this.text, {
    Key? key,
  }) : super(key: key);

  const _FeedTitle.skeleton({
    Key? key,
  })  : text = null,
        super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 26,
        child: text == null
            ? const _FeedSkeleton()
            : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1,
                      ),
                ),
              ),
      );
}

@immutable
class _FeedText extends StatelessWidget {
  const _FeedText(
    final this.text, {
    Key? key,
  }) : super(key: key);

  const _FeedText.skeleton({
    Key? key,
  })  : text = null,
        super(key: key);

  final String? text;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 24,
        child: text == null
            ? const _FeedSkeleton()
            : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        height: 1,
                      ),
                ),
              ),
      );
}

@immutable
class _FeedTileFooterDate extends StatelessWidget {
  const _FeedTileFooterDate(
    final this.dateTime, {
    Key? key,
  }) : super(key: key);

  const _FeedTileFooterDate.skeleton({
    Key? key,
  })  : dateTime = null,
        super(key: key);

  final DateTime? dateTime;

  @override
  Widget build(BuildContext context) => SizedBox(
        width: 128,
        child: dateTime == null
            ? const _FeedSkeleton()
            : Align(
                alignment: Alignment.centerRight,
                child: Text(
                  LocaleUtil.dateToString(context, dateTime!),
                  maxLines: 1,
                  overflow: TextOverflow.clip,
                ),
              ),
      );
}

/// Плейсхолдер Скелетон/Шиммер
@immutable
class _FeedSkeleton extends StatelessWidget {
  const _FeedSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).hoverColor,
          ),
          child: const SizedBox.expand(),
        ),
      );
}
