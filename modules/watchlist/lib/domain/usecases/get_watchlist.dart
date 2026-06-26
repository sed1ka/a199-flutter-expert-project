import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/domain/repos/watchlist_repository.dart';

class GetWatchlist {
  final WatchlistRepository repository;

  GetWatchlist(this.repository);

  Future<Either<Failure, List<Watchlist>>> execute() async {
    return await repository.getWatchlist();
  }
}
