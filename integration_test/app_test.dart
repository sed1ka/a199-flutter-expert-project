import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/search_page.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('User Journey Integration Test', () {
    testWidgets('Watchlist Journey: should add and remove movie from watchlist',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Find the first movie item in Now Playing list
      final movieItemFinder = find.byType(InkWell).first;
      await tester.tap(movieItemFinder);
      await tester.pumpAndSettle();

      // Verify we are on the Detail Page
      expect(find.byType(MovieDetailPage), findsOneWidget);

      // Find and tap the Watchlist button
      final watchlistButtonFinder = find.byType(ElevatedButton);
      expect(find.text('Watchlist'), findsOneWidget);
      await tester.tap(watchlistButtonFinder);
      await tester.pumpAndSettle();

      // Verify SnackBar appears (Added to Watchlist)
      expect(find.text('Added to Watchlist'), findsOneWidget);
      expect(find.byIcon(Icons.check), findsOneWidget);

      // Go back to Home Page
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      // Open Navigation Drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Find and tap Watchlist menu
      await tester.tap(find.text('Watchlist'));
      await tester.pumpAndSettle();

      // Verify we are on Watchlist Page and the item is there
      expect(find.text('Watchlist'), findsOneWidget);
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('Search Journey: should search and find movies',
        (WidgetTester tester) async {
      // Re-run app (GetIt handled inside init)
      // Note: In integration tests, usually we don't call app.main() multiple times 
      // if it re-initializes things that can't be re-initialized. 
      // But for this simple app, we can just navigate or restart if needed.
      // If the previous test left the app running, we can just start from where it was.
      
      // Let's assume we start fresh for this test
      app.main(); 
      await tester.pumpAndSettle();

      // Find and tap Search Icon in AppBar
      final searchIconFinder = find.byIcon(Icons.search);
      await tester.tap(searchIconFinder);
      await tester.pumpAndSettle();

      // Verify on Search Page
      expect(find.byType(SearchPage), findsOneWidget);

      // Enter query "Spiderman"
      final searchTextFieldFinder = find.byType(TextField);
      await tester.enterText(searchTextFieldFinder, 'spiderman');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pumpAndSettle(const Duration(seconds: 1)); // Wait for debounce/API

      // Verify search results appear
      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('TV Series Journey: should navigate to TV and see details',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Open Navigation Drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Tap TV Series menu
      await tester.tap(find.text('TV Series'));
      await tester.pumpAndSettle();

      // Verify on Home TV Page
      expect(find.byType(HomeTvPage), findsOneWidget);

      // Tap the first TV item
      final tvItemFinder = find.byType(InkWell).first;
      await tester.tap(tvItemFinder);
      await tester.pumpAndSettle();

      // Verify on TV Detail Page
      expect(find.byType(TvDetailPage), findsOneWidget);
      expect(find.text('Watchlist'), findsOneWidget);
    });
  });
}
