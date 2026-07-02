import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/blocs/tv_detail_bloc.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVDetailBloc mockBloc;

  setUp(() {
    mockBloc = MockTVDetailBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TVDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display loading state',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TVDetailState.initial().copyWith(
      tvState: RequestState.loading,
    ));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TVDetailState.initial().copyWith(
      tvState: RequestState.loading,
    )));

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Page should display loaded state',
      (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TVDetailState.initial().copyWith(
      tvState: RequestState.loaded,
      tv: testTVDetail,
      recommendationState: RequestState.loaded,
      tvRecommendations: [],
    ));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TVDetailState.initial().copyWith(
      tvState: RequestState.loaded,
      tv: testTVDetail,
      recommendationState: RequestState.loaded,
      tvRecommendations: [],
    )));

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.text(testTVDetail.name), findsOneWidget);
  });

  testWidgets('Page should display error message', (WidgetTester tester) async {
    when(mockBloc.state).thenReturn(TVDetailState.initial().copyWith(
      tvState: RequestState.error,
      message: 'Error',
    ));
    when(mockBloc.stream).thenAnswer((_) => Stream.value(TVDetailState.initial().copyWith(
      tvState: RequestState.error,
      message: 'Error',
    )));

    await tester.pumpWidget(makeTestableWidget(const TVDetailPage(id: 1)));

    expect(find.text('Error'), findsOneWidget);
  });
}
