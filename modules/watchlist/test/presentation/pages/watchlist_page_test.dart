import 'package:core/core.dart';
import 'package:core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/presentation/watchlist_grid_card.dart';
import 'package:watchlist/presentation/watchlist_notifier.dart';
import 'package:watchlist/presentation/watchlist_page.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistNotifier])
void main() {
  late MockWatchlistNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistNotifier();

    // Stub fetchWatchlist() yang dipanggil pada initState
    when(mockNotifier.fetchWatchlist())
        .thenAnswer((_) async {});
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        navigatorObservers: [
          routeObserver,
        ],
        home: body,
      ),
    );
  }

  testWidgets(
    'Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState)
          .thenReturn(RequestState.Loading);

      await tester.pumpWidget(
        makeTestableWidget(WatchlistPage()),
      );

      // Jalankan Future.microtask()
      await tester.pump();

      expect(find.byType(Center), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      verify(mockNotifier.fetchWatchlist()).called(1);
    },
  );

  testWidgets(
    'Page should display GridView when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState)
          .thenReturn(RequestState.Loaded);

      when(mockNotifier.watchlistItems)
          .thenReturn([testWatchlist]);

      await tester.pumpWidget(
        makeTestableWidget(WatchlistPage()),
      );

      await tester.pump();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(WatchlistGridCard), findsOneWidget);

      verify(mockNotifier.fetchWatchlist()).called(1);
    },
  );

  testWidgets(
    'Page should display text when data is empty',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState)
          .thenReturn(RequestState.Loaded);

      when(mockNotifier.watchlistItems)
          .thenReturn(<Watchlist>[]);

      await tester.pumpWidget(
        makeTestableWidget(WatchlistPage()),
      );

      await tester.pump();

      expect(find.text('Watchlist is Empty'), findsOneWidget);

      verify(mockNotifier.fetchWatchlist()).called(1);
    },
  );

  testWidgets(
    'Page should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState)
          .thenReturn(RequestState.Error);

      when(mockNotifier.message)
          .thenReturn('Error message');

      await tester.pumpWidget(
        makeTestableWidget(WatchlistPage()),
      );

      await tester.pump();

      expect(find.byKey(const Key('error_message')), findsOneWidget);
      expect(find.text('Error message'), findsOneWidget);

      verify(mockNotifier.fetchWatchlist()).called(1);
    },
  );
}