import 'package:flutter/material.dart';
import 'package:news_app/common/context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title});

  static const height = kToolbarHeight + 10;

  final Widget? title;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      titleTextStyle: context.appBarTheme.titleTextStyle?.copyWith(
        color: context.colorScheme.background,
      ),
    );
  }
}
