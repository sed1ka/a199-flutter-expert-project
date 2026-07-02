import 'package:tv/domain/entities/genre.dart';
import 'package:tv/domain/entities/season.dart';
import 'package:tv/domain/entities/tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TVDetail Entity', () {
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

    final tTVDetailId = 1;
    final tTVDetailName = 'Breaking Bad';
    final tTVDetailOriginalName = 'Breaking Bad';
    final tTVDetailOverview = 'A drama series';
    final tTVDetailPosterPath = '/posterPath';
    final tTVDetailBackdropPath = '/backdropPath';
    final tTVDetailFirstAirDate = '2008-01-20';
    final tTVDetailVoteAverage = 9.5;
    final tTVDetailVoteCount = 25000;

    test('TVDetail entity should have correct properties', () {
      final tvDetail = TVDetail(
        backdropPath: tTVDetailBackdropPath,
        genres: tGenres,
        id: tTVDetailId,
        originalName: tTVDetailOriginalName,
        overview: tTVDetailOverview,
        posterPath: tTVDetailPosterPath,
        firstAirDate: tTVDetailFirstAirDate,
        name: tTVDetailName,
        voteAverage: tTVDetailVoteAverage,
        voteCount: tTVDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail.id, tTVDetailId);
      expect(tvDetail.name, tTVDetailName);
      expect(tvDetail.originalName, tTVDetailOriginalName);
      expect(tvDetail.overview, tTVDetailOverview);
      expect(tvDetail.posterPath, tTVDetailPosterPath);
      expect(tvDetail.backdropPath, tTVDetailBackdropPath);
      expect(tvDetail.firstAirDate, tTVDetailFirstAirDate);
      expect(tvDetail.voteAverage, tTVDetailVoteAverage);
      expect(tvDetail.voteCount, tTVDetailVoteCount);
      expect(tvDetail.genres, tGenres);
      expect(tvDetail.seasons, tSeasons);
    });

    test('TVDetail with null backdrop path should work correctly', () {
      final tvDetail = TVDetail(
        backdropPath: null,
        genres: tGenres,
        id: tTVDetailId,
        originalName: tTVDetailOriginalName,
        overview: tTVDetailOverview,
        posterPath: tTVDetailPosterPath,
        firstAirDate: tTVDetailFirstAirDate,
        name: tTVDetailName,
        voteAverage: tTVDetailVoteAverage,
        voteCount: tTVDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail.backdropPath, null);
    });

    test('Two TVDetail entities with same properties should be equal', () {
      final tvDetail1 = TVDetail(
        backdropPath: tTVDetailBackdropPath,
        genres: tGenres,
        id: tTVDetailId,
        originalName: tTVDetailOriginalName,
        overview: tTVDetailOverview,
        posterPath: tTVDetailPosterPath,
        firstAirDate: tTVDetailFirstAirDate,
        name: tTVDetailName,
        voteAverage: tTVDetailVoteAverage,
        voteCount: tTVDetailVoteCount,
        seasons: tSeasons,
      );

      final tvDetail2 = TVDetail(
        backdropPath: tTVDetailBackdropPath,
        genres: tGenres,
        id: tTVDetailId,
        originalName: tTVDetailOriginalName,
        overview: tTVDetailOverview,
        posterPath: tTVDetailPosterPath,
        firstAirDate: tTVDetailFirstAirDate,
        name: tTVDetailName,
        voteAverage: tTVDetailVoteAverage,
        voteCount: tTVDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail1, equals(tvDetail2));
    });

    test('Different TVDetail entities should not be equal', () {
      final tvDetail1 = TVDetail(
        backdropPath: tTVDetailBackdropPath,
        genres: tGenres,
        id: tTVDetailId,
        originalName: tTVDetailOriginalName,
        overview: tTVDetailOverview,
        posterPath: tTVDetailPosterPath,
        firstAirDate: tTVDetailFirstAirDate,
        name: tTVDetailName,
        voteAverage: tTVDetailVoteAverage,
        voteCount: tTVDetailVoteCount,
        seasons: tSeasons,
      );

      final tvDetail2 = TVDetail(
        backdropPath: tTVDetailBackdropPath,
        genres: tGenres,
        id: 2,
        originalName: tTVDetailOriginalName,
        overview: tTVDetailOverview,
        posterPath: tTVDetailPosterPath,
        firstAirDate: tTVDetailFirstAirDate,
        name: tTVDetailName,
        voteAverage: tTVDetailVoteAverage,
        voteCount: tTVDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail1, isNot(tvDetail2));
    });

    test('TVDetail with multiple genres should work correctly', () {
      final multipleGenres = [
        Genre(id: 18, name: 'Drama'),
        Genre(id: 9648, name: 'Mystery'),
      ];

      final tvDetail = TVDetail(
        backdropPath: tTVDetailBackdropPath,
        genres: multipleGenres,
        id: tTVDetailId,
        originalName: tTVDetailOriginalName,
        overview: tTVDetailOverview,
        posterPath: tTVDetailPosterPath,
        firstAirDate: tTVDetailFirstAirDate,
        name: tTVDetailName,
        voteAverage: tTVDetailVoteAverage,
        voteCount: tTVDetailVoteCount,
        seasons: tSeasons,
      );

      expect(tvDetail.genres.length, 2);
    });

    test('TVDetail with multiple seasons should work correctly', () {
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

      final tvDetail = TVDetail(
        backdropPath: tTVDetailBackdropPath,
        genres: tGenres,
        id: tTVDetailId,
        originalName: tTVDetailOriginalName,
        overview: tTVDetailOverview,
        posterPath: tTVDetailPosterPath,
        firstAirDate: tTVDetailFirstAirDate,
        name: tTVDetailName,
        voteAverage: tTVDetailVoteAverage,
        voteCount: tTVDetailVoteCount,
        seasons: multipleSeasons,
      );

      expect(tvDetail.seasons.length, 2);
    });
  });
}
