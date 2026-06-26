import 'package:core/core.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/blocs/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tv/presentation/pages/tv_search_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'home_tv_page_test.mocks.dart';

@GenerateMocks([TvListNotifier])
void main() {
  late MockTvListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvListNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        routes: {
          TvSearchPage.ROUTE_NAME: (context) => TvSearchPage(),
        },
      ),
    );
  }

  testWidgets('Page should display route name constant',
      (WidgetTester tester) async {
    expect(HomeTvPage.ROUTE_NAME, '/home-tv');
  });

  testWidgets('Page should display loading when on the air is loading',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loading);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loading);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(HomeTvPage()));

    expect(progressBarFinder, findsWidgets);
  });

  testWidgets('Page should display loaded content when all data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onTheAirTv).thenReturn(testTvList);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn(testTvList);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn(testTvList);

    await tester.pumpWidget(makeTestableWidget(HomeTvPage()));

    expect(find.text('On The Air'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
  });

  testWidgets('Page should display error message when on the air has error',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Error);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn(testTvList);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn(testTvList);

    await tester.pumpWidget(makeTestableWidget(HomeTvPage()));

    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('Page should display app bar with title and search icon',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onTheAirTv).thenReturn([]);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn([]);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn([]);

    await tester.pumpWidget(makeTestableWidget(HomeTvPage()));

    expect(find.text('TV Series'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('Page should display empty list when no tv loaded',
      (WidgetTester tester) async {
    when(mockNotifier.onTheAirState).thenReturn(RequestState.Loaded);
    when(mockNotifier.onTheAirTv).thenReturn([]);
    when(mockNotifier.popularTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.popularTv).thenReturn([]);
    when(mockNotifier.topRatedTvState).thenReturn(RequestState.Loaded);
    when(mockNotifier.topRatedTv).thenReturn([]);

    await tester.pumpWidget(makeTestableWidget(HomeTvPage()));

    expect(find.byType(ListView), findsWidgets);
  });
}
