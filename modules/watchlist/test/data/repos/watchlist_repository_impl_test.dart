import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/data/repos/watchlist_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late WatchlistRepositoryImpl repository;
  late MockWatchlistLocalDataSource mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockWatchlistLocalDataSource();
    repository = WatchlistRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(testWatchlistTable),
      ).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testWatchlist);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.insertWatchlist(testWatchlistTable),
      ).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testWatchlist);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testWatchlistTable),
      ).thenAnswer((_) async => 'Removed from Watchlist');
      // act
      final result = await repository.removeWatchlist(testWatchlist);
      // assert
      expect(result, Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(
        mockLocalDataSource.removeWatchlist(testWatchlistTable),
      ).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testWatchlist);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      final tType = 'movie';
      when(
        mockLocalDataSource.getWatchlistById(tId, tType),
      ).thenAnswer((_) async => testWatchlistTable);
      // act
      final result = await repository.isAddedToWatchlist(tId, tType);
      // assert
      expect(result, true);
    });

    test('should return false when data is not found', () async {
      // arrange
      final tId = 1;
      final tType = 'movie';
      when(
        mockLocalDataSource.getWatchlistById(tId, tType),
      ).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId, tType);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist', () {
    test('should return list of Watchlist', () async {
      // arrange
      when(
        mockLocalDataSource.getWatchlist(),
      ).thenAnswer((_) async => [testWatchlistTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlist]);
    });
  });
}
