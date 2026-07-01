import 'package:core/blocs/debounce_restartable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/search_movies.dart';

part 'movie_search_event.dart';

part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovies;

  MovieSearchBloc(this._searchMovies)
    : super(MovieSearchEmpty('Input the Movie name')) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;

      emit(MovieSearchLoading());
      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(MovieSearchError(failure.message));
        },
        (data) {
          if (data.isEmpty) {
            final message = query.isNotEmpty
                ? 'Movie not found'
                : 'Input the Movie name';
            emit(MovieSearchEmpty(message));
          } else {
            emit(MovieSearchHasData(data));
          }
        },
      );
    }, transformer: debounceRestartable(const Duration(milliseconds: 500)));
  }
}
