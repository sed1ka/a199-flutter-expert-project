part of 'tv_detail_bloc.dart';

class TvDetailState extends Equatable {
  final TvDetail? tv;
  final RequestState tvState;
  final List<Tv> tvRecommendations;
  final RequestState recommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TvDetailState({
    required this.tv,
    required this.tvState,
    required this.tvRecommendations,
    required this.recommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  factory TvDetailState.initial() {
    return const TvDetailState(
      tv: null,
      tvState: RequestState.Empty,
      tvRecommendations: [],
      recommendationState: RequestState.Empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  TvDetailState copyWith({
    TvDetail? tv,
    RequestState? tvState,
    List<Tv>? tvRecommendations,
    RequestState? recommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TvDetailState(
      tv: tv ?? this.tv,
      tvState: tvState ?? this.tvState,
      tvRecommendations: tvRecommendations ?? this.tvRecommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object?> get props => [
        tv,
        tvState,
        tvRecommendations,
        recommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
