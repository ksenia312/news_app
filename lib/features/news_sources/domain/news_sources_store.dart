import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:news_app/app/models/async_state.dart';
import 'package:news_app/app/models/source_entity.dart';
import 'package:news_app/features/news_sources/domain/interface/sources_repository.dart';

part 'news_sources_store.freezed.dart';

class NewsSourcesStore extends Cubit<NewsSourcesState> {
  NewsSourcesStore(this.repository) : super(const NewsSourcesState());

  final SourcesRepository repository;

  Future<void> init() async {
    emit(state.copyWith(sources: AsyncState.progress()));
    try {
      final res = await repository.fetch();
      emit(
        state.copyWith(sources: AsyncState.data(res)),
      );
    } on SourcesFetchException catch (e) {
      emit(
        state.copyWith(
          sources: AsyncState.error(error: e.message),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(sources: AsyncState.error()),
      );
    }
  }
}

@freezed
class NewsSourcesState with _$NewsSourcesState {
  const factory NewsSourcesState({
    AsyncState<List<SourceEntity>>? sources,
  }) = _NewsSourcesState;
}
