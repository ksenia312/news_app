import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/common/extensions/context_extension.dart';

class AppToast {
  AppToast._();

  static void showSuccess(
    BuildContext context, {
    required String message,
  }) {
    return show(
      context,
      message: message,
      color: context.colorScheme.primary,
      foregroundColor: context.colorScheme.onPrimary,
      leading: const Icon(Icons.done_outline),
    );
  }

  static void showError(
    BuildContext context, {
    required String message,
  }) {
    return show(
      context,
      message: message,
      color: context.colorScheme.error,
      foregroundColor: context.colorScheme.onError,
      leading: const Icon(Icons.warning),
    );
  }

  static void show(
    BuildContext context, {
    required String message,
    required Color color,
    required Color foregroundColor,
    required Widget leading,
  }) {
    final toast = FToast()
      ..init(context)
      ..removeCustomToast();

    toast.showToast(
      isDismissable: false,
      toastDuration: const Duration(seconds: 3),
      gravity: ToastGravity.TOP,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                foregroundColor,
                BlendMode.srcATop,
              ),
              child: leading,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                message,
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.colorScheme.onPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
