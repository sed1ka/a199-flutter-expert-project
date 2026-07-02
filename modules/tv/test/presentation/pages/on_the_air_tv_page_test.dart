import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/on_the_air_tv_bloc.dart';
import 'package:tv/presentation/pages/on_the_air_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockOnTheAirTVBloc mockBloc;

  setUp(() {
    mockBloc = MockOnTheAirTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTVBloc>.value(
      value: mockBloc,
      child: MaterialApp(home: body),
    );
  }

  testWidgets('Page should display center progress bar when loading', (
    WidgetTester tester,
  ) async {
    when(mockBloc.state).thenReturn(OnTheAirTVLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(OnTheAirTVLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTVPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded', (
    WidgetTester tester,
  ) async {
    when(mockBloc.state).thenReturn(OnTheAirTVHasData(testTVList));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(OnTheAirTVHasData(testTVList)));

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTVPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error', (
    WidgetTester tester,
  ) async {
    when(mockBloc.state).thenReturn(const OnTheAirTVError('Error message'));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(const OnTheAirTVError('Error message')));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTVPage()));

    expect(textFinder, findsOneWidget);
  });
}
