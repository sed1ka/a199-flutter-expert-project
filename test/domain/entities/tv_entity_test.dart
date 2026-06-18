import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tv Entity', () {
    final tTvId = 1;
    final tTvName = 'Breaking Bad';
    final tTvPosterPath = '/posterPath';
    final tTvBackdropPath = '/backdropPath';
    final tTvGenreIds = [1, 2, 3];
    final tTvOriginalName = 'Breaking Bad';
    final tTvOverview = 'A drama series';
    final tTvPopularity = 75.5;
    final tTvFirstAirDate = '2008-01-20';
    final tTvVoteAverage = 9.5;
    final tTvVoteCount = 25000;

    test('Tv entity should have correct properties', () {
      final tv = Tv(
        backdropPath: tTvBackdropPath,
        genreIds: tTvGenreIds,
        id: tTvId,
        originalName: tTvOriginalName,
        overview: tTvOverview,
        popularity: tTvPopularity,
        posterPath: tTvPosterPath,
        firstAirDate: tTvFirstAirDate,
        name: tTvName,
        voteAverage: tTvVoteAverage,
        voteCount: tTvVoteCount,
      );

      expect(tv.id, tTvId);
      expect(tv.name, tTvName);
      expect(tv.posterPath, tTvPosterPath);
      expect(tv.backdropPath, tTvBackdropPath);
      expect(tv.genreIds, tTvGenreIds);
      expect(tv.originalName, tTvOriginalName);
      expect(tv.overview, tTvOverview);
      expect(tv.popularity, tTvPopularity);
      expect(tv.firstAirDate, tTvFirstAirDate);
      expect(tv.voteAverage, tTvVoteAverage);
      expect(tv.voteCount, tTvVoteCount);
    });

    test('Tv.watchlist constructor should create tv with null optional fields', () {
      final tv = Tv.watchlist(
        id: tTvId,
        name: tTvName,
        posterPath: tTvPosterPath,
        overview: tTvOverview,
      );

      expect(tv.id, tTvId);
      expect(tv.name, tTvName);
      expect(tv.posterPath, tTvPosterPath);
      expect(tv.overview, tTvOverview);
      expect(tv.backdropPath, null);
      expect(tv.genreIds, null);
      expect(tv.originalName, null);
      expect(tv.popularity, null);
      expect(tv.firstAirDate, null);
      expect(tv.voteAverage, null);
      expect(tv.voteCount, null);
    });

    test('Two Tv entities with same properties should be equal', () {
      final tv1 = Tv(
        backdropPath: tTvBackdropPath,
        genreIds: tTvGenreIds,
        id: tTvId,
        originalName: tTvOriginalName,
        overview: tTvOverview,
        popularity: tTvPopularity,
        posterPath: tTvPosterPath,
        firstAirDate: tTvFirstAirDate,
        name: tTvName,
        voteAverage: tTvVoteAverage,
        voteCount: tTvVoteCount,
      );

      final tv2 = Tv(
        backdropPath: tTvBackdropPath,
        genreIds: tTvGenreIds,
        id: tTvId,
        originalName: tTvOriginalName,
        overview: tTvOverview,
        popularity: tTvPopularity,
        posterPath: tTvPosterPath,
        firstAirDate: tTvFirstAirDate,
        name: tTvName,
        voteAverage: tTvVoteAverage,
        voteCount: tTvVoteCount,
      );

      expect(tv1, equals(tv2));
    });

    test('Tv.watchlist entities with same properties should be equal', () {
      final tv1 = Tv.watchlist(
        id: tTvId,
        name: tTvName,
        posterPath: tTvPosterPath,
        overview: tTvOverview,
      );

      final tv2 = Tv.watchlist(
        id: tTvId,
        name: tTvName,
        posterPath: tTvPosterPath,
        overview: tTvOverview,
      );

      expect(tv1, equals(tv2));
    });

    test('Tv entity with null optional fields should work correctly', () {
      final tv = Tv(
        backdropPath: null,
        genreIds: null,
        id: tTvId,
        originalName: null,
        overview: tTvOverview,
        popularity: null,
        posterPath: tTvPosterPath,
        firstAirDate: null,
        name: tTvName,
        voteAverage: null,
        voteCount: null,
      );

      expect(tv.id, tTvId);
      expect(tv.name, tTvName);
      expect(tv.backdropPath, null);
    });

    test('Tv entity should support stringify', () {
      final tv = Tv(
        backdropPath: tTvBackdropPath,
        genreIds: tTvGenreIds,
        id: tTvId,
        originalName: tTvOriginalName,
        overview: tTvOverview,
        popularity: tTvPopularity,
        posterPath: tTvPosterPath,
        firstAirDate: tTvFirstAirDate,
        name: tTvName,
        voteAverage: tTvVoteAverage,
        voteCount: tTvVoteCount,
      );

      expect(tv.stringify, true);
    });

    test('Different tvs should not be equal', () {
      final tv1 = Tv(
        backdropPath: tTvBackdropPath,
        genreIds: tTvGenreIds,
        id: tTvId,
        originalName: tTvOriginalName,
        overview: tTvOverview,
        popularity: tTvPopularity,
        posterPath: tTvPosterPath,
        firstAirDate: tTvFirstAirDate,
        name: tTvName,
        voteAverage: tTvVoteAverage,
        voteCount: tTvVoteCount,
      );

      final tv2 = Tv(
        backdropPath: tTvBackdropPath,
        genreIds: tTvGenreIds,
        id: 2,
        originalName: tTvOriginalName,
        overview: tTvOverview,
        popularity: tTvPopularity,
        posterPath: tTvPosterPath,
        firstAirDate: tTvFirstAirDate,
        name: tTvName,
        voteAverage: tTvVoteAverage,
        voteCount: tTvVoteCount,
      );

      expect(tv1, isNot(tv2));
    });
  });
}
