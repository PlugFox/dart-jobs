import 'dart:math' as math;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:dart_jobs_client/src/common/localization/localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TODO: на больших экранах отображать текст филд в том же пространстве
@immutable
class JobDescriptionInput extends StatefulWidget {
  const JobDescriptionInput({
    required final this.title,
    required final this.label,
    required final this.controller,
    final this.denyCyrillic = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final String label;
  final TextEditingController controller;
  final bool denyCyrillic;

  @override
  State<JobDescriptionInput> createState() => _JobDescriptionInputState();
}

class _JobDescriptionInputState extends State<JobDescriptionInput> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return SizedBox(
      height: 60,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: false)
              .push<void>(
                _JobDescriptionPageRoute(
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
          builder: (context, value, child) => InputDecorator(
            isFocused: _focus,
            expands: true,
            isHovering: true,
            decoration: InputDecoration(
              labelText: widget.label,
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

class _JobDescriptionPageRoute extends PageRoute<void> {
  _JobDescriptionPageRoute(
    this.title,
    this.textEditingController, {
    final this.denyCyrillic = true,
  });

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
          actions: <Widget>[
            Tooltip(
              message: context.localization.save,
              child: ValueListenableBuilder<TextEditingValue>(
                valueListenable: widget.textEditingController,
                builder: (context, value, _) => IconButton(
                  onPressed: value.text == _initialText ? null : () => Navigator.pop(context),
                  icon: const Icon(Icons.save),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
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
                    hintText: context.localization.job_field_description,
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
