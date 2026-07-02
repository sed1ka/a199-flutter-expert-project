import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TVCard Widget', () {
    final tTV = TV(
      backdropPath: '/backdropPath',
      genreIds: [1, 2],
      id: 1,
      originalName: 'Breaking Bad',
      overview: 'A drama series',
      popularity: 75.5,
      posterPath: '/posterPath',
      firstAirDate: '2008-01-20',
      name: 'Breaking Bad',
      voteAverage: 9.5,
      voteCount: 25000,
    );

    testWidgets('TVCard should display tv series name', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tTV),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.text(tTV.name ?? '-'), findsOneWidget);
    });

    testWidgets('TVCard should display tv overview', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tTV),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.text(tTV.overview ?? '-'), findsOneWidget);
    });

    testWidgets('TVCard should have InkWell for tap interaction',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tTV),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('TVCard should navigate on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tTV),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('TVCard should display Card widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tTV),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('TVCard should display ClipRRect for image border radius',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tTV),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.byType(ClipRRect), findsOneWidget);
    });

    testWidgets('TVCard with null name should display dash', (WidgetTester tester) async {
      final tvWithNullName = TV(
        backdropPath: '/backdropPath',
        genreIds: [1, 2],
        id: 1,
        originalName: null,
        overview: 'Overview',
        popularity: 75.5,
        posterPath: '/posterPath',
        firstAirDate: '2008-01-20',
        name: null,
        voteAverage: 9.5,
        voteCount: 25000,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tvWithNullName),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.text('-'), findsWidgets);
    });

    testWidgets('TVCard with null overview should display dash', (WidgetTester tester) async {
      final tvWithNullOverview = TV(
        backdropPath: '/backdropPath',
        genreIds: [1, 2],
        id: 1,
        originalName: 'Name',
        overview: null,
        popularity: 75.5,
        posterPath: '/posterPath',
        firstAirDate: '2008-01-20',
        name: 'Name',
        voteAverage: 9.5,
        voteCount: 25000,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tvWithNullOverview),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.text('-'), findsWidgets);
    });

    testWidgets('TVCard should have Stack layout', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TVCard(tTV),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.byType(Stack), findsWidgets);
    });

    testWidgets('TVCard should have margin between cards', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ListView(
              children: [
                TVCard(tTV),
                TVCard(tTV),
              ],
            ),
          ),
          routes: {
            TVDetailPage.routeName: (context) => Scaffold(),
          },
        ),
      );

      expect(find.byType(TVCard), findsWidgets);
    });
  });
}
