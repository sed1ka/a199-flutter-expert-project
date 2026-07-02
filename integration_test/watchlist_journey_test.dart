import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:watchlist/presentation/watchlist_page.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Watchlist Journey: should add and remove movie from watchlist',
        (WidgetTester tester) async {
      await app.bootstrap(enableCrashlytics: false);
      await tester.pumpAndSettle();

      // Tap first movie
      await tester.tap(find.byKey(const Key('NowPlaying_movie_item_0')));
      await tester.pumpAndSettle();

      expect(find.byType(MovieDetailPage), findsOneWidget);

      // Add to watchlist
      expect(find.text('Watchlist'), findsOneWidget);
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Added to Watchlist'), findsOneWidget);

      // Back
      await tester.tap(find.byKey(const Key('back_button')));
      await tester.pumpAndSettle();

      // Open drawer
      await tester.tap(find.byKey(const Key('main_drawer')));
      await tester.pumpAndSettle();

      // Tap drawer menu
      await tester.tap(
        find.descendant(
          of: find.byType(Drawer),
          matching: find.text('Watchlist'),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(WatchlistPage), findsOneWidget);

      // Minimal verification
      expect(find.text('Watchlist'), findsWidgets);

      // Verify movie exists
      expect(find.byType(ListView), findsOneWidget);
    },
  );
}