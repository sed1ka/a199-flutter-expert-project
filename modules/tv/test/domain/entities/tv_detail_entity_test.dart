import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TvDetail Entity', () {
    final tGenres = [Genre(id: 18, name: 'Drama')];
    final tSeasons = [
      Season(
        airDate: '2008-01-20',
        episodeCount: 7,
        id: 1,
        name: 'Season 1',
        overview: 'The first season',
        posterPath: '/posterPath',
        seasonNumber: 1,
      )
    ];

    final tTvDetailId = 1;
    final tTvDetailName = 'Breaking Bad';
    final tTvDetailOriginalName = 'Breaking Bad';
    final tTvDetailOverview = 'A drama series';
    final tTvDetailPosterPath = '/posterPath';
    final tTvDetailBackdropPath = '/backdropPath';
    final tTvDetailFirstAirDate = '2008-01-20';
    final tTvDetailVoteAverage = 9.5;
    final tTvDetailVoteCount = 25000;

    test('TvDetail entity should have correct properties', () {
      final tvDetail = TvDetail(
        backdropPath: tTvDetailBackdropPath,
        genres: tGenres,
        id: tTvDetailId,
        originalName: tTvDetailOriginalName,
        overview: tTvDetailOverview,
        posterPath: tTvDetailPosterPath,
        firstAirDate: tTvDetailFirstAirDate,
        name: tTvDetailName,
        voteAverage: tTvDetailVoteAverage,
        voteCount: tTvDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail.id, tTvDetailId);
      expect(tvDetail.name, tTvDetailName);
      expect(tvDetail.originalName, tTvDetailOriginalName);
      expect(tvDetail.overview, tTvDetailOverview);
      expect(tvDetail.posterPath, tTvDetailPosterPath);
      expect(tvDetail.backdropPath, tTvDetailBackdropPath);
      expect(tvDetail.firstAirDate, tTvDetailFirstAirDate);
      expect(tvDetail.voteAverage, tTvDetailVoteAverage);
      expect(tvDetail.voteCount, tTvDetailVoteCount);
      expect(tvDetail.genres, tGenres);
      expect(tvDetail.seasons, tSeasons);
    });

    test('TvDetail with null backdrop path should work correctly', () {
      final tvDetail = TvDetail(
        backdropPath: null,
        genres: tGenres,
        id: tTvDetailId,
        originalName: tTvDetailOriginalName,
        overview: tTvDetailOverview,
        posterPath: tTvDetailPosterPath,
        firstAirDate: tTvDetailFirstAirDate,
        name: tTvDetailName,
        voteAverage: tTvDetailVoteAverage,
        voteCount: tTvDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail.backdropPath, null);
    });

    test('Two TvDetail entities with same properties should be equal', () {
      final tvDetail1 = TvDetail(
        backdropPath: tTvDetailBackdropPath,
        genres: tGenres,
        id: tTvDetailId,
        originalName: tTvDetailOriginalName,
        overview: tTvDetailOverview,
        posterPath: tTvDetailPosterPath,
        firstAirDate: tTvDetailFirstAirDate,
        name: tTvDetailName,
        voteAverage: tTvDetailVoteAverage,
        voteCount: tTvDetailVoteCount,
        seasons: tSeasons,
      );

      final tvDetail2 = TvDetail(
        backdropPath: tTvDetailBackdropPath,
        genres: tGenres,
        id: tTvDetailId,
        originalName: tTvDetailOriginalName,
        overview: tTvDetailOverview,
        posterPath: tTvDetailPosterPath,
        firstAirDate: tTvDetailFirstAirDate,
        name: tTvDetailName,
        voteAverage: tTvDetailVoteAverage,
        voteCount: tTvDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail1, equals(tvDetail2));
    });

    test('Different TvDetail entities should not be equal', () {
      final tvDetail1 = TvDetail(
        backdropPath: tTvDetailBackdropPath,
        genres: tGenres,
        id: tTvDetailId,
        originalName: tTvDetailOriginalName,
        overview: tTvDetailOverview,
        posterPath: tTvDetailPosterPath,
        firstAirDate: tTvDetailFirstAirDate,
        name: tTvDetailName,
        voteAverage: tTvDetailVoteAverage,
        voteCount: tTvDetailVoteCount,
        seasons: tSeasons,
      );

      final tvDetail2 = TvDetail(
        backdropPath: tTvDetailBackdropPath,
        genres: tGenres,
        id: 2,
        originalName: tTvDetailOriginalName,
        overview: tTvDetailOverview,
        posterPath: tTvDetailPosterPath,
        firstAirDate: tTvDetailFirstAirDate,
        name: tTvDetailName,
        voteAverage: tTvDetailVoteAverage,
        voteCount: tTvDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail1, isNot(tvDetail2));
    });

    test('TvDetail with multiple genres should work correctly', () {
      final multipleGenres = [
        Genre(id: 18, name: 'Drama'),
        Genre(id: 9648, name: 'Mystery'),
      ];

      final tvDetail = TvDetail(
        backdropPath: tTvDetailBackdropPath,
        genres: multipleGenres,
        id: tTvDetailId,
        originalName: tTvDetailOriginalName,
        overview: tTvDetailOverview,
        posterPath: tTvDetailPosterPath,
        firstAirDate: tTvDetailFirstAirDate,
        name: tTvDetailName,
        voteAverage: tTvDetailVoteAverage,
        voteCount: tTvDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail.genres.length, 2);
    });

    test('TvDetail with multiple seasons should work correctly', () {
      final multipleSeasons = [
        Season(
          airDate: '2008-01-20',
          episodeCount: 7,
          id: 1,
          name: 'Season 1',
          overview: 'The first season',
          posterPath: '/posterPath1',
          seasonNumber: 1,
        ),
        Season(
          airDate: '2009-03-09',
          episodeCount: 13,
          id: 2,
          name: 'Season 2',
          overview: 'The second season',
          posterPath: '/posterPath2',
          seasonNumber: 2,
        )
      ];

      final tvDetail = TvDetail(
        backdropPath: tTvDetailBackdropPath,
        genres: tGenres,
        id: tTvDetailId,
        originalName: tTvDetailOriginalName,
        overview: tTvDetailOverview,
        posterPath: tTvDetailPosterPath,
        firstAirDate: tTvDetailFirstAirDate,
        name: tTvDetailName,
        voteAverage: tTvDetailVoteAverage,
        voteCount: tTvDetailVoteCount,
        seasons: multipleSeasons,
      );

      expect(tvDetail.seasons.length, 2);
    });
  });
}
