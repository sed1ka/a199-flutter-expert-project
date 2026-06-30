import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/blocs/now_playing_movies_bloc.dart';
import 'package:movie/presentation/blocs/popular_movies_bloc.dart';
import 'package:movie/presentation/blocs/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/search_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockNowPlayingMoviesBloc mockNowPlayingBloc;
  late MockPopularMoviesBloc mockPopularBloc;
  late MockTopRatedMoviesBloc mockTopRatedBloc;

  setUp(() {
    mockNowPlayingBloc = MockNowPlayingMoviesBloc();
    mockPopularBloc = MockPopularMoviesBloc();
    mockTopRatedBloc = MockTopRatedMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>.value(value: mockNowPlayingBloc),
        BlocProvider<PopularMoviesBloc>.value(value: mockPopularBloc),
        BlocProvider<TopRatedMoviesBloc>.value(value: mockTopRatedBloc),
      ],
      child: MaterialApp(
        home: body,
        routes: {
          SearchPage.routeName: (context) => const SearchPage(),
        },
      ),
    );
  }

  testWidgets('Page should display loading when now playing is loading',
      (WidgetTester tester) async {
    when(mockNowPlayingBloc.state).thenReturn(NowPlayingMoviesLoading());
    when(mockPopularBloc.state).thenReturn(PopularMoviesLoading());
    when(mockTopRatedBloc.state).thenReturn(TopRatedMoviesLoading());
    when(mockNowPlayingBloc.stream).thenAnswer((_) => Stream.value(NowPlayingMoviesLoading()));
    when(mockPopularBloc.stream).thenAnswer((_) => Stream.value(PopularMoviesLoading()));
    when(mockTopRatedBloc.stream).thenAnswer((_) => Stream.value(TopRatedMoviesLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(HomeMoviePage()));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display loaded content when all data is loaded',
      (WidgetTester tester) async {
    when(mockNowPlayingBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(mockPopularBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));
    when(mockTopRatedBloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));
    when(mockNowPlayingBloc.stream).thenAnswer((_) => Stream.value(NowPlayingMoviesHasData(testMovieList)));
    when(mockPopularBloc.stream).thenAnswer((_) => Stream.value(PopularMoviesHasData(testMovieList)));
    when(mockTopRatedBloc.stream).thenAnswer((_) => Stream.value(TopRatedMoviesHasData(testMovieList)));

    await tester.pumpWidget(makeTestableWidget(HomeMoviePage()));

    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byType(ListView), findsWidgets);
  });
}
