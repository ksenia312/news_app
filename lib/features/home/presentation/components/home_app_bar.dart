import 'package:flutter/material.dart';
import 'package:news_app/features/view_settings/presentation/theme_toggle_button.dart';
import 'package:news_app/uikit/app_bar.dart';

import 'filter/filters_button.dart';
import 'search_input.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(CustomAppBar.height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      toolbarHeight: CustomAppBar.height,
      title: const HomeSearchInput(),
      actions: const [
        FiltersButton(),
        ThemeToggleButton(),
      ],
    );
  }
}
