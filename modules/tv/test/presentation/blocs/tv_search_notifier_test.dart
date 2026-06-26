import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:tv/presentation/blocs/tv_search_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tv_search_notifier_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvSearchNotifier notifier;
  late MockSearchTv mockSearchTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchTv = MockSearchTv();
    notifier = TvSearchNotifier(searchTv: mockSearchTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTv = Tv(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    firstAirDate: 'firstAirDate',
    name: 'name',
    voteAverage: 1,
    voteCount: 1,
  );
  final tTvList = <Tv>[tTv];
  final tQuery = 'spiderman';

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockSearchTv.execute(tQuery)).thenAnswer((_) async => Right(tTvList));
    // act
    notifier.fetchTvSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test(
    'should change search result data when data is gotten successfully',
    () async {
      // arrange
      when(
        mockSearchTv.execute(tQuery),
      ).thenAnswer((_) async => Right(tTvList));
      // act
      await notifier.fetchTvSearch(tQuery);
      // assert
      expect(notifier.state, RequestState.Loaded);
      expect(notifier.searchResult, tTvList);
      expect(listenerCallCount, 2);
    },
  );

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(
      mockSearchTv.execute(tQuery),
    ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvSearch(tQuery);
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
