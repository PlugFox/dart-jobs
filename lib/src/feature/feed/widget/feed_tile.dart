import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:platform_info/platform_info.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/constant/layout_constraints.dart';
import '../../feed/model/job.dart';

@immutable
abstract class FeedTile extends StatelessWidget implements PreferredSizeWidget {
  /// Высота карточки
  static double height = 180;

  @override
  Size get preferredSize => _preferredSize;
  static const Size _preferredSize = Size(
    maxFeedWidth,
    180,
  );

  final Widget title;
  final Widget subtitle;
  final Widget location;
  final Widget salary;
  final VoidCallback? onPressed;

  const FeedTile._({
    required final this.title,
    required final this.subtitle,
    required final this.location,
    required final this.salary,
    required final this.onPressed,
    Key? key,
  }) : super(key: key);

  factory FeedTile.job({
    required final Job job,
    Key? key,
  }) = _JobFeedTile;

  const factory FeedTile.loading({
    Key? key,
  }) = _LoadingFeedTile;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final enabled = onPressed != null;
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
            onTap: onPressed,
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
                      style: themeData.textTheme.overline!,
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Spacer(flex: 1),
                          Icon(
                            Icons.add,
                            size: 12,
                          ),
                          Spacer(flex: 2),
                          Text('abcd'),
                          Spacer(flex: 2),
                          Text('1234'),
                          Spacer(flex: 2),
                          Text('efge'),
                          Spacer(flex: 2),
                          Text('5678'),
                          Spacer(flex: 1),
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
    Key? key,
  }) : super._(
          title: _ShimmerTitle(text: 'Title (Job name, Developer name)'),
          subtitle: _ShimmerText(text: 'Subtitle (Company, Developer occupation)'),
          location: _ShimmerText(text: 'Location'),
          salary: _ShimmerText(text: 'Salary'),
          onPressed: () {},
          key: key,
        );
}

@immutable
class _LoadingFeedTile extends FeedTile {
  const _LoadingFeedTile({
    Key? key,
  }) : super._(
          key: key,
          title: const _ShimmerTitle.enabled(),
          subtitle: const _ShimmerText.enabled(),
          location: const _ShimmerText.enabled(),
          salary: const _ShimmerText.enabled(),
          onPressed: null,
        );
}

@immutable
class _ShimmerTitle extends StatelessWidget {
  final String? text;

  const _ShimmerTitle({
    final this.text = '',
    Key? key,
  }) : super(key: key);

  const _ShimmerTitle.enabled({
    Key? key,
  })  : text = null,
        super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 24,
        child: text == null
            ? const _ShimmerExpand()
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
    Key? key,
  }) : super(key: key);

  const _ShimmerText.enabled({
    Key? key,
  })  : text = null,
        super(key: key);

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 22,
        child: text == null
            ? const _ShimmerExpand()
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
class _ShimmerExpand extends StatelessWidget {
  const _ShimmerExpand({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => platform.isWeb
      ? _fill(Theme.of(context).hoverColor)
      : Shimmer.fromColors(
          enabled: true,
          highlightColor: Colors.transparent,
          baseColor: Theme.of(context).hoverColor,
          child: _fill(Theme.of(context).cardColor),
        );

  static Widget _fill(Color color) => Padding(
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
