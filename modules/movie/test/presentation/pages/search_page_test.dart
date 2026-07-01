import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/blocs/movie_search_bloc.dart';
import 'package:movie/presentation/pages/search_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<MovieSearchState>(
      const MovieSearchEmpty('Dummy'),
    );
  });

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

  testWidgets(
    'Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockBloc.state).thenReturn(MovieSearchLoading());
      when(mockBloc.stream)
          .thenAnswer((_) => Stream.value(MovieSearchLoading()));

      await tester.pumpWidget(makeTestableWidget(const SearchPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Page should display search results when data is loaded',
        (WidgetTester tester) async {
      when(mockBloc.state).thenReturn(MovieSearchHasData(testMovieList));
      when(mockBloc.stream).thenAnswer(
            (_) => Stream.value(MovieSearchHasData(testMovieList)),
      );

      await tester.pumpWidget(makeTestableWidget(const SearchPage()));

      expect(find.byType(ListView), findsOneWidget);
    },
  );

  testWidgets(
    'Page should display message when data is empty',
        (WidgetTester tester) async {
      when(mockBloc.state)
          .thenReturn(const MovieSearchEmpty('Movie not found'));
      when(mockBloc.stream).thenAnswer(
            (_) => Stream.value(const MovieSearchEmpty('Movie not found')),
      );

      await tester.pumpWidget(makeTestableWidget(const SearchPage()));

      expect(find.text('Movie not found'), findsOneWidget);
    },
  );

  testWidgets(
    'Page should display error message when error',
        (WidgetTester tester) async {
      when(mockBloc.state)
          .thenReturn(const MovieSearchError('Error message'));
      when(mockBloc.stream).thenAnswer(
            (_) => Stream.value(const MovieSearchError('Error message')),
      );

      await tester.pumpWidget(makeTestableWidget(const SearchPage()));

      expect(find.text('Error message'), findsOneWidget);
    },
  );
}