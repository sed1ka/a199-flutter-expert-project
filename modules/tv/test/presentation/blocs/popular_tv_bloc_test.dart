import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/popular_tv_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
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
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer((_) async => Right(tTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTv()),
    expect: () => [
      PopularTvLoading(),
      PopularTvHasData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTv.execute());
    },
  );
}
