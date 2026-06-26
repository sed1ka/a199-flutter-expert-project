import 'package:flutter_test/flutter_test.dart';
import 'package:movie/domain/entities/genre.dart';
import 'package:movie/domain/entities/movie_detail.dart';

void main() {
  group('MovieDetail Entity', () {
    final tGenres = [Genre(id: 28, name: 'Action')];
    final tMovieDetailId = 1;
    final tMovieDetailTitle = 'Spider-Man';
    final tMovieDetailOriginalTitle = 'Spider-Man';
    final tMovieDetailOverview = 'A superhero movie';
    final tMovieDetailPosterPath = '/posterPath';
    final tMovieDetailBackdropPath = '/backdropPath';
    final tMovieDetailReleaseDate = '2002-05-01';
    final tMovieDetailRuntime = 121;
    final tMovieDetailVoteAverage = 7.2;
    final tMovieDetailVoteCount = 13507;
    final tMovieDetailAdult = false;

    test('MovieDetail entity should have correct properties', () {
      final movieDetail = MovieDetail(
        adult: tMovieDetailAdult,
        backdropPath: tMovieDetailBackdropPath,
        genres: tGenres,
        id: tMovieDetailId,
        originalTitle: tMovieDetailOriginalTitle,
        overview: tMovieDetailOverview,
        posterPath: tMovieDetailPosterPath,
        releaseDate: tMovieDetailReleaseDate,
        runtime: tMovieDetailRuntime,
        title: tMovieDetailTitle,
        voteAverage: tMovieDetailVoteAverage,
        voteCount: tMovieDetailVoteCount,
      );

      expect(movieDetail.id, tMovieDetailId);
      expect(movieDetail.title, tMovieDetailTitle);
      expect(movieDetail.originalTitle, tMovieDetailOriginalTitle);
      expect(movieDetail.overview, tMovieDetailOverview);
      expect(movieDetail.posterPath, tMovieDetailPosterPath);
      expect(movieDetail.backdropPath, tMovieDetailBackdropPath);
      expect(movieDetail.releaseDate, tMovieDetailReleaseDate);
      expect(movieDetail.runtime, tMovieDetailRuntime);
      expect(movieDetail.voteAverage, tMovieDetailVoteAverage);
      expect(movieDetail.voteCount, tMovieDetailVoteCount);
      expect(movieDetail.adult, tMovieDetailAdult);
      expect(movieDetail.genres, tGenres);
    });

    test('MovieDetail with null backdrop path should work correctly', () {
      final movieDetail = MovieDetail(
        adult: tMovieDetailAdult,
        backdropPath: null,
        genres: tGenres,
        id: tMovieDetailId,
        originalTitle: tMovieDetailOriginalTitle,
        overview: tMovieDetailOverview,
        posterPath: tMovieDetailPosterPath,
        releaseDate: tMovieDetailReleaseDate,
        runtime: tMovieDetailRuntime,
        title: tMovieDetailTitle,
        voteAverage: tMovieDetailVoteAverage,
        voteCount: tMovieDetailVoteCount,
      );

      expect(movieDetail.backdropPath, null);
    });

    test('Two MovieDetail entities with same properties should be equal', () {
      final movieDetail1 = MovieDetail(
        adult: tMovieDetailAdult,
        backdropPath: tMovieDetailBackdropPath,
        genres: tGenres,
        id: tMovieDetailId,
        originalTitle: tMovieDetailOriginalTitle,
        overview: tMovieDetailOverview,
        posterPath: tMovieDetailPosterPath,
        releaseDate: tMovieDetailReleaseDate,
        runtime: tMovieDetailRuntime,
        title: tMovieDetailTitle,
        voteAverage: tMovieDetailVoteAverage,
        voteCount: tMovieDetailVoteCount,
      );

      final movieDetail2 = MovieDetail(
        adult: tMovieDetailAdult,
        backdropPath: tMovieDetailBackdropPath,
        genres: tGenres,
        id: tMovieDetailId,
        originalTitle: tMovieDetailOriginalTitle,
        overview: tMovieDetailOverview,
        posterPath: tMovieDetailPosterPath,
        releaseDate: tMovieDetailReleaseDate,
        runtime: tMovieDetailRuntime,
        title: tMovieDetailTitle,
        voteAverage: tMovieDetailVoteAverage,
        voteCount: tMovieDetailVoteCount,
      );

      expect(movieDetail1, equals(movieDetail2));
    });

    test('Different MovieDetail entities should not be equal', () {
      final movieDetail1 = MovieDetail(
        adult: tMovieDetailAdult,
        backdropPath: tMovieDetailBackdropPath,
        genres: tGenres,
        id: tMovieDetailId,
        originalTitle: tMovieDetailOriginalTitle,
        overview: tMovieDetailOverview,
        posterPath: tMovieDetailPosterPath,
        releaseDate: tMovieDetailReleaseDate,
        runtime: tMovieDetailRuntime,
        title: tMovieDetailTitle,
        voteAverage: tMovieDetailVoteAverage,
        voteCount: tMovieDetailVoteCount,
      );

      final movieDetail2 = MovieDetail(
        adult: tMovieDetailAdult,
        backdropPath: tMovieDetailBackdropPath,
        genres: tGenres,
        id: 2,
        originalTitle: tMovieDetailOriginalTitle,
        overview: tMovieDetailOverview,
        posterPath: tMovieDetailPosterPath,
        releaseDate: tMovieDetailReleaseDate,
        runtime: tMovieDetailRuntime,
        title: tMovieDetailTitle,
        voteAverage: tMovieDetailVoteAverage,
        voteCount: tMovieDetailVoteCount,
      );

      expect(movieDetail1, isNot(movieDetail2));
    });

    test('MovieDetail with multiple genres should work correctly', () {
      final multipleGenres = [
        Genre(id: 28, name: 'Action'),
        Genre(id: 12, name: 'Adventure'),
        Genre(id: 18, name: 'Drama'),
      ];

      final movieDetail = MovieDetail(
        adult: tMovieDetailAdult,
        backdropPath: tMovieDetailBackdropPath,
        genres: multipleGenres,
        id: tMovieDetailId,
        originalTitle: tMovieDetailOriginalTitle,
        overview: tMovieDetailOverview,
        posterPath: tMovieDetailPosterPath,
        releaseDate: tMovieDetailReleaseDate,
        runtime: tMovieDetailRuntime,
        title: tMovieDetailTitle,
        voteAverage: tMovieDetailVoteAverage,
        voteCount: tMovieDetailVoteCount,
      );

      expect(movieDetail.genres.length, 3);
    });
  });
}
