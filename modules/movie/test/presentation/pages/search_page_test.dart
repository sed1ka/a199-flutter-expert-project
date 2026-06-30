import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/blocs/movie_search_bloc.dart';
import 'package:movie/presentation/pages/search_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockMovieSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockMovieSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieSearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieSearchLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(MovieSearchLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display search results when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(MovieSearchHasData(testMovieList));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(MovieSearchHasData(testMovieList)));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(find.byType(ListView), findsOneWidget);
  });
}
