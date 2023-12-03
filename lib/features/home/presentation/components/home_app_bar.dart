import 'package:flutter/material.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/features/home/domain/news_cubit.dart';
import 'package:news_app/uikit/app_bar.dart';
import 'package:news_app/uikit/app_icon_button.dart';
import 'package:news_app/features/view_settings/presentation/theme_toggle_button.dart';
import 'package:provider/provider.dart';

import 'filters_bottom_sheet.dart';
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
      actions: [
        AppIconButton(
          icon: const Icon(Icons.tune),
          onPressed: () => _showFilters(context),
        ),
        const ThemeToggleButton(),
      ],
    );
  }

  Future<void> _showFilters(BuildContext context) async {
    final cubit = context.read<NewsCubit>();
    final res = await FiltersBottomSheet.show(
      context,
      initialParams: cubit.state.searchParams,
      availableSources: cubit.state.sources,
    );
    if (res is NewsSearchParams) {
      cubit.fetchByParams(params: res);
    }
  }
}
