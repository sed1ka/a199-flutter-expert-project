import 'package:watchlist/data/models/watchlist_table.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

final testWatchlist = Watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'movie',
);

final testWatchlistTable = WatchlistTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
  type: 'movie',
);

final testWatchlistMap = {
  'id': 1,
  'title': 'title',
  'posterPath': 'posterPath',
  'overview': 'overview',
  'type': 'movie',
};
