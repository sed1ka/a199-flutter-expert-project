import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'TV Series Journey: should navigate to TV and see details',
        (WidgetTester tester) async {
      await app.bootstrap(enableCrashlytics: false);

      await tester.pumpAndSettle();

      // Open Drawer
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Open TV Series
      await tester.tap(find.text('TV Series'));
      await tester.pumpAndSettle();

      expect(find.byType(HomeTVPage), findsOneWidget);

      // Tap first TV item from On The Air section
      final tvItemFinder =
      find.byKey(const ValueKey('OnTheAir_tv_item_0'));

      expect(tvItemFinder, findsOneWidget);

      await tester.tap(tvItemFinder);
      await tester.pumpAndSettle();

      expect(find.byType(TVDetailPage), findsOneWidget);
      expect(find.text('Watchlist'), findsOneWidget);
    },
  );
}