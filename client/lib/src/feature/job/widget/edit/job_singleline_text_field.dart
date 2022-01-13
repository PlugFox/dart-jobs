import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class JobSingleLineTextField extends StatelessWidget {
  const JobSingleLineTextField({
    required final this.label,
    required final this.controller,
    final this.focusNode,
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
  final int maxLength;
  final bool denyCyrillic;
  final bool next;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 60,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          minLines: 1,
          maxLines: 1,
          maxLength: maxLength,
          decoration: InputDecoration(
            labelText: label,
            hintText: hint,
            counterText: '',
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
