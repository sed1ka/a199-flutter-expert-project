import 'package:core/blocs/debounce_restartable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/search_tv.dart';

part 'tv_search_event.dart';

part 'tv_search_state.dart';

class TVSearchBloc extends Bloc<TVSearchEvent, TVSearchState> {
  final SearchTV _searchTV;

  TVSearchBloc(this._searchTV)
    : super(TVSearchEmpty('Input the TV Series name')) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(TVSearchLoading());
      final result = await _searchTV.execute(query);

      result.fold(
        (failure) {
          emit(TVSearchError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            final message = query.isNotEmpty
                ? 'TV Series not found'
                : 'Input the TV Series name';
            emit(TVSearchEmpty(message));
          } else {
            emit(TVSearchHasData(data));
          }
        },
      );
    }, transformer: debounceRestartable(const Duration(milliseconds: 500)));
  }
}
