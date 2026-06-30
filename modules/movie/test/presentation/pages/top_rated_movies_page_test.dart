import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/blocs/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTopRatedMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMoviesBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TopRatedMoviesLoading());
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TopRatedMoviesLoading()));

    final progressFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(progressFinder, findsOneWidget);
  });
}
