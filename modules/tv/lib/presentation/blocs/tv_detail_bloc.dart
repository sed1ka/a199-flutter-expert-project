import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/usecases/get_tv_detail.dart';
import '../../domain/usecases/get_tv_recommendations.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TvDetailBloc({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvDetailState.initial()) {
    on<FetchTvDetail>((event, emit) async {
      emit(state.copyWith(tvState: RequestState.Loading));
      final detailResult = await getTvDetail.execute(event.id);
      final recommendationResult = await getTvRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(state.copyWith(
              tvState: RequestState.Error, message: failure.message));
        },
        (tv) {
          emit(state.copyWith(
            tvState: RequestState.Loaded,
            tv: tv,
            recommendationState: RequestState.Loading,
          ));
          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                  recommendationState: RequestState.Error,
                  message: failure.message));
            },
            (tvs) {
              emit(state.copyWith(
                  recommendationState: RequestState.Loaded,
                  tvRecommendations: tvs));
            },
          );
        },
      );
    });

    on<AddWatchlist>((event, emit) async {
      final tv = event.tv;
      final watchlist = Watchlist(
        id: tv.id,
        title: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
        type: 'tv',
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

      add(LoadWatchlistStatus(tv.id));
    });

    on<RemoveFromWatchlist>((event, emit) async {
      final tv = event.tv;
      final watchlist = Watchlist(
        id: tv.id,
        title: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
        type: 'tv',
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

      add(LoadWatchlistStatus(tv.id));
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id, 'tv');
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }
}
