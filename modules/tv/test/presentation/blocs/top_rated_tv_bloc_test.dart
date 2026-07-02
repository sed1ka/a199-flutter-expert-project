import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/top_rated_tv_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTopRatedTV mockGetTopRatedTV;
  late TopRatedTVBloc topRatedTVBloc;

  setUp(() {
    mockGetTopRatedTV = MockGetTopRatedTV();
    topRatedTVBloc = TopRatedTVBloc(mockGetTopRatedTV);
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
    expect(topRatedTVBloc.state, TopRatedTVEmpty());
  });

  blocTest<TopRatedTVBloc, TopRatedTVState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRatedTV.execute()).thenAnswer((_) async => Right(tTVList));
      return topRatedTVBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTV()),
    expect: () => [
      TopRatedTVLoading(),
      TopRatedTVHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetTopRatedTV.execute());
    },
  );
}
