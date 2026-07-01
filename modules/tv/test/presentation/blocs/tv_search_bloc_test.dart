import 'package:bloc_test/bloc_test.dart';
import 'package:core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/tv_search_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(mockSearchTv);
  });

  final tTvModel = Tv(
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalName: 'Spider-Man',
    overview: 'overview',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    firstAirDate: '2002-05-01',
    name: 'Spider-Man',
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'spiderman';

  test('initial state should be empty with initial message', () {
    expect(tvSearchBloc.state, const TvSearchEmpty('Input the TV Series name'));
  });

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(
        mockSearchTv.execute(tQuery),
      ).thenAnswer((_) async => Right(tTvList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 550),
    // debounce
    expect: () => [TvSearchLoading(), TvSearchHasData(tTvList)],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(
        mockSearchTv.execute(tQuery),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 550),
    expect: () => [TvSearchLoading(), const TvSearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<TvSearchBloc, TvSearchState>(
    'should emit [Loading, Empty] when data is empty',
    build: () {
      when(
        mockSearchTv.execute(tQuery),
      ).thenAnswer((_) async => const Right([]));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TvSearchLoading(),
      const TvSearchEmpty('TV Series not found'),
    ],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}
