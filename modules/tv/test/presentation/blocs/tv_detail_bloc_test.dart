import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/tv_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVDetailBloc tvDetailBloc;
  late MockGetTVDetail mockGetTVDetail;
  late MockGetTVRecommendations mockGetTVRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTVDetail = MockGetTVDetail();
    mockGetTVRecommendations = MockGetTVRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    tvDetailBloc = TVDetailBloc(
      getTVDetail: mockGetTVDetail,
      getTVRecommendations: mockGetTVRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group('Get TV Detail', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'should emit [Loading, Loaded, RecommendationLoading, RecommendationLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTVDetail.execute(tId))
            .thenAnswer((_) async => Right(testTVDetail));
        when(mockGetTVRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTVList));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTVDetail(tId)),
      expect: () => [
        TVDetailState.initial().copyWith(tvState: RequestState.loading),
        TVDetailState.initial().copyWith(
          tvState: RequestState.loaded,
          tv: testTVDetail,
          recommendationState: RequestState.loading,
        ),
        TVDetailState.initial().copyWith(
          tvState: RequestState.loaded,
          tv: testTVDetail,
          recommendationState: RequestState.loaded,
          tvRecommendations: testTVList,
        ),
      ],
      verify: (_) {
        verify(mockGetTVDetail.execute(tId));
        verify(mockGetTVRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<TVDetailBloc, TVDetailState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId, 'tv'))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
      expect: () => [
        TVDetailState.initial().copyWith(isAddedToWatchlist: true),
      ],
    );
  });
}
