import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_on_the_air_tv.dart';

part 'on_the_air_tv_event.dart';
part 'on_the_air_tv_state.dart';

class OnTheAirTVBloc extends Bloc<OnTheAirTVEvent, OnTheAirTVState> {
  final GetOnTheAirTV _getOnTheAirTV;

  OnTheAirTVBloc(this._getOnTheAirTV) : super(OnTheAirTVEmpty()) {
    on<FetchOnTheAirTV>((event, emit) async {
      emit(OnTheAirTVLoading());
      final result = await _getOnTheAirTV.execute();

      result.fold(
        (failure) {
          emit(OnTheAirTVError(failure.message));
        },
        (data) {
          emit(OnTheAirTVHasData(data));
        },
      );
    });
  }
}
