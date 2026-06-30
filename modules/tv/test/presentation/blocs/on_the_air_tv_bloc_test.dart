import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/on_the_air_tv_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetOnTheAirTv mockGetOnTheAirTv;
  late OnTheAirTvBloc onTheAirTvBloc;

  setUp(() {
    mockGetOnTheAirTv = MockGetOnTheAirTv();
    onTheAirTvBloc = OnTheAirTvBloc(mockGetOnTheAirTv);
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

  test('initial state should be empty', () {
    expect(onTheAirTvBloc.state, OnTheAirTvEmpty());
  });

  blocTest<OnTheAirTvBloc, OnTheAirTvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTv.execute()).thenAnswer((_) async => Right(tTvList));
      return onTheAirTvBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTv()),
    expect: () => [
      OnTheAirTvLoading(),
      OnTheAirTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTv.execute());
    },
  );
}
