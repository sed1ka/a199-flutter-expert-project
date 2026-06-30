import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/watchlist.dart';
import '../../domain/usecases/get_watchlist.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist _getWatchlist;

  WatchlistBloc(this._getWatchlist) : super(WatchlistEmpty()) {
    on<FetchWatchlist>((event, emit) async {
      emit(WatchlistLoading());
      final result = await _getWatchlist.execute();

      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistHasData(data));
        },
      );
    });
  }
}
