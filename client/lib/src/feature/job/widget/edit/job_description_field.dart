import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class JobDescriptionButton extends StatelessWidget {
  const JobDescriptionButton({
    required final this.label,
    required final this.controller,
    final this.denyCyrillic = true,
    Key? key,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;
  final bool denyCyrillic;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: false).push<void>(
              _JobDescriptionPageRoute(label, controller),
            ),
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      );
}

class _JobDescriptionPageRoute<T> extends PageRoute<T> {
  _JobDescriptionPageRoute(
    this.label,
    this.textEditingController, {
    final this.denyCyrillic = true,
  });

  final String label;
  final TextEditingController textEditingController;
  final bool denyCyrillic;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get maintainState => false;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      FadeTransition(
        opacity: animation,
        child: child,
      );

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        body: SafeArea(
          child: Builder(builder: (context) {
            // 620 px - max width
            final horizontalPadding = math.max<double>(
              (MediaQuery.of(context).size.width - kBodyWidth) / 2,
              8,
            );
            return Padding(
              padding: EdgeInsets.only(
                top: 0,
                left: horizontalPadding,
                right: horizontalPadding,
                bottom: 0,
              ),
              child: TextField(
                controller: textEditingController,
                maxLength: 2600,
                maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                expands: true,
                minLines: null,
                maxLines: null,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: context.localization.job_field_description,
                  //labelText: label,
                  //filled: true,
                  //fillColor: Theme.of(context).highlightColor,
                  border: InputBorder.none,
                  counterText: '',
                ),
                inputFormatters: <TextInputFormatter>[
                  //FilteringTextInputFormatter.singleLineFormatter,
                  if (denyCyrillic) _denyCyrillic,
                ],
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                onEditingComplete: () => FocusScope.of(context).nextFocus(),
              ),
            );
          }),
        ),
      );
}

/// Не разрешать ввод кирилицы
final TextInputFormatter _denyCyrillic = FilteringTextInputFormatter.deny(RegExp('[а-яА-ЯёЁ]'));
