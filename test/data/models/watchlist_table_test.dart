import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_objects.dart';

void main() {
  test('should return a JSON map from WatchlistTable', () async {
    final result = testWatchlistTable.toJson();

    final expectedJsonMap = {
      'id': 1,
      'title': 'title',
      'posterPath': 'posterPath',
      'overview': 'overview',
      'type': 'movie',
    };

    expect(result, expectedJsonMap);
  });

  test('should return a Watchlist entity from WatchlistTable', () async {
    final result = testWatchlistTable.toEntity();
    expect(result, testWatchlist);
  });
}
