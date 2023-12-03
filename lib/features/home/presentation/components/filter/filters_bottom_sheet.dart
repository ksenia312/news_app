part of 'filters_button.dart';

class _FiltersBottomSheet extends StatelessWidget {
  const _FiltersBottomSheet({
    required this.initialParams,
    required this.availableSources,
  });

  final NewsSearchParams initialParams;
  final List<SourceEntity> availableSources;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                AppElevatedTextButton(
                  onPressed:
                      model.hasChanges ? () => _submit(context, model) : null,
                  value: 'Submit',
                ),
                const SizedBox(height: 4),
                AppElevatedTextButton(
                  inverse: true,
                  onPressed: context.navigator.pop,
                  value: 'Cancel',
                ),
                spacer,
              ],
            );
          },
        ),
      ),
    );
  }

  void _submit(BuildContext context, SearchParamsEditingModel model) {
    final error = model.validate();
    if (error == null) {
      context.navigator.pop(model.params);
    } else {
      AppToast.showError(context, message: error);
    }
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
