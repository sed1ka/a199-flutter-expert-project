import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/presentation/blocs/watchlist_bloc.dart';
import 'package:watchlist/presentation/watchlist_grid_card.dart';
import 'package:watchlist/presentation/watchlist_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWatchlistBloc mockBloc;

  setUp(() {
    mockBloc = MockWatchlistBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(WatchlistLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(WatchlistLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display GridView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(WatchlistHasData([testWatchlist]));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(WatchlistHasData([testWatchlist])));

    await tester.pumpWidget(makeTestableWidget(const WatchlistPage()));

    expect(find.byType(GridView), findsOneWidget);
    expect(find.byType(WatchlistGridCard), findsOneWidget);
  });
}
