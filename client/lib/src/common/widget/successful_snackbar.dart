import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:dart_jobs_client/src/common/constant/layout_constraints.dart';
import 'package:flutter/material.dart';

/// Снекбар успеха
class SuccessfulSnackBar extends SnackBar {
  /// Отобразить снекбар с ошибкой
  static void show(
    final BuildContext context, {
    final String? message,
  }) =>
      ScaffoldMessenger.maybeOf(context)?.showSnackBar(
        SuccessfulSnackBar(
          message: message,
        ),
      );

  SuccessfulSnackBar({
    final String? message,
    Key? key,
  }) : super(
          key: key,
          backgroundColor: Colors.green,
          content: SizedBox(
            height: 48,
            child: Center(
              child: Text(
                message ?? 'Successful',
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
