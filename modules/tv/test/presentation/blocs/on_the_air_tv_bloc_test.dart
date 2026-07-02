import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/blocs/on_the_air_tv_bloc.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetOnTheAirTV mockGetOnTheAirTV;
  late OnTheAirTVBloc onTheAirTVBloc;

  setUp(() {
    mockGetOnTheAirTV = MockGetOnTheAirTV();
    onTheAirTVBloc = OnTheAirTVBloc(mockGetOnTheAirTV);
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
    expect(onTheAirTVBloc.state, OnTheAirTVEmpty());
  });

  blocTest<OnTheAirTVBloc, OnTheAirTVState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnTheAirTV.execute()).thenAnswer((_) async => Right(tTVList));
      return onTheAirTVBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTV()),
    expect: () => [
      OnTheAirTVLoading(),
      OnTheAirTVHasData(tTVList),
    ],
    verify: (bloc) {
      verify(mockGetOnTheAirTV.execute());
    },
  );
}
