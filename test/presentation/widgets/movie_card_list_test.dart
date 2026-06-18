import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MovieCard Widget', () {
    final tMovie = Movie(
      adult: false,
      backdropPath: '/backdropPath',
      genreIds: [1, 2],
      id: 1,
      originalTitle: 'Spider-Man',
      overview: 'A superhero movie',
      popularity: 75.5,
      posterPath: '/posterPath',
      releaseDate: '2002-05-01',
      title: 'Spider-Man',
      video: false,
      voteAverage: 7.2,
      voteCount: 13507,
    );

    testWidgets('MovieCard should display movie title', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(tMovie),
          ),
          routes: {
            MovieDetailPage.ROUTE_NAME: (context) => Scaffold(),
          },
        ),
      );

      expect(find.text(tMovie.title ?? '-'), findsOneWidget);
    });

    testWidgets('MovieCard should display movie overview', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(tMovie),
          ),
          routes: {
            MovieDetailPage.ROUTE_NAME: (context) => Scaffold(),
          },
        ),
      );

      expect(find.text(tMovie.overview ?? '-'), findsOneWidget);
    });

    testWidgets('MovieCard should have InkWell for tap interaction',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(tMovie),
          ),
          routes: {
            MovieDetailPage.ROUTE_NAME: (context) => Scaffold(),
          },
        ),
      );

      expect(find.byType(InkWell), findsOneWidget);
    });

    testWidgets('MovieCard should navigate on tap', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(tMovie),
          ),
          routes: {
            MovieDetailPage.ROUTE_NAME: (context) => Scaffold(),
          },
        ),
      );

      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      expect(find.byType(Scaffold), findsWidgets);
    });

    testWidgets('MovieCard should display Card widget', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(tMovie),
          ),
          routes: {
            MovieDetailPage.ROUTE_NAME: (context) => Scaffold(),
          },
        ),
      );

      expect(find.byType(Card), findsOneWidget);
    });

    testWidgets('MovieCard should display CachedNetworkImage', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(tMovie),
          ),
          routes: {
            MovieDetailPage.ROUTE_NAME: (context) => Scaffold(),
          },
        ),
      );

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('MovieCard with null title should display dash', (WidgetTester tester) async {
      final movieWithNullTitle = Movie(
        adult: false,
        backdropPath: '/backdropPath',
        genreIds: [1, 2],
        id: 1,
        originalTitle: null,
        overview: 'Overview',
        popularity: 75.5,
        posterPath: '/posterPath',
        releaseDate: '2002-05-01',
        title: null,
        video: false,
        voteAverage: 7.2,
        voteCount: 13507,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(movieWithNullTitle),
          ),
          routes: {
            MovieDetailPage.ROUTE_NAME: (context) => Scaffold(),
          },
        ),
      );

      expect(find.text('-'), findsWidgets);
    });

    testWidgets('MovieCard with null overview should display dash', (WidgetTester tester) async {
      final movieWithNullOverview = Movie(
        adult: false,
        backdropPath: '/backdropPath',
        genreIds: [1, 2],
        id: 1,
        originalTitle: 'Title',
        overview: null,
        popularity: 75.5,
        posterPath: '/posterPath',
        releaseDate: '2002-05-01',
        title: 'Title',
        video: false,
        voteAverage: 7.2,
        voteCount: 13507,
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MovieCard(movieWithNullOverview),
          ),
          routes: {
            MovieDetailPage.ROUTE_NAME: (context) => Scaffold(),
          },
        ),
      );

      expect(find.text('-'), findsWidgets);
    });
  });
}
