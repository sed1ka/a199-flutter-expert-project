import 'package:bloc_test/bloc_test.dart';
import 'package:core/errors/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/tv_search_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSearchBloc tvSearchBloc;
  late MockSearchTV mockSearchTV;

  setUp(() {
    mockSearchTV = MockSearchTV();
    tvSearchBloc = TVSearchBloc(mockSearchTV);
  });

  final tTVModel = TV(
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
  final tTVList = <TV>[tTVModel];
  final tQuery = 'spiderman';

  test('initial state should be empty with initial message', () {
    expect(tvSearchBloc.state, const TVSearchEmpty('Input the TV Series name'));
  });

  blocTest<TVSearchBloc, TVSearchState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(
        mockSearchTV.execute(tQuery),
      ).thenAnswer((_) async => Right(tTVList));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 550),
    // debounce
    expect: () => [TVSearchLoading(), TVSearchHasData(tTVList)],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );

  blocTest<TVSearchBloc, TVSearchState>(
    'should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(
        mockSearchTV.execute(tQuery),
      ).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 550),
    expect: () => [TVSearchLoading(), const TVSearchError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );

  blocTest<TVSearchBloc, TVSearchState>(
    'should emit [Loading, Empty] when data is empty',
    build: () {
      when(
        mockSearchTV.execute(tQuery),
      ).thenAnswer((_) async => const Right([]));
      return tvSearchBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      TVSearchLoading(),
      const TVSearchEmpty('TV Series not found'),
    ],
    verify: (bloc) {
      verify(mockSearchTV.execute(tQuery));
    },
  );
}
