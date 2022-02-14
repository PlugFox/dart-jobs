import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:dart_jobs_client/src/common/widget/successful_snackbar.dart';
import 'package:dart_jobs_shared/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:l/l.dart';
import 'package:platform_info/platform_info.dart';
import 'package:share_plus/share_plus.dart';

@immutable
class ShareButton extends StatelessWidget {
  const ShareButton({
    required final this.job,
    Key? key,
  }) : super(
          key: key,
        );

  final Job job;

  @override
  Widget build(BuildContext context) => job.hasID ? _ShareButton(job: job) : const SizedBox.shrink();
}

@immutable
class _ShareButton extends StatefulWidget {
  const _ShareButton({
    required final this.job,
    Key? key,
  }) : super(key: key);

  final Job job;

  @override
  State<_ShareButton> createState() => _ShareButtonState();
}

class _ShareButtonState extends State<_ShareButton> with SingleTickerProviderStateMixin {
  static const double _iconSize = 64;
  late final AnimationController _controller;
  late final FlowDelegate _flowDelegate;

  final List<Widget> _actions = <Widget>[
    _ShareText(),
    _CopyText(),
    if (platform.isIO && platform.isMobile) _ShareQR(),
  ];

  bool get opened {
    switch (_controller.status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        return false;
      case AnimationStatus.forward:
      case AnimationStatus.completed:
        return true;
    }
  }

  bool get closed => !opened;

  //region Lifecycle
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _flowDelegate = _ShareButtonFlowDelegate(controller: _controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  //endregion

  void toggle() {
    switch (_controller.status) {
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        _controller.forward();
        break;
      case AnimationStatus.completed:
      case AnimationStatus.forward:
        _controller.reverse();
        break;
    }
  }

  @override
  Widget build(BuildContext context) => LayoutBuilder(
        builder: (context, constraints) => SizedBox.square(
          dimension: constraints.biggest.shortestSide,
          child: Align(
            alignment: Alignment.bottomRight,
            child: Flow(
              delegate: _flowDelegate,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) => FloatingActionButton(
                    onPressed: toggle,
                    backgroundColor:
                        opened ? Colors.blueGrey : Theme.of(context).floatingActionButtonTheme.backgroundColor,
                    child: AnimatedCrossFade(
                      duration: const Duration(milliseconds: 350),
                      firstChild: const Icon(Icons.close),
                      secondChild: const Icon(Icons.share),
                      crossFadeState: opened ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    ),
                  ),
                ),
                ..._actions,
              ],
            ),
          ),
        ),
      );
}

class _ShareButtonFlowDelegate extends FlowDelegate {
  _ShareButtonFlowDelegate({required final this.controller}) : super(repaint: controller);

  final ValueListenable<double> controller;

