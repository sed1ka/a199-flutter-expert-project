import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockWatchlistRepository mockWatchlistRepository;

  setUp(() {
    mockWatchlistRepository = MockWatchlistRepository();
    usecase = GetWatchlist(mockWatchlistRepository);
  });


  final tWatchlist = <Watchlist>[testWatchlist];

  test('should get list of watchlist from the repository', () async {
    // arrange
    when(mockWatchlistRepository.getWatchlist())
        .thenAnswer((_) async => Right<Failure, List<Watchlist>>(tWatchlist));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right<Failure, List<Watchlist>>(tWatchlist));
  });
}
