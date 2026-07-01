import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/blocs/movie_detail_bloc.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieState: RequestState.loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
    ));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(MovieDetailState.initial().copyWith(
      movieState: RequestState.loaded,
      movie: testMovieDetail,
      recommendationState: RequestState.loaded,
      movieRecommendations: [],
      isAddedToWatchlist: false,
    )));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}
