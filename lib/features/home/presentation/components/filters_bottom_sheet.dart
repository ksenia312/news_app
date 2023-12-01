import 'package:flutter/material.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/app/models/source_entity.dart';
import 'package:news_app/common/context_extension.dart';
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8.0, 16, 8, 25),
            child: FiltersBottomSheet(
              initialParams: initialParams,
              availableSources: availableSources,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchParamsEditingModel(initialParams),
      child: Consumer<SearchParamsEditingModel>(
        builder: (context, model, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'News Sources',
                  style: context.textTheme.titleLarge,
                ),
              ),
              Expanded(child: _buildSourcesItems(model)),
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
    );
  }

  Widget _buildSourcesItems(SearchParamsEditingModel model) {
    return ListView(
      shrinkWrap: true,
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
