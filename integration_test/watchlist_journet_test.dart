import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:movie/presentation/pages/movie_detail_page.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Watchlist Journey: should add and remove movie from watchlist',
      (WidgetTester tester) async {
    await app.bootstrap(enableCrashlytics: false);
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
}
