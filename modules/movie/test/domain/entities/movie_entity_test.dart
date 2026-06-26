import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/movie.dart';

void main() {
  group('Movie Entity', () {
    final tMovieId = 1;
    final tMovieTitle = 'Spider-Man';
    final tMoviePosterPath = '/posterPath';
    final tMovieBackdropPath = '/backdropPath';
    final tMovieGenreIds = [1, 2, 3];
    final tMovieOriginalTitle = 'Spider-Man';
    final tMovieOverview = 'A superhero movie';
    final tMoviePopularity = 75.5;
    final tMovieReleaseDate = '2002-05-01';
    final tMovieVoteAverage = 7.2;
    final tMovieVoteCount = 13507;

    test('Movie entity should have correct properties', () {
      final movie = Movie(
        adult: false,
        backdropPath: tMovieBackdropPath,
        genreIds: tMovieGenreIds,
        id: tMovieId,
        originalTitle: tMovieOriginalTitle,
        overview: tMovieOverview,
        popularity: tMoviePopularity,
        posterPath: tMoviePosterPath,
        releaseDate: tMovieReleaseDate,
        title: tMovieTitle,
        video: false,
        voteAverage: tMovieVoteAverage,
        voteCount: tMovieVoteCount,
      );

      expect(movie.id, tMovieId);
      expect(movie.title, tMovieTitle);
      expect(movie.posterPath, tMoviePosterPath);
      expect(movie.backdropPath, tMovieBackdropPath);
      expect(movie.genreIds, tMovieGenreIds);
      expect(movie.originalTitle, tMovieOriginalTitle);
      expect(movie.overview, tMovieOverview);
      expect(movie.popularity, tMoviePopularity);
      expect(movie.releaseDate, tMovieReleaseDate);
      expect(movie.voteAverage, tMovieVoteAverage);
      expect(movie.voteCount, tMovieVoteCount);
      expect(movie.adult, false);
      expect(movie.video, false);
    });

    test('Movie.watchlist constructor should create movie with null optional fields', () {
      final movie = Movie.watchlist(
        id: tMovieId,
        title: tMovieTitle,
        posterPath: tMoviePosterPath,
        overview: tMovieOverview,
      );

      expect(movie.id, tMovieId);
      expect(movie.title, tMovieTitle);
      expect(movie.posterPath, tMoviePosterPath);
      expect(movie.overview, tMovieOverview);
      expect(movie.adult, null);
      expect(movie.backdropPath, null);
      expect(movie.genreIds, null);
      expect(movie.originalTitle, null);
      expect(movie.popularity, null);
      expect(movie.releaseDate, null);
      expect(movie.video, null);
      expect(movie.voteAverage, null);
      expect(movie.voteCount, null);
    });

    test('Two Movie entities with same properties should be equal', () {
      final movie1 = Movie(
        adult: false,
        backdropPath: tMovieBackdropPath,
        genreIds: tMovieGenreIds,
        id: tMovieId,
        originalTitle: tMovieOriginalTitle,
        overview: tMovieOverview,
        popularity: tMoviePopularity,
        posterPath: tMoviePosterPath,
        releaseDate: tMovieReleaseDate,
        title: tMovieTitle,
        video: false,
        voteAverage: tMovieVoteAverage,
        voteCount: tMovieVoteCount,
      );

      final movie2 = Movie(
        adult: false,
        backdropPath: tMovieBackdropPath,
        genreIds: tMovieGenreIds,
        id: tMovieId,
        originalTitle: tMovieOriginalTitle,
        overview: tMovieOverview,
        popularity: tMoviePopularity,
        posterPath: tMoviePosterPath,
        releaseDate: tMovieReleaseDate,
        title: tMovieTitle,
        video: false,
        voteAverage: tMovieVoteAverage,
        voteCount: tMovieVoteCount,
      );

      expect(movie1, equals(movie2));
    });

    test('Movie.watchlist entities with same properties should be equal', () {
      final movie1 = Movie.watchlist(
        id: tMovieId,
        title: tMovieTitle,
        posterPath: tMoviePosterPath,
        overview: tMovieOverview,
      );

      final movie2 = Movie.watchlist(
        id: tMovieId,
        title: tMovieTitle,
        posterPath: tMoviePosterPath,
        overview: tMovieOverview,
      );

      expect(movie1, equals(movie2));
    });

    test('Movie entity with null optional fields should work correctly', () {
      final movie = Movie(
        adult: null,
        backdropPath: null,
        genreIds: null,
        id: tMovieId,
        originalTitle: null,
        overview: tMovieOverview,
        popularity: null,
        posterPath: tMoviePosterPath,
        releaseDate: null,
        title: tMovieTitle,
        video: null,
        voteAverage: null,
        voteCount: null,
      );

      expect(movie.id, tMovieId);
      expect(movie.title, tMovieTitle);
      expect(movie.adult, null);
      expect(movie.backdropPath, null);
    });

    test('Movie entity should support stringify', () {
      final movie = Movie(
        adult: false,
        backdropPath: tMovieBackdropPath,
        genreIds: tMovieGenreIds,
        id: tMovieId,
        originalTitle: tMovieOriginalTitle,
        overview: tMovieOverview,
        popularity: tMoviePopularity,
        posterPath: tMoviePosterPath,
        releaseDate: tMovieReleaseDate,
        title: tMovieTitle,
        video: false,
        voteAverage: tMovieVoteAverage,
        voteCount: tMovieVoteCount,
      );

      expect(movie.stringify, true);
    });

    test('Different movies should not be equal', () {
      final movie1 = Movie(
        adult: false,
        backdropPath: tMovieBackdropPath,
        genreIds: tMovieGenreIds,
        id: tMovieId,
        originalTitle: tMovieOriginalTitle,
        overview: tMovieOverview,
        popularity: tMoviePopularity,
        posterPath: tMoviePosterPath,
        releaseDate: tMovieReleaseDate,
        title: tMovieTitle,
        video: false,
        voteAverage: tMovieVoteAverage,
        voteCount: tMovieVoteCount,
      );

      final movie2 = Movie(
        adult: false,
        backdropPath: tMovieBackdropPath,
        genreIds: tMovieGenreIds,
        id: 2,
        originalTitle: tMovieOriginalTitle,
        overview: tMovieOverview,
        popularity: tMoviePopularity,
        posterPath: tMoviePosterPath,
        releaseDate: tMovieReleaseDate,
        title: tMovieTitle,
        video: false,
        voteAverage: tMovieVoteAverage,
        voteCount: tMovieVoteCount,
      );

      expect(movie1, isNot(movie2));
    });
  });
}
