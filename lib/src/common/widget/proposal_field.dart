import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../model/proposal.dart';
import 'proposal_form.dart';

typedef ProposalFormTextFieldValueChanged<T extends Proposal> = T? Function(String value, T data);

@immutable
abstract class ProposalFormTextField<T extends Proposal> extends StatelessWidget {
  final String Function(T data) text;
  final String? label;
  final bool finishEditing;
  final bool enabled;
  final ProposalFormTextFieldValueChanged<T>? onChanged;
  final ProposalFormTextFieldValueChanged<T>? onLostFocus;

  const ProposalFormTextField._(
    final this.text, {
    final this.onChanged,
    final this.onLostFocus,
    this.label,
    this.finishEditing = false,
    this.enabled = true,
    Key? key,
  }) : super(key: key);

  const factory ProposalFormTextField.singleLine(
    final String Function(T data) text, {
    String? label,
    ProposalFormTextFieldValueChanged<T>? onChanged,
    ProposalFormTextFieldValueChanged<T>? onLostFocus,
    int? maxLength,
    bool finishEditing,
    bool enabled,
    Key? key,
  }) = _FieldSingleLineText<T>;

  const factory ProposalFormTextField.multiLine(
    final String Function(T data) text, {
    String? label,
    ProposalFormTextFieldValueChanged<T>? onChanged,
    ProposalFormTextFieldValueChanged<T>? onLostFocus,
    int? maxLength,
    int? maxLines,
    bool finishEditing,
    bool enabled,
    Key? key,
  }) = _FieldMultiLineText<T>;

  @override
  StatelessElement createElement() => _TextFieldElement<T>(this);

  @override
  Widget build(covariant _TextFieldElement context);
}

class _TextFieldElement<T extends Proposal> extends StatelessElement {
  _TextFieldElement(StatelessWidget widget) : super(widget);
  @override
  ProposalFormTextField<T> get widget => super.widget as ProposalFormTextField<T>;
  bool _mounted = false;
  late final TextEditingController controller;
  final FocusNode focusNode = FocusNode();
  T? _data;
  T get data => _data!;
  late StreamSubscription<T> _subscription;
  // ignore: close_sinks
  late final Sink<T> _sink;
  Sink<T> get sink => _sink;

  void _firstBuild() {
    _mounted = true;
    _data = ProposalForm.getDataOf(this, listen: false);
    _sink = ProposalForm.sinkOf<T>(this);
    _subscription = ProposalForm.streamOf<T>(this).listen((data) {
      _data = data;
      controller.text = widget.text(data);
    });
    controller = TextEditingController(text: widget.text(data));
    controller.addListener(_onChanged);
    focusNode.addListener(_onLostFocus);
  }

  void _onChanged() {
    final result = widget.onChanged?.call(controller.text, data);
    if (result is T) {
      sink.add(result);
    }
  }

  void _onLostFocus() {
    if (focusNode.hasFocus) return;
    final result = widget.onLostFocus?.call(controller.text, data);
    if (result is T) {
      sink.add(result);
    }
  }

  @override
  void unmount() {
    super.unmount();
    _mounted = false;
    _subscription.cancel();
    controller.dispose();
    focusNode.dispose();
  }

  @override
  Widget build() {
    if (!_mounted) {
      _firstBuild();
    }
    return super.build();
  }
}

class _FieldSingleLineText<T extends Proposal> extends ProposalFormTextField<T> {
  final int? maxLength;
  const _FieldSingleLineText(
    final String Function(T data) text, {
    String? label,
    ProposalFormTextFieldValueChanged<T>? onChanged,
    ProposalFormTextFieldValueChanged<T>? onLostFocus,
    this.maxLength = 64,
    bool finishEditing = false,
    bool enabled = true,
    Key? key,
  }) : super._(
          text,
          label: label,
          onChanged: onChanged,
          onLostFocus: onLostFocus,
          finishEditing: finishEditing,
          enabled: enabled,
          key: key,
        );

  @override
  Widget build(_TextFieldElement context) {
    final status = ProposalForm.statusOf(context);
    final readOnly = !enabled || status == ProposalFormStatus.read;
    if (readOnly && context.controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return TextField(
      focusNode: context.focusNode,
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
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.singleLineFormatter,
        //LengthLimitingTextInputFormatter(maxLength),
      ],
      keyboardType: TextInputType.text,
      textInputAction: finishEditing ? TextInputAction.done : TextInputAction.next,
      onEditingComplete: () {
        if (finishEditing) {
          FocusScope.of(context).unfocus();
        } else {
          FocusScope.of(context).nextFocus();
        }
      },
    );
  }
}

class _FieldMultiLineText<T extends Proposal> extends ProposalFormTextField<T> {
  final int? maxLength;
  final int? maxLines;

  const _FieldMultiLineText(
    final String Function(T data) text, {
    String? label,
    ProposalFormTextFieldValueChanged<T>? onChanged,
    ProposalFormTextFieldValueChanged<T>? onLostFocus,
    this.maxLength = 1024,
    this.maxLines,
    bool finishEditing = false,
    bool enabled = true,
    Key? key,
  }) : super._(
          text,
          label: label,
          onChanged: onChanged,
          onLostFocus: onLostFocus,
          finishEditing: finishEditing,
          enabled: enabled,
          key: key,
        );

  @override
  Widget build(_TextFieldElement context) {
    final status = ProposalForm.statusOf(context);
    final readOnly = !enabled || status == ProposalFormStatus.read;
    if (readOnly && context.controller.text.isEmpty) {
      return const SizedBox.shrink();
    }
    return TextField(
      focusNode: context.focusNode,
      controller: context.controller,
      readOnly: readOnly,
      enabled: !readOnly,
      minLines: 4,
      maxLines: maxLines,
      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
      maxLength: maxLength,
      decoration: InputDecoration(
        labelText: label,
        border: readOnly ? InputBorder.none : null,
        counterText: readOnly ? '' : null,
      ),
      inputFormatters: const <TextInputFormatter>[
        //FilteringTextInputFormatter.singleLineFormatter,
        //LengthLimitingTextInputFormatter(maxLength),
      ],
      keyboardType: TextInputType.multiline,
      textInputAction: finishEditing ? TextInputAction.done : TextInputAction.newline,
      onEditingComplete: () {
        if (finishEditing) {
          FocusScope.of(context).unfocus();
        } else {
          FocusScope.of(context).nextFocus();
        }
      },
    );
  }
}