  @override
  void paintChildren(FlowPaintingContext context) {
    final totalCount = context.childCount;
    if (totalCount == 0) return;
    const iconSize = _ShareButtonState._iconSize;
    const padding = 12;
    const offset = iconSize * 1.75;
    final size = context.size;

    final centerX = size.width - iconSize - padding;
    final centerY = size.height - iconSize - padding;

    context.paintChild(
      0,
      transform: Matrix4.translationValues(
        centerX,
        centerY,
        0,
      ),
    );

    final radialCount = totalCount - 1;
    const lastPositionAngle = math.pi * 3 / 2;
    final offsetAngle = (90 / (radialCount - 1)) * math.pi / 180;
    final transition = math.pi / 2 * (1 - controller.value);

    for (var i = 0; i < radialCount; i++) {
      final x = offset * math.cos(lastPositionAngle - i * offsetAngle - transition);
      final y = offset * math.sin(lastPositionAngle - i * offsetAngle - transition);
      context.paintChild(
        i + 1,
        transform: Matrix4.translationValues(
          centerX + x,
          centerY + y,
          0,
        ),
        opacity: controller.value,
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}

@immutable
class _ShareText extends StatelessWidget {
  const _ShareText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () async {
          try {
            final job = context.findAncestorWidgetOfExactType<ShareButton>()?.job;
            if (job == null) return;
            final localized = context.localization;
            final text = _getText(job, localized);
            await Share.share(text);
          } on Object catch (error, stackTrace) {
            l.w('Ошибка копирования текста: "$error"', stackTrace);
          }
        },
        child: const Icon(Icons.send),
      );
}

@immutable
class _CopyText extends StatelessWidget {
  const _CopyText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () async {
          try {
            final job = context.findAncestorWidgetOfExactType<ShareButton>()?.job;
            if (job == null) return;
            final localized = context.localization;
            final text = _getText(job, localized);
            final messenger = ScaffoldMessenger.of(context);
            await Clipboard.setData(ClipboardData(text: text));
            messenger.showSnackBar(SuccessfulSnackBar()); // успешно скопировано
          } on Object catch (error, stackTrace) {
            l.w('Ошибка копирования текста: "$error"', stackTrace);
          }
        },
        child: const Icon(Icons.copy),
      );
}

@immutable
class _ShareQR extends StatelessWidget {
  const _ShareQR({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
        onPressed: () async {
          try {
            final job = context.findAncestorWidgetOfExactType<ShareButton>()?.job;
            if (job == null) return;

            /// TODO: поделится изображением на мобилках, в вебе и на остальных платформах
            /// https://benkaiser.dev/sharing-images-using-the-web-share-api/
            /// https://github.com/thomas-vl/share_everywhere
            //await Share.shareFiles([]);
          } on Object catch (error, stackTrace) {
            l.w('Не смогли поделиться файлом: "$error"', stackTrace);
          }
        },
        child: const Icon(Icons.qr_code),
      );
}

// ignore: long-method
String _getText(Job job, Localized localized) {
  String locationRepresentation() => '${job.data.remote ? localized.job_field_remote : localized.job_field_office} '
      '\u2022 '
      '${job.data.relocation.when<String>(
        impossible: () => localized.job_field_relocation_impossible,
        possible: () => localized.job_field_relocation_possible,
        required: () => localized.job_field_relocation_required,
      )}';

  String employmentRepresentation() {
    final employments = job.data.employments;
    if (employments.isEmpty) return '';
    if (employments.length == Employment.values.length) return localized.job_type_any;

    String representation(Employment level) => level.when(
          fullTime: () => localized.job_type_full_time,
          partTime: () => localized.job_type_part_time,
          oneTime: () => localized.job_type_one_time,
          contract: () => localized.job_type_contract,
          openSource: () => localized.job_type_open_source,
          collaboration: () => localized.job_type_collaboration,
        );

    if (employments.length == 1) return representation(employments.first);
    return employments.map<String>(representation).join(' \u2022 ');
  }

  String levelRepresentation() {
    final levels = job.data.levels;
    if (levels.isEmpty) return '';
    if (levels.length == DeveloperLevel.values.length) return localized.developer_level_any;

    String representation(DeveloperLevel level) => level.when<String>(
          intern: () => localized.developer_level_intern,
          junior: () => localized.developer_level_junior,
          middle: () => localized.developer_level_middle,
          senior: () => localized.developer_level_senior,
          lead: () => localized.developer_level_lead,
        );

    if (levels.length == 1) return representation(levels.first);
    levels.sort((a, b) => a.value.compareTo(b.value));
    if (levels.length < 5) {
      return levels.map<String>(representation).join(' \u2022 ');
    }
    return '${representation(levels.first)} - ${representation(levels.last)}';
  }

  final buffer = StringBuffer()
    // Заголовок работы
    ..write(localized.job_field_title)
    ..write(': ')
    ..writeln(job.data.title)

    // Название компании
    ..write(localized.job_field_company_title)
    ..write(': ')
    ..writeln(job.data.company)

    // Страна
    ..write(localized.job_field_location_country)
    ..write(': ')
    ..writeln(job.data.getCountry().title);

  // Местоположение
  if (job.data.address.length > 5) {
    buffer
      ..write(localized.job_field_location_address)
      ..write(': ')
      ..writeln(job.data.address);
  }

  // Локация работы
  buffer
    ..write(localized.job_field_location)
    ..write(': ')
    ..writeln(locationRepresentation())

    // Возможное трудоустройство
    ..write(localized.job_type)
    ..write(': ')
    ..writeln(employmentRepresentation())

    // Уровень разработчика
    ..write(localized.developer_level)
    ..write(': ')
    ..writeln(levelRepresentation())

    // Ссылка
    ..writeln()
    ..writeln('https://dartjob.dev/#feed/job-${job.id}');
  return buffer.toString();
}
