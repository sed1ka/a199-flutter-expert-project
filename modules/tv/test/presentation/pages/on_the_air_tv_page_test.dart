import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/blocs/on_the_air_tv_bloc.dart';
import 'package:tv/presentation/pages/on_the_air_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockOnTheAirTvBloc
    extends MockBloc<OnTheAirTvEvent, OnTheAirTvState>
    implements OnTheAirTvBloc {}

void main() {
  late MockOnTheAirTvBloc mockBloc;

  setUp(() {
    mockBloc = MockOnTheAirTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<OnTheAirTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnTheAirTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(OnTheAirTvHasData(testTvList));

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const OnTheAirTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
