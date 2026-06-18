import 'package:ditonton/presentation/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        drawer: body,
      ),
    );
  }

  testWidgets('should display all menu items', (WidgetTester tester) async {
    await tester.pumpWidget(_makeTestableWidget(CustomDrawer(currentRoute: '/home')));
    
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
