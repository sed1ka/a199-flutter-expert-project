import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/popular_tv_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetPopularTV mockGetPopularTV;
  late PopularTVBloc popularTVBloc;

  setUp(() {
    mockGetPopularTV = MockGetPopularTV();
    popularTVBloc = PopularTVBloc(mockGetPopularTV);
  });

  final tTV = TV(
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
  final tTVList = <TV>[tTV];

  test('initial state should be empty', () {
    expect(popularTVBloc.state, PopularTVEmpty());
  });

  blocTest<PopularTVBloc, PopularTVState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTV.execute()).thenAnswer((_) async => Right(tTVList));
      return popularTVBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTV()),
    expect: () => [
      PopularTVLoading(),
      PopularTVHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTV.execute());
    },
  );
}
