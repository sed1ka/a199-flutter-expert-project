import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/blocs/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTopRatedTvBloc
    extends MockBloc<TopRatedTvEvent, TopRatedTvState>
    implements TopRatedTvBloc {}

void main() {
  late MockTopRatedTvBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(TopRatedTvHasData(testTvList));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.state).thenReturn(const TopRatedTvError('Error message'));

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
