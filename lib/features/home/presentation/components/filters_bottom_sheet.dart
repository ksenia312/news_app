import 'package:flutter/material.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/app/models/source_entity.dart';
import 'package:news_app/common/context_extension.dart';
import 'package:news_app/common/string_extension.dart';
import 'package:news_app/features/home/domain/search_params_editing_model.dart';
import 'package:provider/provider.dart';

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({
    super.key,
    required this.initialParams,
    required this.availableSources,
  });

  final NewsSearchParams initialParams;
  final List<SourceEntity> availableSources;

  static Future<NewsSearchParams?> show(
    BuildContext context, {
    required NewsSearchParams initialParams,
    required List<SourceEntity> availableSources,
  }) {
    return showModalBottomSheet<NewsSearchParams?>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - 50,
      ),
      builder: (context) {
        return _BottomSheetWrapper(
          child: FiltersBottomSheet(
            initialParams: initialParams,
            availableSources: availableSources,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16),
      child: ChangeNotifierProvider(
        create: (context) => SearchParamsEditingModel(
          initialParams,
          availableSources: availableSources,
        ),
        child: Consumer<SearchParamsEditingModel>(
          builder: (context, model, _) {
            const spacer = SizedBox(height: 16);
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: context.colorScheme.error,
                    ),
                    onPressed: model.reset,
                    child: const Text('Reset'),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitle(context, 'Sort by'),
                        spacer,
                        _buildSortItems(model),
                        spacer,
                        _buildTitle(context, 'Search in'),
                        spacer,
                        _buildScopesItems(model),
                        spacer,
                        _buildTitle(context, 'Include searches from'),
                        spacer,
                        _buildSourcesItems(model),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: context.navigator.pop,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: context.colorScheme.primary,
                          backgroundColor: context.colorScheme.surface,
                        ),
                        child: const Text('Cancel'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          context.navigator.pop(model.params);
                        },
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Text(
      title,
      style: context.textTheme.titleLarge,
    );
  }

  Widget _buildSortItems(SearchParamsEditingModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        SortBy.values.length,
        (index) {
          final sortBy = SortBy.values[index];
          return RadioListTile(
            groupValue: model.params.sortBy,
            title: Text(sortBy.title),
            value: sortBy,
            onChanged: (value) {
              if (value != null) {
                model.setSort(value);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildScopesItems(SearchParamsEditingModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        SearchInScope.values.length,
        (index) {
          final scope = SearchInScope.values[index];
          return CheckboxListTile(
            title: Text(scope.name.capitalizeFirst),
            value: model.hasScope(scope),
            onChanged: (value) {
              if (value != null) {
                model.toggleScope(scope);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildSourcesItems(SearchParamsEditingModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        availableSources.length,
        (index) {
          final source = availableSources[index];
          return CheckboxListTile(
            title: Text(source.name),
            value: model.hasSource(source),
            onChanged: (value) {
              if (value != null) {
                model.toggleSource(source);
              }
            },
          );
        },
      ),
    );
  }
}

class _BottomSheetWrapper extends StatelessWidget {
  const _BottomSheetWrapper({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: context.navigator.pop,
      builder: (context) {
        return child;
      },
    );
  }
}
