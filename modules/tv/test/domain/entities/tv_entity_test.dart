import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/tv.dart';

void main() {
  group('TV Entity', () {
    final tTVId = 1;
    final tTVName = 'Breaking Bad';
    final tTVPosterPath = '/posterPath';
    final tTVBackdropPath = '/backdropPath';
    final tTVGenreIds = [1, 2, 3];
    final tTVOriginalName = 'Breaking Bad';
    final tTVOverview = 'A drama series';
    final tTVPopularity = 75.5;
    final tTVFirstAirDate = '2008-01-20';
    final tTVVoteAverage = 9.5;
    final tTVVoteCount = 25000;

    test('TV entity should have correct properties', () {
      final tv = TV(
        backdropPath: tTVBackdropPath,
        genreIds: tTVGenreIds,
        id: tTVId,
        originalName: tTVOriginalName,
        overview: tTVOverview,
        popularity: tTVPopularity,
        posterPath: tTVPosterPath,
        firstAirDate: tTVFirstAirDate,
        name: tTVName,
        voteAverage: tTVVoteAverage,
        voteCount: tTVVoteCount,
      );

      expect(tv.id, tTVId);
      expect(tv.name, tTVName);
      expect(tv.posterPath, tTVPosterPath);
      expect(tv.backdropPath, tTVBackdropPath);
      expect(tv.genreIds, tTVGenreIds);
      expect(tv.originalName, tTVOriginalName);
      expect(tv.overview, tTVOverview);
      expect(tv.popularity, tTVPopularity);
      expect(tv.firstAirDate, tTVFirstAirDate);
      expect(tv.voteAverage, tTVVoteAverage);
      expect(tv.voteCount, tTVVoteCount);
    });

    test('TV.watchlist constructor should create tv with null optional fields', () {
      final tv = TV.watchlist(
        id: tTVId,
        name: tTVName,
        posterPath: tTVPosterPath,
        overview: tTVOverview,
      );

      expect(tv.id, tTVId);
      expect(tv.name, tTVName);
      expect(tv.posterPath, tTVPosterPath);
      expect(tv.overview, tTVOverview);
      expect(tv.backdropPath, null);
      expect(tv.genreIds, null);
      expect(tv.originalName, null);
      expect(tv.popularity, null);
      expect(tv.firstAirDate, null);
      expect(tv.voteAverage, null);
      expect(tv.voteCount, null);
    });

    test('Two TV entities with same properties should be equal', () {
      final tv1 = TV(
        backdropPath: tTVBackdropPath,
        genreIds: tTVGenreIds,
        id: tTVId,
        originalName: tTVOriginalName,
        overview: tTVOverview,
        popularity: tTVPopularity,
        posterPath: tTVPosterPath,
        firstAirDate: tTVFirstAirDate,
        name: tTVName,
        voteAverage: tTVVoteAverage,
        voteCount: tTVVoteCount,
      );

      final tv2 = TV(
        backdropPath: tTVBackdropPath,
        genreIds: tTVGenreIds,
        id: tTVId,
        originalName: tTVOriginalName,
        overview: tTVOverview,
        popularity: tTVPopularity,
        posterPath: tTVPosterPath,
        firstAirDate: tTVFirstAirDate,
        name: tTVName,
        voteAverage: tTVVoteAverage,
        voteCount: tTVVoteCount,
      );

      expect(tv1, equals(tv2));
    });

    test('TV.watchlist entities with same properties should be equal', () {
      final tv1 = TV.watchlist(
        id: tTVId,
        name: tTVName,
        posterPath: tTVPosterPath,
        overview: tTVOverview,
      );

      final tv2 = TV.watchlist(
        id: tTVId,
        name: tTVName,
        posterPath: tTVPosterPath,
        overview: tTVOverview,
      );

      expect(tv1, equals(tv2));
    });

    test('TV entity with null optional fields should work correctly', () {
      final tv = TV(
        backdropPath: null,
        genreIds: null,
        id: tTVId,
        originalName: null,
        overview: tTVOverview,
        popularity: null,
        posterPath: tTVPosterPath,
        firstAirDate: null,
        name: tTVName,
        voteAverage: null,
        voteCount: null,
      );

      expect(tv.id, tTVId);
      expect(tv.name, tTVName);
      expect(tv.backdropPath, null);
    });

    test('TV entity should support stringify', () {
      final tv = TV(
        backdropPath: tTVBackdropPath,
        genreIds: tTVGenreIds,
        id: tTVId,
        originalName: tTVOriginalName,
        overview: tTVOverview,
        popularity: tTVPopularity,
        posterPath: tTVPosterPath,
        firstAirDate: tTVFirstAirDate,
        name: tTVName,
        voteAverage: tTVVoteAverage,
        voteCount: tTVVoteCount,
      );

      expect(tv.stringify, true);
    });

    test('Different tvs should not be equal', () {
      final tv1 = TV(
        backdropPath: tTVBackdropPath,
        genreIds: tTVGenreIds,
        id: tTVId,
        originalName: tTVOriginalName,
        overview: tTVOverview,
        popularity: tTVPopularity,
        posterPath: tTVPosterPath,
        firstAirDate: tTVFirstAirDate,
        name: tTVName,
        voteAverage: tTVVoteAverage,
        voteCount: tTVVoteCount,
      );

      final tv2 = TV(
        backdropPath: tTVBackdropPath,
        genreIds: tTVGenreIds,
        id: 2,
        originalName: tTVOriginalName,
        overview: tTVOverview,
        popularity: tTVPopularity,
        posterPath: tTVPosterPath,
        firstAirDate: tTVFirstAirDate,
        name: tTVName,
        voteAverage: tTVVoteAverage,
        voteCount: tTVVoteCount,
      );

      expect(tv1, isNot(tv2));
    });
  });
}
