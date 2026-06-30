import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_on_the_air_tv.dart';

part 'on_the_air_tv_event.dart';
part 'on_the_air_tv_state.dart';

class OnTheAirTvBloc extends Bloc<OnTheAirTvEvent, OnTheAirTvState> {
  final GetOnTheAirTv _getOnTheAirTv;

  OnTheAirTvBloc(this._getOnTheAirTv) : super(OnTheAirTvEmpty()) {
    on<FetchOnTheAirTv>((event, emit) async {
      emit(OnTheAirTvLoading());
      final result = await _getOnTheAirTv.execute();

      result.fold(
        (failure) {
          emit(OnTheAirTvError(failure.message));
        },
        (data) {
          emit(OnTheAirTvHasData(data));
        },
      );
    });
  }
}
