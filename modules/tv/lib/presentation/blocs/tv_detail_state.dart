part of 'tv_detail_bloc.dart';

class TVDetailState extends Equatable {
  final TVDetail? tv;
  final RequestState tvState;
  final List<TV> tvRecommendations;
  final RequestState recommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const TVDetailState({
    required this.tv,
    required this.tvState,
    required this.tvRecommendations,
    required this.recommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  factory TVDetailState.initial() {
    return const TVDetailState(
      tv: null,
      tvState: RequestState.empty,
      tvRecommendations: [],
      recommendationState: RequestState.empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  TVDetailState copyWith({
    TVDetail? tv,
    RequestState? tvState,
    List<TV>? tvRecommendations,
    RequestState? recommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return TVDetailState(
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
