part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  final MovieDetail? movie;
  final RequestState movieState;
  final List<Movie> movieRecommendations;
  final RequestState recommendationState;
  final String message;
  final String watchlistMessage;
  final bool isAddedToWatchlist;

  const MovieDetailState({
    required this.movie,
    required this.movieState,
    required this.movieRecommendations,
    required this.recommendationState,
    required this.message,
    required this.watchlistMessage,
    required this.isAddedToWatchlist,
  });

  factory MovieDetailState.initial() {
    return const MovieDetailState(
      movie: null,
      movieState: RequestState.empty,
      movieRecommendations: [],
      recommendationState: RequestState.empty,
      message: '',
      watchlistMessage: '',
      isAddedToWatchlist: false,
    );
  }

  MovieDetailState copyWith({
    MovieDetail? movie,
    RequestState? movieState,
    List<Movie>? movieRecommendations,
    RequestState? recommendationState,
    String? message,
    String? watchlistMessage,
    bool? isAddedToWatchlist,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      movieState: movieState ?? this.movieState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      recommendationState: recommendationState ?? this.recommendationState,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object?> get props => [
        movie,
        movieState,
        movieRecommendations,
        recommendationState,
        message,
        watchlistMessage,
        isAddedToWatchlist,
      ];
}
