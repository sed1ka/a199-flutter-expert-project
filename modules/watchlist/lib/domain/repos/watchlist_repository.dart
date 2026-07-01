import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:watchlist/domain/entities/watchlist.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, String>> saveWatchlist(Watchlist watchlist);
  Future<Either<Failure, String>> removeWatchlist(Watchlist watchlist);
  Future<bool> isAddedToWatchlist(int id, String type);
  Future<Either<Failure, List<Watchlist>>> getWatchlist();
}
