import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/presentation/blocs/watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchlist mockGetWatchlist;

  setUp(() {
    mockGetWatchlist = MockGetWatchlist();
    watchlistBloc = WatchlistBloc(mockGetWatchlist);
  });

  test('initial state should be empty', () {
    expect(watchlistBloc.state, WatchlistEmpty());
  });

  blocTest<WatchlistBloc, WatchlistState>(
    'should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetWatchlist.execute())
          .thenAnswer((_) async => Right([testWatchlist]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(FetchWatchlist()),
    expect: () => [
      WatchlistLoading(),
      WatchlistHasData([testWatchlist]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlist.execute());
    },
  );
}
