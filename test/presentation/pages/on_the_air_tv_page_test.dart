import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/on_the_air_tv_page.dart';
import 'package:ditonton/presentation/provider/on_the_air_tv_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/Provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_the_air_tv_page_test.mocks.dart';

@GenerateMocks([OnTheAirTvNotifier])
void main() {
  late MockOnTheAirTvNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockOnTheAirTvNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<OnTheAirTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display route name constant',
      (WidgetTester tester) async {
    expect(OnTheAirTvPage.ROUTE_NAME, '/on-the-air-tv');
  });

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loaded);
    when(mockNotifier.tv).thenReturn(testTvList);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display app bar with title',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.Loading);

    await tester.pumpWidget(_makeTestableWidget(OnTheAirTvPage()));

    expect(find.text('On The Air TV Series'), findsOneWidget);
  });
}
