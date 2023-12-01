import 'package:flutter/material.dart';
import 'package:news_app/app/models/async_state.dart';
import 'package:news_app/app/models/source_entity.dart';
import 'package:news_app/common/bloc_state_builder.dart';
import 'package:news_app/features/home/presentation/home_screen.dart';
import 'package:news_app/features/news_sources/domain/news_sources_store.dart';

class SourcesStateBuilder extends BlocIterableStateBuilder<NewsSourcesStore,
    NewsSourcesState, SourceEntity> {
  const SourcesStateBuilder({super.key});

  @override
  AsyncState<Iterable<SourceEntity>>? asyncStateInjector(
    NewsSourcesState state,
  ) {
    return state.sources;
  }

  @override
  Widget dataBuilder(
    Iterable<SourceEntity> data,
  ) {
    return HomeScreen(sources: [...data]);
  }

  @override
  Widget errorBuilder(
    Iterable<SourceEntity>? lastData,
    String error,
  ) {
    if (lastData == null || lastData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading ...'),
        ),
        body: const Center(
          child: Text('error'),
        ),
      );
    }
    return dataBuilder(lastData);
  }

  @override
  Widget progressBuilder([
    Iterable<SourceEntity>? lastData,
  ]) {
    if (lastData == null || lastData.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Loading ...'),
        ),
        body: const Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return dataBuilder(lastData);
  }
}
