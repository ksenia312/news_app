import 'package:flutter/material.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/app/models/source_entity.dart';
import 'package:news_app/common/extensions/context_extension.dart';
import 'package:news_app/common/extensions/string_extension.dart';
import 'package:news_app/features/home/domain/news_cubit.dart';
import 'package:news_app/features/home/domain/search_params_editing_model.dart';
import 'package:news_app/uikit/app_bottom_sheet.dart';
import 'package:news_app/uikit/app_icon_button.dart';
import 'package:news_app/uikit/app_icons.dart';
import 'package:news_app/uikit/app_toast.dart';
import 'package:provider/provider.dart';

part 'filters_bottom_sheet.dart';

class FiltersButton extends StatelessWidget {
  const FiltersButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomSheetControllerBuilder(
      builder: (context, controller) {
        return AppIconButton(
          icon: Icon(AppIcons.settings),
          onPressed: () => _showFilters(context, controller),
        );
      },
    );
  }

  Future<void> _showFilters(
    BuildContext context,
    AnimationController controller,
  ) async {
    final cubit = context.read<NewsCubit>();
    final res = await AppBottomSheet.show<NewsSearchParams>(
      context,
      controller: controller,
      builder: (context) {
        return _FiltersBottomSheet(
          initialParams: cubit.state.searchParams,
          availableSources: cubit.state.sources,
        );
      },
    );
    if (res is NewsSearchParams) {
      cubit.fetchByParams(params: res);
    }
  }
}
