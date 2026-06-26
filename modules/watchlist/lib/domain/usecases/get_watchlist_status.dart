import 'package:watchlist/domain/repos/watchlist_repository.dart';

class GetWatchListStatus {
  final WatchlistRepository repository;

  GetWatchListStatus(this.repository);

  Future<bool> execute(int id, String type) async {
    return await repository.isAddedToWatchlist(id, type);
  }
}
