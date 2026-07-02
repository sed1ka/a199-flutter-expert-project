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
  late MockOnTheAirTVBloc mockOnTheAirBloc;
  late MockPopularTVBloc mockPopularBloc;
  late MockTopRatedTVBloc mockTopRatedBloc;

  setUp(() {
    mockOnTheAirBloc = MockOnTheAirTVBloc();
    mockPopularBloc = MockPopularTVBloc();
    mockTopRatedBloc = MockTopRatedTVBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OnTheAirTVBloc>.value(value: mockOnTheAirBloc),
        BlocProvider<PopularTVBloc>.value(value: mockPopularBloc),
        BlocProvider<TopRatedTVBloc>.value(value: mockTopRatedBloc),
      ],
      child: MaterialApp(
        home: body,
        routes: {
          TVSearchPage.routeName: (context) => const TVSearchPage(),
        },
      ),
    );
  }

  testWidgets('Page should display loading when on the air is loading',
      (WidgetTester tester) async {
    when(mockOnTheAirBloc.state).thenReturn(OnTheAirTVLoading());
    when(mockPopularBloc.state).thenReturn(PopularTVLoading());
    when(mockTopRatedBloc.state).thenReturn(TopRatedTVLoading());
    when(mockOnTheAirBloc.stream).thenAnswer((_) => Stream.value(OnTheAirTVLoading()));
    when(mockPopularBloc.stream).thenAnswer((_) => Stream.value(PopularTVLoading()));
    when(mockTopRatedBloc.stream).thenAnswer((_) => Stream.value(TopRatedTVLoading()));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(makeTestableWidget(const HomeTVPage()));

    expect(progressBarFinder, findsWidgets);
  });
}
