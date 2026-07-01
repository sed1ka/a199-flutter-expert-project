import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/tv_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    tvDetailBloc = TvDetailBloc(
      getTvDetail: mockGetTvDetail,
      getTvRecommendations: mockGetTvRecommendations,
      getWatchListStatus: mockGetWatchlistStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  group('Get TV Detail', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should emit [Loading, Loaded, RecommendationLoading, RecommendationLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(tId))
            .thenAnswer((_) async => Right(testTvList));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const FetchTvDetail(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(tvState: RequestState.loading),
        TvDetailState.initial().copyWith(
          tvState: RequestState.loaded,
          tv: testTvDetail,
          recommendationState: RequestState.loading,
        ),
        TvDetailState.initial().copyWith(
          tvState: RequestState.loaded,
          tv: testTvDetail,
          recommendationState: RequestState.loaded,
          tvRecommendations: testTvList,
        ),
      ],
      verify: (_) {
        verify(mockGetTvDetail.execute(tId));
        verify(mockGetTvRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchlistStatus.execute(tId, 'tv'))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(const LoadWatchlistStatus(tId)),
      expect: () => [
        TvDetailState.initial().copyWith(isAddedToWatchlist: true),
      ],
    );
  });
}
