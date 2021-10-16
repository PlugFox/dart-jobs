import 'package:flutter/material.dart';

/// Снекбар ошибки
class ErrorSnackBar extends SnackBar {
  /// Отобразить снекбар с ошибкой
  static void show(
    BuildContext context, {
    String? message,
  }) =>
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        ErrorSnackBar(
          message: message,
        ),
      );

  ErrorSnackBar({String? message})
      : super(
          content: Text(
            message ?? 'An error has occurred',
          ),
        );
}
