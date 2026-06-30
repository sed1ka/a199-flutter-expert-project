import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/blocs/tv_search_bloc.dart';
import 'package:tv/presentation/pages/tv_search_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvSearchBloc
    extends MockBloc<TvSearchEvent, TvSearchState>
    implements TvSearchBloc {}

void main() {
  late MockTvSearchBloc mockBloc;

  setUp(() {
    mockBloc = MockTvSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSearchBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSearchLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const TvSearchPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TvSearchHasData(testTvList));

    await tester.pumpWidget(makeTestableWidget(const TvSearchPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display error message when error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const TvSearchError('Error message'));

    await tester.pumpWidget(makeTestableWidget(const TvSearchPage()));

    expect(find.text('Error message'), findsOneWidget);
  });
}
