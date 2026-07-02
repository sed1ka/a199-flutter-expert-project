import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTopRatedTVBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTVBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TopRatedTVLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TopRatedTVLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TopRatedTVHasData(testTVList));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TopRatedTVHasData(testTVList)));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(const TopRatedTVError('Error message'));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(const TopRatedTVError('Error message')));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTVPage()));

    expect(textFinder, findsOneWidget);
  });
}
