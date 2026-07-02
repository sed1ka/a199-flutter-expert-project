import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_popular_tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTVBloc extends Bloc<PopularTVEvent, PopularTVState> {
  final GetPopularTV _getPopularTV;

  PopularTVBloc(this._getPopularTV) : super(PopularTVEmpty()) {
    on<FetchPopularTV>((event, emit) async {
      emit(PopularTVLoading());
      final result = await _getPopularTV.execute();

      result.fold(
        (failure) {
          emit(PopularTVError(failure.message));
        },
        (data) {
          emit(PopularTVHasData(data));
        },
      );
    });
  }
}
