import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

import '../../domain/entities/movie.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_movie_recommendations.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<FetchMovieDetail>((event, emit) async {
      emit(state.copyWith(movieState: RequestState.Loading));
      final detailResult = await getMovieDetail.execute(event.id);
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(state.copyWith(
              movieState: RequestState.Error, message: failure.message));
        },
        (movie) {
          emit(state.copyWith(
            movieState: RequestState.Loaded,
            movie: movie,
            recommendationState: RequestState.Loading,
          ));
          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                  recommendationState: RequestState.Error,
                  message: failure.message));
            },
            (movies) {
              emit(state.copyWith(
                  recommendationState: RequestState.Loaded,
                  movieRecommendations: movies));
            },
          );
        },
      );
    });

    on<AddWatchlist>((event, emit) async {
      final movie = event.movie;
      final watchlist = Watchlist(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        type: 'movie',
      );
      final result = await saveWatchlist.execute(watchlist);

      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(LoadWatchlistStatus(movie.id));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final movie = event.movie;
      final watchlist = Watchlist(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        type: 'movie',
      );
      final result = await removeWatchlist.execute(watchlist);

      result.fold(
        (failure) {
          emit(state.copyWith(watchlistMessage: failure.message));
        },
        (successMessage) {
          emit(state.copyWith(watchlistMessage: successMessage));
        },
      );

      add(LoadWatchlistStatus(movie.id));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id, 'movie');
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
