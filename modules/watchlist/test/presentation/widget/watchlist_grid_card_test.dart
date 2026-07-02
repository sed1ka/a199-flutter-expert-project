import 'package:watchlist/domain/entities/watchlist.dart';
import 'package:watchlist/presentation/watchlist_grid_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tWatchlist = Watchlist(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    type: 'movie',
  );

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: body,
      ),
    );
  }

  testWidgets('should display title and type label', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(
      SizedBox(
        height: 200,
        child: WatchlistGridCard(tWatchlist),
      ),
    ));

    expect(find.text('title'), findsOneWidget);
    expect(find.text('MOVIE'), findsOneWidget);
  });

  testWidgets('should display TV SERIES label for tv type', (WidgetTester tester) async {
    final tWatchlistTV = Watchlist(
      id: 1,
      title: 'title',
      posterPath: 'posterPath',
      overview: 'overview',
      type: 'tv',
    );

    await tester.pumpWidget(makeTestableWidget(
      SizedBox(
        height: 200,
        child: WatchlistGridCard(tWatchlistTV),
      ),
    ));

    expect(find.text('TV SERIES'), findsOneWidget);
  });
}
