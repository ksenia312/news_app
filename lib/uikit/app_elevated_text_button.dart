import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';

class AppElevatedTextButton extends StatelessWidget {
  const AppElevatedTextButton({
    super.key,
    required this.value,
    required this.onPressed,
    this.inverse = false,
  });

  final String value;
  final VoidCallback? onPressed;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoButton(
        onPressed: onPressed,
        color: inverse ? null : context.colorScheme.secondary,
        child: Text(value),
      );
    }

    return ElevatedButton(
      onPressed: onPressed,
      style: inverse
          ? ElevatedButton.styleFrom(
              foregroundColor: context.colorScheme.primary,
              backgroundColor: context.colorScheme.surface,
            )
          : ElevatedButton.styleFrom(
              foregroundColor: context.colorScheme.surface,
              backgroundColor: context.colorScheme.primary,
            ),
      child: Text(value),
    );
  }
}
