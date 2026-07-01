import 'package:core/blocs/debounce_restartable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/search_tv.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv _searchTv;

  TvSearchBloc(this._searchTv)
    : super(TvSearchEmpty('Input the TV Series name')) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TvSearchLoading());
      final result = await _searchTv.execute(query);

      result.fold(
        (failure) {
          emit(TvSearchError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            final message = query.isNotEmpty
                ? 'TV Series not found'
                : 'Input the TV Series name';
            emit(TvSearchEmpty(message));
          } else {
            emit(TvSearchHasData(data));
          }
        },
      );
    }, transformer: debounceRestartable(const Duration(milliseconds: 500)));
  }
}
