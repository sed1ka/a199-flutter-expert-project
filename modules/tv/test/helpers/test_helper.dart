import 'package:core/utils/network_info.dart';
import 'package:db/db.dart';
import 'package:mockito/annotations.dart';
import 'package:tv/data/datasources/tv_local_data_source.dart';
import 'package:tv/data/datasources/tv_remote_data_source.dart';
import 'package:tv/domain/repos/tv_repository.dart';
import 'package:tv/domain/usecases/get_on_the_air_tv.dart';
import 'package:tv/domain/usecases/get_popular_tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/domain/usecases/get_tv_recommendations.dart';
import 'package:tv/domain/usecases/search_tv.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';
import 'package:tv/presentation/blocs/tv_detail_bloc.dart';
import 'package:tv/presentation/blocs/tv_search_bloc.dart';
import 'package:tv/presentation/blocs/on_the_air_tv_bloc.dart';
import 'package:tv/presentation/blocs/popular_tv_bloc.dart';
import 'package:tv/presentation/blocs/top_rated_tv_bloc.dart';

import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    TvRepository,
    TvRemoteDataSource,
    TvLocalDataSource,
    DatabaseHelper,
    NetworkInfo,
    GetOnTheAirTv,
    GetPopularTv,
    GetTopRatedTv,
    GetTvDetail,
    GetTvRecommendations,
    SearchTv,
    GetWatchListStatus,
    SaveWatchlist,
    RemoveWatchlist,
    TvDetailBloc,
    TvSearchBloc,
    OnTheAirTvBloc,
    PopularTvBloc,
    TopRatedTvBloc,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
