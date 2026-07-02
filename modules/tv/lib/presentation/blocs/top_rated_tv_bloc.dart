import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTVBloc extends Bloc<TopRatedTVEvent, TopRatedTVState> {
  final GetTopRatedTV _getTopRatedTV;

  TopRatedTVBloc(this._getTopRatedTV) : super(TopRatedTVEmpty()) {
    on<FetchTopRatedTV>((event, emit) async {
      emit(TopRatedTVLoading());
      final result = await _getTopRatedTV.execute();

      result.fold(
        (failure) {
          emit(TopRatedTVError(failure.message));
        },
        (data) {
          emit(TopRatedTVHasData(data));
        },
      );
    });
  }
}
