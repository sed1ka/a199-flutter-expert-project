import 'package:core/network/network_info.dart';
import 'package:db/db.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/domain/repos/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/domain/usecases/search_movies.dart';
import 'package:watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:watchlist/domain/usecases/remove_watchlist.dart';
import 'package:watchlist/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/blocs/movie_detail_bloc.dart';
import 'package:movie/presentation/blocs/movie_search_bloc.dart';
import 'package:movie/presentation/blocs/now_playing_movies_bloc.dart';
import 'package:movie/presentation/blocs/popular_movies_bloc.dart';
import 'package:movie/presentation/blocs/top_rated_movies_bloc.dart';

import 'package:http/http.dart' as http;

@GenerateMocks(
  [
    MovieRepository,
    MovieRemoteDataSource,
    MovieLocalDataSource,
    DatabaseHelper,
    NetworkInfo,
    GetNowPlayingMovies,
    GetPopularMovies,
    GetTopRatedMovies,
    GetMovieDetail,
    GetMovieRecommendations,
    SearchMovies,
    GetWatchListStatus,
    SaveWatchlist,
    RemoveWatchlist,
    MovieDetailBloc,
    MovieSearchBloc,
    NowPlayingMoviesBloc,
    PopularMoviesBloc,
    TopRatedMoviesBloc,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
