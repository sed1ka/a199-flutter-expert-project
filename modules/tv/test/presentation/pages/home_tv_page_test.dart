import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/on_the_air_tv_bloc.dart';
import 'package:tv/presentation/blocs/popular_tv_bloc.dart';
import 'package:tv/presentation/blocs/top_rated_tv_bloc.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/tv_search_page.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockOnTheAirTvBloc mockOnTheAirBloc;
  late MockPopularTvBloc mockPopularBloc;
  late MockTopRatedTvBloc mockTopRatedBloc;

  setUp(() {
    mockOnTheAirBloc = MockOnTheAirTvBloc();
    mockPopularBloc = MockPopularTvBloc();
    mockTopRatedBloc = MockTopRatedTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnTheAirTvBloc>.value(value: mockOnTheAirBloc),
        BlocProvider<PopularTvBloc>.value(value: mockPopularBloc),
        BlocProvider<TopRatedTvBloc>.value(value: mockTopRatedBloc),
      ],
      child: MaterialApp(
        home: body,
        routes: {
          TvSearchPage.routeName: (context) => const TvSearchPage(),
        },
      ),
    );
  }

  testWidgets('Page should display loading when on the air is loading',
      (WidgetTester tester) async {
    when(mockOnTheAirBloc.state).thenReturn(OnTheAirTvLoading());
    when(mockPopularBloc.state).thenReturn(PopularTvLoading());
    when(mockTopRatedBloc.state).thenReturn(TopRatedTvLoading());
    when(mockOnTheAirBloc.stream).thenAnswer((_) => Stream.value(OnTheAirTvLoading()));
    when(mockPopularBloc.stream).thenAnswer((_) => Stream.value(PopularTvLoading()));
    when(mockTopRatedBloc.stream).thenAnswer((_) => Stream.value(TopRatedTvLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));

    expect(progressBarFinder, findsWidgets);
  });
}
