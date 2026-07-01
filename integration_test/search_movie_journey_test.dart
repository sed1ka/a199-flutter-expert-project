import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ditonton/main.dart' as app;
import 'package:movie/presentation/pages/search_page.dart';

Future<void> main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await app.main();

  testWidgets('Search Movie Journey: should search and find movies',
      (WidgetTester tester) async {
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
    await tester
        .pumpAndSettle(const Duration(seconds: 1)); // Wait for debounce/API

    // Verify search results appear
    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(InkWell), findsWidgets);
  });
}
