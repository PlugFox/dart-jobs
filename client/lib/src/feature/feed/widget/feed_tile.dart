import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/router/router.dart';
import 'package:dart_jobs_client/src/feature/initialization/widget/repository_scope.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:platform_info/platform_info.dart';

typedef FeedTileOnPressed = void Function(BuildContext context);

@immutable
abstract class FeedTile extends StatelessWidget implements PreferredSizeWidget {
  /// Высота карточки
  static double height = 180;

  @override
  Size get preferredSize => _preferredSize;
  static const Size _preferredSize = Size(
    bodyWidth,
    180,
  );

  final Widget title;
  final Widget subtitle;
  final Widget location;
  final Widget salary;
  final Widget date;
  final FeedTileOnPressed? onPressed;

  const FeedTile._({
    required final this.title,
    required final this.subtitle,
    required final this.location,
    required final this.salary,
    required final this.onPressed,
    required final this.date,
    final Key? key,
  }) : super(key: key);

  factory FeedTile.job({
    required final Job job,
    final Key? key,
  }) = _JobFeedTile;

  const factory FeedTile.loading({
    final Key? key,
  }) = _LoadingFeedTile;

  @override
  Widget build(final BuildContext context) {
    final themeData = Theme.of(context);
    final callback = onPressed;
    final enabled = callback != null;
    return Center(
      child: SizedBox.fromSize(
        size: _preferredSize,
        child: Card(
          color: enabled ? themeData.cardColor : themeData.cardColor.withAlpha(225),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 1,
          child: InkWell(
            onTap: callback == null ? null : () => callback(context),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                top: 15,
                right: 15,
                bottom: 7,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Title (Job name, Developer name)
                  title,
                  const Spacer(),
                  // Subtitle (Company, Developer occupation)
                  subtitle,
                  const Spacer(),
                  // Location
                  location,
                  const Spacer(),
                  // Salary
                  salary,
                  const Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Divider(
                        height: 15,
                        thickness: 1,
                      ),
                    ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Spacer(flex: 1),
                          const Icon(Icons.add, size: 12),
                          const Spacer(flex: 2),
                          const Text('abcd'),
                          const Spacer(flex: 2),
                          const Text('1234'),
                          const Spacer(flex: 2),
                          const Text('efge'),
                          const Spacer(flex: 2),
                          SizedBox(
                            width: 90,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: date,
                            ),
                          ),
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
}

@immutable
class _JobFeedTile extends FeedTile {
  final Job job;

  _JobFeedTile({
    required final this.job,
    final Key? key,
  }) : super._(
          title: _ShimmerTitle(
            text: job.data.title,
          ), // 'Title (Job name, Developer name)'
          subtitle: _ShimmerText(
            text: job.data.company,
          ), // 'Subtitle (Company, Developer occupation)'
          location: _ShimmerText(
            text: job.data.remote ? 'Remote' : job.data.country,
          ), // 'Location'
          salary: const _ShimmerText(
            text: 'Unknown salary',
          ), // 'Salary'
          date: _FeedUnderlineDateTime(
            date: job.updated,
          ),

          /// TODO: DateFormat
          onPressed: (final context) {
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
          },
          key: key,
        );
}

@immutable
class _LoadingFeedTile extends FeedTile {
  const _LoadingFeedTile({
    final Key? key,
  }) : super._(
          key: key,
          title: const _ShimmerTitle.enabled(),
          subtitle: const _ShimmerText.enabled(),
          location: const _ShimmerText.enabled(),
          salary: const _ShimmerText.enabled(),
          date: const _FeedUnderlineDateTime.shimmer(),
          onPressed: null,
        );
}

@immutable
class _ShimmerTitle extends StatelessWidget {
  final String? text;

  const _ShimmerTitle({
    final this.text = '',
    final Key? key,
  }) : super(key: key);

  const _ShimmerTitle.enabled({
    final Key? key,
  })  : text = null,
        super(key: key);

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: 24,
        child: text == null
            ? const _ShimmerPlaceholderPlatform()
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
class _ShimmerText extends StatelessWidget {
  final String? text;

  const _ShimmerText({
    final this.text = '',
    final Key? key,
  }) : super(key: key);

  const _ShimmerText.enabled({
    final Key? key,
  })  : text = null,
        super(key: key);

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: 22,
        child: text == null
            ? const _ShimmerPlaceholderPlatform()
            : Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  text ?? '',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        height: 1,
                      ),
                ),
              ),
      );
}

@immutable
class _ShimmerUnderline extends StatelessWidget {
  final Widget? child;

  const _ShimmerUnderline({
    final this.child,
    final Key? key,
  }) : super(key: key);

  const _ShimmerUnderline.enabled({
    final Key? key,
  })  : child = null,
        super(key: key);

  @override
  Widget build(final BuildContext context) => SizedBox(
        height: 12,
        child: child == null
            ? const _ShimmerPlaceholderPlatform()
            : Align(
                alignment: Alignment.centerLeft,
                child: child,
              ),
      );
}

/// Плейсхолдер Скелетон/Шиммер отображающий в вебе упрощенную анимацию
@immutable
class _ShimmerPlaceholderPlatform extends StatelessWidget {
  const _ShimmerPlaceholderPlatform({
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => platform.isWeb
      ? _ShimmerPlaceholder(color: Theme.of(context).hoverColor)
      : _ShimmerPlaceholder(color: Theme.of(context).cardColor);
}

/// Плейсхолдер Скелетон/Шиммер
@immutable
class _ShimmerPlaceholder extends StatelessWidget {
  final Color color;
  const _ShimmerPlaceholder({
    required final this.color,
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) => Padding(
        padding: const EdgeInsets.all(2),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: color,
          ),
          child: const SizedBox.expand(),
        ),
      );
}

@immutable
class _FeedUnderlineDateTime extends StatelessWidget {
  static final _hms = DateFormat.Hms();
  final DateTime? _date;
  const _FeedUnderlineDateTime({
    required final DateTime date,
    final Key? key,
  })  : _date = date,
        super(key: key);

  const _FeedUnderlineDateTime.shimmer({
    final Key? key,
  })  : _date = null,
        super(key: key);

  @override
  Widget build(final BuildContext context) {
    final date = _date;
    if (date == null) return const _ShimmerUnderline.enabled();
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month && date.day == now.day) {
      return _ShimmerUnderline(
        child: _FeedUnderlineDateTimeText(
          _hms.format(date),
        ),
      );
    } else if (date.year == now.year) {
      return _ShimmerUnderline(
        child: _FeedUnderlineDateTimeText(
          context.formatDate(date, DateFormat.MONTH_DAY),
        ),
      );
    } else {
      return _ShimmerUnderline(
        child: _FeedUnderlineDateTimeText(
          context.formatDate(date, DateFormat.YEAR_ABBR_MONTH_DAY),
        ),
      );
    }
  }
}

@immutable
class _FeedUnderlineDateTimeText extends StatelessWidget {
  final String text;
  const _FeedUnderlineDateTimeText(
    final this.text, {
    final Key? key,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    final themeData = Theme.of(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        textAlign: TextAlign.right,
        style: themeData.textTheme.overline?.copyWith(
          fontSize: 10,
          height: 1,
          color: themeData.hintColor,
        ),
      ),
    );
  }
}
