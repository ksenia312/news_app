import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:news_app/features/home/domain/news_cubit.dart';

import '../components/article_list_item.dart';

class HomeDataView extends StatelessWidget {
  const HomeDataView({
    super.key,
    required this.articles,
    required this.inProgress,
    required this.scrollController,
  });

  final ScrollController scrollController;
  final List<ArticleEntity> articles;
  final bool inProgress;

  @override
  Widget build(BuildContext context) {
    final searchParams = context.select<NewsCubit, NewsSearchParams>(
      (value) => value.searchParams,
    );

    return NotificationListener<ScrollUpdateNotification>(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              itemCount: articles.length,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ArticleListItem(
                    entity: articles[index],
                  ),
                );
              },
            ),
          ),
          if (inProgress)
            const SizedBox(
              height: 100,
              child: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
        ],
      ),
      onNotification: (n) {
        if (n.metrics.pixels >= n.metrics.maxScrollExtent) {
          context.read<NewsCubit>().fetchNext();
        }
        return true;
      },
    );
  }
}
