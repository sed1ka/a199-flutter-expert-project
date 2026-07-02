import 'dart:io';

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/data/models/tv_model.dart';
import 'package:tv/data/repos/tv_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTVLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockLocalDataSource = MockTVLocalDataSource();
    repository = TVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  final tTVModel = TVModel(
    backdropPath: '/path.jpg',
    genreIds: [1, 2],
    id: 1,
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTV = TV(
    backdropPath: '/path.jpg',
    genreIds: [1, 2],
    id: 1,
    originalName: 'Original Name',
    overview: 'Overview',
    popularity: 1.0,
    posterPath: '/path.jpg',
    firstAirDate: '2022-01-01',
    name: 'Name',
    voteAverage: 1.0,
    voteCount: 1,
  );

  final tTVModelList = <TVModel>[tTVModel];
  final tTVList = <TV>[tTV];

  group('On The Air TV Series', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTV());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTV()).thenThrow(ServerException());
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTV());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTV();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTV());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Popular TV Series', () {
    test('should return tv list when call to remote data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getPopularTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTV();
      // assert
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Top Rated TV Series', () {
    test('should return tv list when call to remote data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV())
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.getTopRatedTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTV();
      // assert
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Detail', () {
    final tId = 1;

    test('should return TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenAnswer((_) async => testTVDetailResponse);
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Right(testTVDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTVDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get TV Recommendations', () {
    final tTVList = <TVModel>[];
    final tId = 1;

    test('should return data (tv list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenAnswer((_) async => tTVList);
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      final resultList = result.getOrElse(() => []);
      expect(resultList, []);
    });

    test('should return Server Failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVRecommendations(tId);
      // assert
      verify(mockRemoteDataSource.getTVRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TV Series', () {
    final tQuery = 'spiderman';

    test('should return tv list when call to remote data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenAnswer((_) async => tTVModelList);
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTVList);
    });

    test('should return ServerFailure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTV(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTV(tQuery);
      // assert
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
