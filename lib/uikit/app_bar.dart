import 'package:flutter/material.dart';
import 'package:news_app/common/extensions/context_extension.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.title});

  static const height = kToolbarHeight + 10;

  final String? title;

  @override
  Size get preferredSize => const Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!) : null,
      toolbarHeight: height,
      titleTextStyle: context.textTheme.titleLarge,
    );
  }
}
