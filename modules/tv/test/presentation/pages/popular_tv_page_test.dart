import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/popular_tv_bloc.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockPopularTVBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<PopularTVBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PopularTVLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(PopularTVLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(PopularTVHasData(testTVList));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(PopularTVHasData(testTVList)));

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(const PopularTVError('Error message'));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(const PopularTVError('Error message')));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const PopularTVPage()));

    expect(textFinder, findsOneWidget);
  });
}
