import 'package:bloc/bloc.dart' show EventTransformer;
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

EventTransformer<E> debounceRestartable<E>(Duration duration) {
  return (events, mapper) {
    return restartable<E>()(events.debounce(duration), mapper);
  };
}
