part of 'on_the_air_tv_bloc.dart';

abstract class OnTheAirTVState extends Equatable {
  const OnTheAirTVState();

  @override
  List<Object> get props => [];
}

class OnTheAirTVEmpty extends OnTheAirTVState {}

class OnTheAirTVLoading extends OnTheAirTVState {}

class OnTheAirTVError extends OnTheAirTVState {
  final String message;

  const OnTheAirTVError(this.message);

  @override
  List<Object> get props => [message];
}

class OnTheAirTVHasData extends OnTheAirTVState {
  final List<TV> result;

  const OnTheAirTVHasData(this.result);

  @override
  List<Object> get props => [result];
}
