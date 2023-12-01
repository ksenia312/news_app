import 'package:flutter/material.dart';
import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/app/models/async_state.dart';
import 'package:news_app/app/models/source_entity.dart';
import 'package:news_app/common/bloc_state_builder.dart';
import 'package:news_app/features/home/domain/news_cubit.dart';
import 'package:news_app/features/uikit/app_error.dart';
import 'package:news_app/features/uikit/app_progress.dart';

import 'components/floating_up_button.dart';
import 'components/home_app_bar.dart';
import 'view/home_data_view.dart';
import 'wrapper/home_wrapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.sources});

  final List<SourceEntity> sources;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return HomeWrapper(
      sources: widget.sources,
      child: Scaffold(
        appBar: const HomeAppBar(),
        floatingActionButton: FloatingUpButton(
          scrollController: scrollController,
        ),
        body: _HomeScreenBody(scrollController),
      ),
    );
  }
}

class _HomeScreenBody
    extends BlocIterableStateBuilder<NewsCubit, NewsState, ArticleEntity> {
  const _HomeScreenBody(this.scrollController);

  final ScrollController scrollController;

  @override
  AsyncState<Iterable<ArticleEntity>>? asyncStateInjector(NewsState state) {
    return state.articles;
  }

  @override
  Widget dataBuilder(Iterable<ArticleEntity> data) {
    return _buildData(data);
  }

  @override
  Widget errorBuilder(
    Iterable<ArticleEntity>? lastData,
    String error,
  ) {
    if (lastData == null || lastData.isEmpty) {
      return AppError.centered(value: error);
    }
    return _buildData(lastData);
  }

  @override
  Widget progressBuilder([
    Iterable<ArticleEntity>? lastData,
  ]) {
    if (lastData == null || lastData.isEmpty) {
      return AppProgress.centered(caption: 'Fetching articles..');
    }
    return _buildData(lastData, inProgress: true);
  }

  Widget _buildData(
    Iterable<ArticleEntity> data, {
    bool inProgress = false,
  }) {
    return HomeDataView(
      articles: [...data],
      inProgress: inProgress,
      scrollController: scrollController,
    );
  }
}
