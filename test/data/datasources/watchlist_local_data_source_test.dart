import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/watchlist_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = WatchlistLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('insert watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistGeneral(testWatchlistTable))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testWatchlistTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.insertWatchlistGeneral(testWatchlistTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testWatchlistTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testWatchlistTable.id, testWatchlistTable.type!))
          .thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testWatchlistTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      // arrange
      when(mockDatabaseHelper.removeWatchlist(testWatchlistTable.id, testWatchlistTable.type!))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testWatchlistTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('get watchlist by id', () {
    final tId = 1;
    final tType = 'movie';

    test('should return Watchlist Table when data is found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(tId, tType))
          .thenAnswer((_) async => testWatchlistMap);
      // act
      final result = await dataSource.getWatchlistById(tId, tType);
      // assert
      expect(result, testWatchlistTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlistById(tId, tType))
          .thenAnswer((_) async => null);
      // act
      final result = await dataSource.getWatchlistById(tId, tType);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist', () {
    test('should return list of WatchlistTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist())
          .thenAnswer((_) async => [testWatchlistMap]);
      // act
      final result = await dataSource.getWatchlist();
      // assert
      expect(result, [testWatchlistTable]);
    });
  });
}
