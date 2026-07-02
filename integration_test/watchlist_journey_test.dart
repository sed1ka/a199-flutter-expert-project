import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
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

      // Make sure snackbar is dissapear
      await tester.pump(const Duration(seconds: 5));

      // Back
      await tester.tap(find.byKey(const Key('back_button')));
      await tester.pumpAndSettle();

      expect(find.byType(HomeMoviePage), findsOneWidget);

      // Open drawer
      await tester.tap(find.byIcon(Icons.menu));
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
      expect(find.byType(GridView), findsOneWidget);

      await tester.tap(find.byKey(const Key('watchlist_0')));
      await tester.pumpAndSettle();

      final isHomeMovie = find.byType(HomeMoviePage).evaluate().isNotEmpty;
      final isHomeTv = find.byType(HomeTvPage).evaluate().isNotEmpty;

      expect(isHomeMovie || isHomeTv, isTrue);

      // Remove from watchlist
      expect(find.text('Watchlist'), findsOneWidget);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Removed from Watchlist'), findsOneWidget);
    },
  );
}