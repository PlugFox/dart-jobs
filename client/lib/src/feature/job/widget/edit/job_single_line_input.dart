import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class JobSingleLineInput extends StatelessWidget {
  const JobSingleLineInput({
    required final this.label,
    required final this.controller,
    final this.focusNode,
    final this.error,
    final this.maxLength = 64,
    final this.next = true,
    final this.denyCyrillic = true,
    final this.hint,
    Key? key,
  }) : super(key: key);

  final String label;
  final String? hint;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final ValueNotifier<String?>? error;
  final int maxLength;
  final bool denyCyrillic;
  final bool next;

  @override
  Widget build(BuildContext context) => _ErrorBuilder(
        error: error,
        builder: (errorText) => TextField(
          controller: controller,
          focusNode: focusNode,
          minLines: 1,
          maxLines: 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            counterText: '',
            errorText: errorText,
          ),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.singleLineFormatter,
            if (denyCyrillic) _denyCyrillic,
          ],
          keyboardType: TextInputType.text,
          textInputAction: next ? TextInputAction.next : TextInputAction.done,
          onEditingComplete: () => next ? FocusScope.of(context).nextFocus() : FocusScope.of(context).unfocus(),
        ),
      );
}

/// Не разрешать ввод кирилицы
final TextInputFormatter _denyCyrillic = FilteringTextInputFormatter.deny(RegExp('[а-яА-ЯёЁ]'));

@immutable
class _ErrorBuilder extends StatelessWidget {
  const _ErrorBuilder({
    required final this.error,
    required final this.builder,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<String?>? error;
  final Widget Function(String?) builder;

  @override
  Widget build(BuildContext context) => error == null
      ? builder(null)
      : ValueListenableBuilder<String?>(
          valueListenable: error!,
          builder: (_, errorText, __) => builder(errorText),
        );
}
