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

class TVDetailBloc extends Bloc<TVDetailEvent, TVDetailState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVDetail getTVDetail;
  final GetTVRecommendations getTVRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  TVDetailBloc({
    required this.getTVDetail,
    required this.getTVRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TVDetailState.initial()) {
    on<FetchTVDetail>((event, emit) async {
      emit(state.copyWith(tvState: RequestState.loading));
      final detailResult = await getTVDetail.execute(event.id);
      final recommendationResult = await getTVRecommendations.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(state.copyWith(
              tvState: RequestState.error, message: failure.message));
        },
        (tv) {
          emit(state.copyWith(
            tvState: RequestState.loaded,
            tv: tv,
            recommendationState: RequestState.loading,
          ));
          recommendationResult.fold(
            (failure) {
              emit(state.copyWith(
                  recommendationState: RequestState.error,
                  message: failure.message));
            },
            (tvs) {
              emit(state.copyWith(
                  recommendationState: RequestState.loaded,
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
