import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'job_form.dart';

@immutable
abstract class JobTextField extends StatelessWidget {
  final String text;
  final String? label;
  final bool finishEditing;
  final bool enabled;

  const JobTextField._(
    final this.text, {
    this.label,
    this.finishEditing = false,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  const factory JobTextField.singleLine(
    final String text, {
    String? label,
    ValueChanged<String>? onChanged,
    int? maxLength,
    bool finishEditing,
    bool enabled,
    Key? key,
  }) = _JobFieldSingleLineText;

  const factory JobTextField.multiLine(
    final String text, {
    String? label,
    ValueChanged<String>? onChanged,
    int? maxLength,
    bool finishEditing,
    bool enabled,
    Key? key,
  }) = _JobFieldMultiLineText;

  @override
  StatelessElement createElement() => _JobTextFieldElement(this);

  @override
  Widget build(covariant _JobTextFieldElement context);
}

class _JobTextFieldElement extends StatelessElement {
  _JobTextFieldElement(StatelessWidget widget) : super(widget);
  @override
  JobTextField get widget => super.widget as JobTextField;
  bool _mounted = false;
  late final TextEditingController controller;

  void _firstBuild() {
    _mounted = true;
    controller = TextEditingController(text: widget.text);
  }

  @override
  void update(covariant JobTextField newWidget) {
    if (newWidget.text != widget.text) {
      controller.text = newWidget.text;
    }
    super.update(newWidget);
  }

  @override
  void unmount() {
    super.unmount();
    _mounted = false;
    controller.dispose();
  }

  @override
  Widget build() {
    if (!_mounted) {
      _firstBuild();
    }
    return super.build();
  }
}

class _JobFieldSingleLineText extends JobTextField {
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  const _JobFieldSingleLineText(
    final String text, {
    String? label,
    this.onChanged,
    this.maxLength = 64,
    bool finishEditing = false,
    bool enabled = true,
    Key? key,
  }) : super._(
          text,
          label: label,
          finishEditing: finishEditing,
          enabled: enabled,
          key: key,
        );

  @override
  Widget build(_JobTextFieldElement context) {
    final status = JobForm.statusOf(context);
    final readOnly = !enabled || onChanged == null || status == JobFormStatus.read;
    if (readOnly && context.controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return TextField(
      controller: context.controller,
      readOnly: readOnly,
      enabled: !readOnly,
      maxLines: 1,
      minLines: 1,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        border: readOnly ? InputBorder.none : null,
        counterText: '',
      ),
      onChanged: onChanged,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
        //LengthLimitingTextInputFormatter(maxLength),
      ],
      keyboardType: TextInputType.text,
      textInputAction: finishEditing ? TextInputAction.done : TextInputAction.next,
      onEditingComplete: () => finishEditing ? FocusScope.of(context).unfocus() : FocusScope.of(context).nextFocus(),
    );
  }
}

class _JobFieldMultiLineText extends JobTextField {
  final int? maxLength;
  final ValueChanged<String>? onChanged;

  const _JobFieldMultiLineText(
    final String text, {
    String? label,
    this.onChanged,
    this.maxLength = 1024,
    bool finishEditing = false,
    bool enabled = true,
    Key? key,
  }) : super._(
          text,
          label: label,
          finishEditing: finishEditing,
          enabled: enabled,
          key: key,
        );

  @override
  Widget build(_JobTextFieldElement context) {
    final status = JobForm.statusOf(context);
    final readOnly = !enabled || onChanged == null || status == JobFormStatus.read;
    if (readOnly && context.controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return TextField(
      controller: context.controller,
      readOnly: readOnly,
      enabled: !readOnly,
      minLines: 4,
      maxLines: 4,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        border: readOnly ? InputBorder.none : null,
        counterText: readOnly ? '' : null,
      ),
      onChanged: onChanged,
      inputFormatters: const <TextInputFormatter>[
        //FilteringTextInputFormatter.singleLineFormatter,
        //LengthLimitingTextInputFormatter(maxLength),
      ],
      keyboardType: TextInputType.multiline,
      textInputAction: finishEditing ? TextInputAction.done : TextInputAction.newline,
      onEditingComplete: () => finishEditing ? FocusScope.of(context).unfocus() : FocusScope.of(context).nextFocus(),
    );
  }
}
