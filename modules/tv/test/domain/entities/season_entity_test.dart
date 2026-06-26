import 'package:flutter_test/flutter_test.dart';
import 'package:tv/domain/entities/season.dart';

void main() {
  group('Season Entity', () {
    final tSeasonAirDate = '2008-01-20';
    final tSeasonEpisodeCount = 7;
    final tSeasonId = 1;
    final tSeasonName = 'Season 1';
    final tSeasonOverview = 'The first season of the series';
    final tSeasonPosterPath = '/posterPath';
    final tSeasonNumber = 1;

    test('Season entity should have correct properties', () {
      final season = Season(
        airDate: tSeasonAirDate,
        episodeCount: tSeasonEpisodeCount,
        id: tSeasonId,
        name: tSeasonName,
        overview: tSeasonOverview,
        posterPath: tSeasonPosterPath,
        seasonNumber: tSeasonNumber,
      );

      expect(season.airDate, tSeasonAirDate);
      expect(season.episodeCount, tSeasonEpisodeCount);
      expect(season.id, tSeasonId);
      expect(season.name, tSeasonName);
      expect(season.overview, tSeasonOverview);
      expect(season.posterPath, tSeasonPosterPath);
      expect(season.seasonNumber, tSeasonNumber);
    });

    test('Season entity with null optional fields should work correctly', () {
      final season = Season(
        airDate: null,
        episodeCount: tSeasonEpisodeCount,
        id: tSeasonId,
        name: tSeasonName,
        overview: tSeasonOverview,
        posterPath: null,
        seasonNumber: tSeasonNumber,
      );

      expect(season.airDate, null);
      expect(season.posterPath, null);
      expect(season.episodeCount, tSeasonEpisodeCount);
    });

    test('Two Season entities with same properties should be equal', () {
      final season1 = Season(
        airDate: tSeasonAirDate,
        episodeCount: tSeasonEpisodeCount,
        id: tSeasonId,
        name: tSeasonName,
        overview: tSeasonOverview,
        posterPath: tSeasonPosterPath,
        seasonNumber: tSeasonNumber,
      );

      final season2 = Season(
        airDate: tSeasonAirDate,
        episodeCount: tSeasonEpisodeCount,
        id: tSeasonId,
        name: tSeasonName,
        overview: tSeasonOverview,
        posterPath: tSeasonPosterPath,
        seasonNumber: tSeasonNumber,
      );

      expect(season1, equals(season2));
    });

    test('Different seasons should not be equal', () {
      final season1 = Season(
        airDate: tSeasonAirDate,
        episodeCount: tSeasonEpisodeCount,
        id: tSeasonId,
        name: tSeasonName,
        overview: tSeasonOverview,
        posterPath: tSeasonPosterPath,
        seasonNumber: tSeasonNumber,
      );

      final season2 = Season(
        airDate: tSeasonAirDate,
        episodeCount: tSeasonEpisodeCount,
        id: 2,
        name: tSeasonName,
        overview: tSeasonOverview,
        posterPath: tSeasonPosterPath,
        seasonNumber: 2,
      );

      expect(season1, isNot(season2));
    });

    test('Season props should include all properties', () {
      final season = Season(
        airDate: tSeasonAirDate,
        episodeCount: tSeasonEpisodeCount,
        id: tSeasonId,
        name: tSeasonName,
        overview: tSeasonOverview,
        posterPath: tSeasonPosterPath,
        seasonNumber: tSeasonNumber,
      );

      expect(
        season.props,
        [
          tSeasonAirDate,
          tSeasonEpisodeCount,
          tSeasonId,
          tSeasonName,
          tSeasonOverview,
          tSeasonPosterPath,
          tSeasonNumber,
        ],
      );
    });
  });
}
