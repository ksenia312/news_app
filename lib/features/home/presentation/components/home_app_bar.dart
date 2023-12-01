import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/common/context_extension.dart';
import 'package:news_app/features/home/domain/news_cubit.dart';
import 'package:news_app/features/news_sources/domain/news_sources_store.dart';
import 'package:news_app/features/uikit/app_bar.dart';
import 'package:news_app/features/uikit/app_icon_button.dart';
import 'package:provider/provider.dart';

import 'filters_bottom_sheet.dart';
import 'search_input.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(CustomAppBar.height);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsCubit, NewsState>(
      builder: (context, state) {
        print('state ${state.searchParams.sources.map((e) => e.name)}');
        return AppBar(
          title: const HomeSearchInput(),
          actions: [
            AppIconButton(
              icon: const Icon(Icons.tune),
              onPressed: () async {
                final cubit = context.read<NewsCubit>();
                final res = await FiltersBottomSheet.show(
                  context,
                  initialParams: state.searchParams,
                  availableSources: state.sources,
                );
                if (res is NewsSearchParams) {
                  cubit.fetchByParams(params: res);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
