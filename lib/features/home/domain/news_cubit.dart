import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/app/models/async_state.dart';
import 'package:news_app/app/models/article_entity.dart';
import 'package:news_app/app/models/news_search_params.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/app/models/source_entity.dart';

import 'interface/news_repository.dart';

part 'news_cubit.freezed.dart';

class NewsCubit extends Cubit<NewsState> {
  NewsCubit(this.repository) : super(const NewsState());

  final NewsRepository repository;

  NewsSearchParams get searchParams => state.searchParams;

  Future<void> init({required List<SourceEntity> sources}) async {
    _setUpSources(sources: sources);
    return _fetch();
  }

  Future<void> fetchNext() {
    return _fetch(page: state.currentPage + 1);
  }

  Future<void> fetchByKey({required String value}) async {
    if (value != searchParams.key) {
      emit(
        state.copyWith(
          searchParams: searchParams.copyWith(key: value),
          articles: AsyncState.nothing(),
        ),
      );
      return _fetch();
    }
    return;
  }

  Future<void> fetchByParams({required NewsSearchParams params}) async {
    if (params != searchParams) {
      emit(
        state.copyWith(
          searchParams: params,
          articles: AsyncState.nothing(),
        ),
      );
      return _fetch();
    }
    return;
  }

  void _setUpSources({
    required List<SourceEntity> sources,
  }) {
    emit(
      state.copyWith(
        sources: sources,
        searchParams: searchParams.copyWith(
          sources: NewsSearchParams.defaultSourceFrom(sources),
        ),
      ),
    );
    if (!(state.articles?.hasData ?? false)) {
      _fetch();
    }
  }

  Future<void> _fetch({
    int? page,
    int? pageCount,
    NewsSearchParams? searchParams,
  }) async {
    if (state.articles?.inProgress ?? false) return;
    if (state.isCompleted) return;
    emit(
      state.copyWith(
        articles: AsyncState.progress(
          lastData: state.articles?.data,
        ),
      ),
    );
    searchParams ??= state.searchParams;
    page ??= state.currentPage;
    pageCount ??= state.pageCount;

    try {
      final data = await repository.fetch(
        count: pageCount,
        page: page,
        searchParams: searchParams,
      );
      emit(
        state.copyWith(
          articles: AsyncState.data([...?state.articles?.data, ...data]),
          searchParams: searchParams,
          currentPage: page,
          pageCount: pageCount,
        ),
      );
    } on NewsCompletedException catch (_) {
      emit(
        state.copyWith(
          isCompleted: true,
          articles: AsyncState.data(
            state.articles?.data ?? [],
          ),
        ),
      );
    } on NewsFetchException catch (e) {
      emit(
        state.copyWith(
          articles: AsyncState.error(
            error: e.message,
            lastData: state.articles?.data,
          ),
        ),
      );
    } on Object catch (_) {
      emit(
        state.copyWith(
          articles: AsyncState.error(
            error: 'Something went wrong',
            lastData: state.articles?.data,
          ),
        ),
      );
    }
  }
}

@freezed
class NewsState with _$NewsState {
  const factory NewsState({
    AsyncState<List<ArticleEntity>>? articles,
    @Default(1) int currentPage,
    @Default(50) int pageCount,
    @Default(false) bool isCompleted,
    @Default([]) List<SourceEntity> sources,
    @Default(NewsSearchParams()) NewsSearchParams searchParams,
  }) = _NewsState;
}
