import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Watchlist Entity', () {
    final tWatchlistId = 1;
    final tWatchlistTitle = 'Spider-Man';
    final tWatchlistPosterPath = '/posterPath';
    final tWatchlistOverview = 'A superhero movie';
    final tWatchlistType = 'movie';

    test('Watchlist entity should have correct properties', () {
      final watchlist = Watchlist(
        id: tWatchlistId,
        title: tWatchlistTitle,
        posterPath: tWatchlistPosterPath,
        overview: tWatchlistOverview,
        type: tWatchlistType,
      );

      expect(watchlist.id, tWatchlistId);
      expect(watchlist.title, tWatchlistTitle);
      expect(watchlist.posterPath, tWatchlistPosterPath);
      expect(watchlist.overview, tWatchlistOverview);
      expect(watchlist.type, tWatchlistType);
    });

    test('Watchlist with null optional fields should work correctly', () {
      final watchlist = Watchlist(
        id: tWatchlistId,
        title: null,
        posterPath: null,
        overview: null,
        type: null,
      );

      expect(watchlist.id, tWatchlistId);
      expect(watchlist.title, null);
      expect(watchlist.posterPath, null);
      expect(watchlist.overview, null);
      expect(watchlist.type, null);
    });

    test('Two Watchlist entities with same properties should be equal', () {
      final watchlist1 = Watchlist(
        id: tWatchlistId,
        title: tWatchlistTitle,
        posterPath: tWatchlistPosterPath,
        overview: tWatchlistOverview,
        type: tWatchlistType,
      );

      final watchlist2 = Watchlist(
        id: tWatchlistId,
        title: tWatchlistTitle,
        posterPath: tWatchlistPosterPath,
        overview: tWatchlistOverview,
        type: tWatchlistType,
      );

      expect(watchlist1, equals(watchlist2));
    });

    test('Different Watchlist entities should not be equal', () {
      final watchlist1 = Watchlist(
        id: tWatchlistId,
        title: tWatchlistTitle,
        posterPath: tWatchlistPosterPath,
        overview: tWatchlistOverview,
        type: tWatchlistType,
      );

      final watchlist2 = Watchlist(
        id: 2,
        title: tWatchlistTitle,
        posterPath: tWatchlistPosterPath,
        overview: tWatchlistOverview,
        type: tWatchlistType,
      );

      expect(watchlist1, isNot(watchlist2));
    });

    test('Watchlist of type tv should work correctly', () {
      final tvWatchlist = Watchlist(
        id: 100,
        title: 'Breaking Bad',
        posterPath: '/posterPath',
        overview: 'A drama series',
        type: 'tv',
      );

      expect(tvWatchlist.type, 'tv');
    });

    test('Watchlist props should include all properties', () {
      final watchlist = Watchlist(
        id: tWatchlistId,
        title: tWatchlistTitle,
        posterPath: tWatchlistPosterPath,
        overview: tWatchlistOverview,
        type: tWatchlistType,
      );

      expect(
        watchlist.props,
        [tWatchlistId, tWatchlistTitle, tWatchlistPosterPath, tWatchlistOverview, tWatchlistType],
      );
    });
  });
}
