import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/repos/watchlist_repository.dart';

class SaveWatchlist {
  final WatchlistRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(Watchlist watchlist) async {
    return await repository.saveWatchlist(watchlist);
  }
}
