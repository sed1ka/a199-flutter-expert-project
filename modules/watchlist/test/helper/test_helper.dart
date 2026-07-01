import 'package:core/network/network_info.dart';
import 'package:db/db.dart';
import 'package:mockito/annotations.dart';
import 'package:watchlist/data/datasources/watchlist_local_data_source.dart';
import 'package:watchlist/domain/repos/watchlist_repository.dart';
import 'package:watchlist/domain/usecases/get_watchlist.dart';
import 'package:watchlist/presentation/blocs/watchlist_bloc.dart';

import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    WatchlistRepository,
    WatchlistLocalDataSource,
    DatabaseHelper,
    NetworkInfo,
    GetWatchlist,
    WatchlistBloc,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
