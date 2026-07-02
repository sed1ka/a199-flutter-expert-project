import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/tv_search_bloc.dart';
import 'package:tv/presentation/pages/tv_search_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  setUpAll(() {
    provideDummy<TVSearchState>(
      const TVSearchEmpty('Dummy'),
    );
  });

  late MockTVSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockTVSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TVSearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockBloc.state).thenReturn(TVSearchLoading());
      when(mockBloc.stream)
          .thenAnswer((_) => Stream.value(TVSearchLoading()));

      await tester.pumpWidget(makeTestableWidget(const TVSearchPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(mockBloc.state).thenReturn(TVSearchHasData(testTVList));
      when(mockBloc.stream)
          .thenAnswer((_) => Stream.value(TVSearchHasData(testTVList)));

      await tester.pumpWidget(makeTestableWidget(const TVSearchPage()));

      expect(find.byType(ListView), findsOneWidget);
    },
  );

  testWidgets(
    'Page should display message when data is empty',
        (WidgetTester tester) async {
      when(mockBloc.state)
          .thenReturn(const TVSearchEmpty('TV Series not found'));
      when(mockBloc.stream).thenAnswer(
            (_) => Stream.value(const TVSearchEmpty('TV Series not found')),
      );

      await tester.pumpWidget(makeTestableWidget(const TVSearchPage()));

      expect(find.text('TV Series not found'), findsOneWidget);
    },
  );

  testWidgets(
    'Page should display error message when error',
        (WidgetTester tester) async {
      when(mockBloc.state)
          .thenReturn(const TVSearchError('Error message'));
      when(mockBloc.stream).thenAnswer(
            (_) => Stream.value(const TVSearchError('Error message')),
      );

      await tester.pumpWidget(makeTestableWidget(const TVSearchPage()));

      expect(find.text('Error message'), findsOneWidget);
    },
  );
}