import 'package:about/about_page.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:watchlist/presentation/watchlist_page.dart';

void main() {
  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        drawer: body,
      ),
    );
  }

  Widget createWidget({String currentRoute = HomeMoviePage.routeName}) {
    return MaterialApp(
      home: Scaffold(
        drawer: CustomDrawer(
          currentRoute: currentRoute,
        ),
        body: Container(),
      ),
    );
  }

  Future<void> openDrawer(WidgetTester tester) async {
    final scaffoldState = tester.state<ScaffoldState>(
      find.byType(Scaffold),
    );

    scaffoldState.openDrawer();
    await tester.pumpAndSettle();
  }

  group('CustomDrawer', () {
    testWidgets(
      'should display drawer header with correct information',
          (tester) async {
        await tester.pumpWidget(createWidget());
        await openDrawer(tester);

        expect(find.byType(UserAccountsDrawerHeader), findsOneWidget);
        expect(find.text('Ditonton'), findsOneWidget);
        expect(find.text('ditonton@dicoding.com'), findsOneWidget);
      },
    );

    testWidgets(
      'should display application logo',
          (tester) async {
        await tester.pumpWidget(createWidget());
        await openDrawer(tester);

        final avatar = tester.widget<CircleAvatar>(
          find.byType(CircleAvatar),
        );

        final image = avatar.backgroundImage as AssetImage;

        expect(image.assetName, AppAssets.logo);
      },
    );

    testWidgets(
      'should display Movies menu',
          (tester) async {
        await tester.pumpWidget(createWidget());
        await openDrawer(tester);

        expect(find.text('Movies'), findsOneWidget);
        expect(find.byIcon(Icons.movie), findsOneWidget);
        expect(find.widgetWithText(ListTile, 'Movies'), findsOneWidget);
      },
    );

    testWidgets(
      'should display TV Series menu',
          (tester) async {
        await tester.pumpWidget(createWidget());
        await openDrawer(tester);

        expect(find.text('TV Series'), findsOneWidget);
        expect(find.byIcon(Icons.tv), findsOneWidget);
        expect(find.widgetWithText(ListTile, 'TV Series'), findsOneWidget);
      },
    );

    testWidgets(
      'should display Watchlist menu',
          (tester) async {
        await tester.pumpWidget(createWidget());
        await openDrawer(tester);

        expect(find.text('Watchlist'), findsOneWidget);
        expect(find.byIcon(Icons.save_alt), findsOneWidget);
        expect(find.widgetWithText(ListTile, 'Watchlist'), findsOneWidget);
      },
    );

    testWidgets(
      'should display About menu',
          (tester) async {
        await tester.pumpWidget(createWidget());
        await openDrawer(tester);

        expect(find.text('About'), findsOneWidget);
        expect(find.byIcon(Icons.info_outline), findsOneWidget);
        expect(find.widgetWithText(ListTile, 'About'), findsOneWidget);
      },
    );

    group('Movies menu', () {
      testWidgets(
        'should be selected when currentRoute is HomeMoviePage.routeName',
            (tester) async {
          await tester.pumpWidget(
            createWidget(currentRoute: HomeMoviePage.routeName),
          );

          final scaffold = tester.state<ScaffoldState>(
            find.byType(Scaffold),
          );

          scaffold.openDrawer();
          await tester.pumpAndSettle();

          final listTile = tester.widget<ListTile>(
            find.widgetWithText(ListTile, 'Movies'),
          );

          expect(listTile.selected, isTrue);
        },
      );

      testWidgets(
        'should not be selected when currentRoute is not HomeMoviePage.routeName',
            (tester) async {
          await tester.pumpWidget(
            createWidget(currentRoute: '/another-route'),
          );

          await openDrawer(tester);

          final tile = tester.widget<ListTile>(
            find.widgetWithText(ListTile, 'Movies'),
          );

          expect(tile.selected, isFalse);
        },
      );

      testWidgets(
        'should close drawer when Movies menu is tapped on current page',
            (tester) async {
          await tester.pumpWidget(
            createWidget(currentRoute: HomeMoviePage.routeName),
          );

          await openDrawer(tester);

          await tester.tap(find.text('Movies'));
          await tester.pumpAndSettle();

          expect(find.text('Movies'), findsNothing);
        },
      );

      testWidgets(
        'should execute navigation branch when Movies menu is tapped from another page',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              routes: {
                HomeMoviePage.routeName: (_) => const Scaffold(
                  body: Text('Home Movie'),
                ),
              },
              home: Scaffold(
                drawer: const CustomDrawer(
                  currentRoute: '/another-route',
                ),
              ),
            ),
          );

          await openDrawer(tester);

          await tester.tap(find.text('Movies'));
          await tester.pumpAndSettle();

          expect(find.text('Home Movie'), findsOneWidget);
        },
      );
    });

    group('TV Series menu', () {
      testWidgets(
        'should be selected when currentRoute is HomeTvPage.routeName',
            (tester) async {
          await tester.pumpWidget(
            createWidget(currentRoute: HomeTvPage.routeName),
          );

          final scaffold = tester.state<ScaffoldState>(
            find.byType(Scaffold),
          );

          scaffold.openDrawer();
          await tester.pumpAndSettle();

          final listTile = tester.widget<ListTile>(
            find.widgetWithText(ListTile, 'TV Series'),
          );

          expect(listTile.selected, isTrue);
        },
      );

      testWidgets(
        'should not be selected when currentRoute is not HomeTvPage.routeName',
            (tester) async {
          await tester.pumpWidget(
            createWidget(currentRoute: '/another-route'),
          );

          await openDrawer(tester);

          final tile = tester.widget<ListTile>(
            find.widgetWithText(ListTile, 'TV Series'),
          );

          expect(tile.selected, isFalse);
        },
      );

      testWidgets(
        'should close drawer when TV Series menu is tapped on current page',
            (tester) async {
          await tester.pumpWidget(
            createWidget(currentRoute: HomeTvPage.routeName),
          );

          await openDrawer(tester);

          await tester.tap(find.text('TV Series'));
          await tester.pumpAndSettle();

          expect(find.text('TV Series'), findsNothing);
        },
      );

      testWidgets(
        'should execute navigation branch when Movies menu is tapped from another page',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              routes: {
                HomeTvPage.routeName: (_) => const Scaffold(
                  body: Text('Home TV Series'),
                ),
              },
              home: Scaffold(
                drawer: const CustomDrawer(
                  currentRoute: '/another-route',
                ),
              ),
            ),
          );

          await openDrawer(tester);

          await tester.tap(find.text('TV Series'));
          await tester.pumpAndSettle();

          expect(find.text('Home TV Series'), findsOneWidget);
        },
      );
    });

    group('Watchlist menu', () {
      testWidgets(
        'should be selected when currentRoute is WatchlistPage.routeName',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                drawer: const CustomDrawer(
                  currentRoute: WatchlistPage.routeName,
                ),
              ),
            ),
          );

          final scaffold =
          tester.state<ScaffoldState>(find.byType(Scaffold));

          scaffold.openDrawer();
          await tester.pumpAndSettle();

          final tile = tester.widget<ListTile>(
            find.widgetWithText(ListTile, 'Watchlist'),
          );

          expect(tile.selected, isTrue);
        },
      );

      testWidgets(
        'should navigate to Watchlist page when tapped',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              routes: {
                WatchlistPage.routeName: (_) => const Scaffold(
                  body: Text('Watchlist Page'),
                ),
              },
              home: Scaffold(
                drawer: const CustomDrawer(
                  currentRoute: '/',
                ),
              ),
            ),
          );

          final scaffold =
          tester.state<ScaffoldState>(find.byType(Scaffold));

          scaffold.openDrawer();
          await tester.pumpAndSettle();

          await tester.tap(find.text('Watchlist'));
          await tester.pumpAndSettle();

          expect(find.text('Watchlist Page'), findsOneWidget);
        },
      );
    });

    group('About menu', () {
      testWidgets(
        'should be selected when currentRoute is AboutPage.routeName',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              home: Scaffold(
                drawer: const CustomDrawer(
                  currentRoute: AboutPage.routeName,
                ),
              ),
            ),
          );

          final scaffold =
          tester.state<ScaffoldState>(find.byType(Scaffold));

          scaffold.openDrawer();
          await tester.pumpAndSettle();

          final tile = tester.widget<ListTile>(
            find.widgetWithText(ListTile, 'About'),
          );

          expect(tile.selected, isTrue);
        },
      );

      testWidgets(
        'should navigate to About page when tapped',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              routes: {
                AboutPage.routeName: (_) => const Scaffold(
                  body: Text('About Page'),
                ),
              },
              home: Scaffold(
                drawer: const CustomDrawer(
                  currentRoute: '/',
                ),
              ),
            ),
          );

          final scaffold =
          tester.state<ScaffoldState>(find.byType(Scaffold));

          scaffold.openDrawer();
          await tester.pumpAndSettle();

          await tester.tap(find.text('About'));
          await tester.pumpAndSettle();

          expect(find.text('About Page'), findsOneWidget);
        },
      );
    });
  });

  testWidgets('CustomDrawer should display all menu items', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget(CustomDrawer(currentRoute: '/home')));

    final scaffoldKey = GlobalKey<ScaffoldState>();
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        key: scaffoldKey,
        drawer: CustomDrawer(currentRoute: '/home'),
        body: Container(),
      ),
    ));

    scaffoldKey.currentState?.openDrawer();
    await tester.pump();

    expect(find.text('Movies'), findsOneWidget);
    expect(find.text('TV Series'), findsOneWidget);
    expect(find.text('Watchlist'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });
}
