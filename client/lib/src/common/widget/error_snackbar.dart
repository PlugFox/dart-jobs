import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:flutter/material.dart';

/// Снекбар ошибки
class ErrorSnackBar extends SnackBar {
  /// Отобразить снекбар с ошибкой
  static void show(
    final BuildContext context, {
    final String? error,
  }) =>
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        ErrorSnackBar(
          error: error,
        ),
      );

  ErrorSnackBar({
    final String? error,
    Key? key,
  }) : super(
          key: key,
          //action: length > 1
          //    ? SnackBarAction(
          //        label: '${context.localization.next} ($length)',
          //        textColor: Colors.white,
          //        onPressed: () {
          //          controller?.close();
          //          _showSnackBarError(errors.sublist(1));
          //        },
          //      )
          //    : null,
          backgroundColor: Colors.redAccent,
          content: SizedBox(
            height: 48,
            child: Center(
              child: Text(
                error ?? 'An error has occurred',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          duration: const Duration(milliseconds: 6000),
          margin: EdgeInsets.symmetric(
            horizontal: math.max<double>(
              (ui.window.physicalSize.width / ui.window.devicePixelRatio - kBodyWidth) / 2,
              12,
            ),
            vertical: 16,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        );
}
