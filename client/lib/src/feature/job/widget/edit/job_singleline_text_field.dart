import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class JobSingleLineTextField extends StatelessWidget {
  const JobSingleLineTextField({
    required final this.label,
    required final this.controller,
    Key? key,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) => TextField(
        controller: controller,
        minLines: 1,
        maxLines: 1,
        maxLength: 64,
        decoration: InputDecoration(
          labelText: label,
          counterText: '',
        ),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.singleLineFormatter,
          _denyCyrillic,
        ],
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
      );
}

/// Не разрешать ввод кирилицы
final TextInputFormatter _denyCyrillic = FilteringTextInputFormatter.deny(RegExp('[а-яА-ЯёЁ]'));
