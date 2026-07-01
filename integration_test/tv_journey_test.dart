import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.main();

  testWidgets('TV Series Journey: should navigate to TV and see details',
      (WidgetTester tester) async {
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
}
