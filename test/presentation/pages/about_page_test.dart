import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AboutPage should display route name constant',
      (WidgetTester tester) async {
    expect(AboutPage.ROUTE_NAME, '/about');
  });

  testWidgets('AboutPage should render without crashing',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AboutPage()));
    expect(find.byType(Scaffold), findsOneWidget);
  });

  testWidgets('AboutPage should display the Ditonton image',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AboutPage()));

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('AboutPage should display the description text',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AboutPage()));

    expect(
        find.text(
            'Ditonton merupakan sebuah aplikasi katalog film yang dikembangkan oleh Dicoding Indonesia sebagai contoh proyek aplikasi untuk kelas Menjadi Flutter Developer Expert.'),
        findsOneWidget);
  });

  testWidgets('AboutPage should have back button',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AboutPage()));

    expect(find.byIcon(Icons.arrow_back), findsOneWidget);
  });

  testWidgets('AboutPage back button should be IconButton',
      (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: AboutPage()));

    expect(find.byType(IconButton), findsOneWidget);
  });
}
