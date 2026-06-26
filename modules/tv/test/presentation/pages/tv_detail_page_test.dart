import 'package:core/core.dart';
import 'package:tv/presentation/blocs/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/Provider.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display route name constant',
      (WidgetTester tester) async {
    expect(TvDetailPage.ROUTE_NAME, '/detail-tv');
  });

  testWidgets('Page should display loading state',
      (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display error message', (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Error);
    when(mockNotifier.message).thenReturn('Error');

    await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('Page should accept TV ID parameter', (WidgetTester tester) async {
    final page = TvDetailPage(id: 999);
    expect(page.id, 999);
  });

  testWidgets('Page should create state', (WidgetTester tester) async {
    when(mockNotifier.tvState).thenReturn(RequestState.Loading);

    await tester.pumpWidget(makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byType(Scaffold), findsOneWidget);
  });
}
