import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TODO: на больших экранах отображать текст филд в том же пространстве
@immutable
class BugReportDescriptionInput extends StatefulWidget {
  const BugReportDescriptionInput({
    required final this.title,
    required final this.label,
    required final this.controller,
    required final this.hint,
    final this.denyCyrillic = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool denyCyrillic;

  @override
  State<BugReportDescriptionInput> createState() => _BugReportDescriptionInputState();
}

class _BugReportDescriptionInputState extends State<BugReportDescriptionInput> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context, rootNavigator: false)
            .push<void>(
              _DescriptionPageRoute(
                widget.title,
                widget.controller,
                denyCyrillic: widget.denyCyrillic,
              ),
            )
            .then<void>(
              (_) => setState(() => _focus = false),
            );
        FocusScope.of(context).unfocus();
        setState(() => _focus = true);
      },
      child: ValueListenableBuilder<TextEditingValue>(
        valueListenable: widget.controller,
        builder: (context, value, child) => SizedBox(
          height: 120,
          child: InputDecorator(
            isFocused: _focus,
            expands: true,
            isHovering: true,
            decoration: InputDecoration(
              labelText: widget.label,
              hintText: widget.hint,
              border: const OutlineInputBorder(),
            ),
            isEmpty: value.text.isEmpty,
            child: Text(
              value.text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: themeData.textTheme.subtitle1,
            ),
          ),
        ),
      ),
    );
  }
}

class _DescriptionPageRoute extends PageRoute<void> {
  _DescriptionPageRoute(
    this.title,
    this.textEditingController, {
    final this.denyCyrillic = true,
  }) : super(
          settings: const RouteSettings(
            name: 'bug_report_description_input',
            arguments: null,
          ),
        );

  final String title;
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
  // ignore: long-method
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) =>
      _EditScreen(
        title: title,
        textEditingController: textEditingController,
        denyCyrillic: denyCyrillic,
      );
}

@immutable
class _EditScreen extends StatefulWidget {
  const _EditScreen({
    required final this.title,
    required final this.textEditingController,
    required final this.denyCyrillic,
    Key? key,
  }) : super(key: key);

  final String title;
  final TextEditingController textEditingController;
  final bool denyCyrillic;

  @override
  State<_EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<_EditScreen> {
  String _initialText = '';

  @override
  void initState() {
    super.initState();
    _initialText = widget.textEditingController.text;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            widget.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        floatingActionButton: ValueListenableBuilder<TextEditingValue>(
          valueListenable: widget.textEditingController,
          builder: (context, value, _) => value.text == _initialText
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Icon(Icons.save),
                ),
        ),
        body: SafeArea(
          child: Builder(
            builder: (context) {
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
                  controller: widget.textEditingController,
                  maxLength: 2600,
                  maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                  expands: true,
                  minLines: null,
                  maxLines: null,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: context.localization.bug_report_leave_a_description,
                    //labelText: label,
                    //filled: true,
                    //fillColor: Theme.of(context).highlightColor,
                    border: InputBorder.none,
                    counterText: '',
                  ),
                  inputFormatters: <TextInputFormatter>[
                    //FilteringTextInputFormatter.singleLineFormatter,
                    if (widget.denyCyrillic) _denyCyrillic,
                  ],
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                  onEditingComplete: () => FocusScope.of(context).nextFocus(),
                ),
              );
            },
          ),
        ),
      );
}

/// Не разрешать ввод кирилицы
final TextInputFormatter _denyCyrillic = FilteringTextInputFormatter.deny(RegExp('[а-яА-ЯёЁ]'));
