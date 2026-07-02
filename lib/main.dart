import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/blocs/movie_detail_bloc.dart';
import 'package:movie/presentation/blocs/now_playing_movies_bloc.dart';
import 'package:movie/presentation/blocs/popular_movies_bloc.dart';
import 'package:movie/presentation/blocs/movie_search_bloc.dart';
import 'package:movie/presentation/blocs/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:tv/presentation/blocs/tv_detail_bloc.dart';
import 'package:tv/presentation/blocs/on_the_air_tv_bloc.dart';
import 'package:tv/presentation/blocs/popular_tv_bloc.dart';
import 'package:tv/presentation/blocs/tv_search_bloc.dart';
import 'package:tv/presentation/blocs/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/on_the_air_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/pages/tv_search_page.dart';
import 'package:watchlist/presentation/blocs/watchlist_bloc.dart';
import 'package:watchlist/presentation/watchlist_page.dart';
import 'package:ditonton/injection.dart' as di;

import 'firebase_options.dart';

Future<void> main() async {
  await bootstrap();
}

Future<void> bootstrap({
  bool enableCrashlytics = true,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (enableCrashlytics) {
    FlutterError.onError =
        FirebaseCrashlytics.instance.recordFlutterFatalError;

    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<NowPlayingMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTVBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TVDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [
          routeObserver,
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomeMoviePage.routeName:
              return MaterialPageRoute(
                builder: (_) => HomeMoviePage(),
                settings: settings,
              );
            case PopularMoviesPage.routeName:
              return MaterialPageRoute(
                builder: (_) => PopularMoviesPage(),
                settings: settings,
              );
            case TopRatedMoviesPage.routeName:
              return MaterialPageRoute(
                builder: (_) => TopRatedMoviesPage(),
                settings: settings,
              );
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.routeName:
              return MaterialPageRoute(
                builder: (_) => SearchPage(),
                settings: settings,
              );
            case WatchlistPage.routeName:
              return MaterialPageRoute(
                builder: (_) => WatchlistPage(),
                settings: settings,
              );
            case HomeTVPage.routeName:
              return MaterialPageRoute(
                builder: (_) => HomeTVPage(),
                settings: settings,
              );
            case OnTheAirTVPage.routeName:
              return MaterialPageRoute(
                builder: (_) => OnTheAirTVPage(),
                settings: settings,
              );
            case PopularTVPage.routeName:
              return MaterialPageRoute(
                builder: (_) => PopularTVPage(),
                settings: settings,
              );
            case TopRatedTVPage.routeName:
              return MaterialPageRoute(
                builder: (_) => TopRatedTVPage(),
                settings: settings,
              );
            case TVDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVDetailPage(id: id),
                settings: settings,
              );
            case TVSearchPage.routeName:
              return MaterialPageRoute(
                builder: (_) => TVSearchPage(),
                settings: settings,
              );
            case AboutPage.routeName:
              return MaterialPageRoute(
                builder: (_) => AboutPage(),
                settings: settings,
              );
            default:
              return MaterialPageRoute(
                builder: (_) => Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                ),
                settings: settings,
              );
          }
        },
      ),
    );
  }
}
