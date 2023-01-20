part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final HomeModel model;

  const HomeLoaded(this.model);

  @override
  List<Object> get props => [model];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);
  @override
  List<Object> get props => [message];
}

class HomeNetworkConnectionError extends HomeState {
  final String message;

  const HomeNetworkConnectionError(this.message);
  @override
  List<Object> get props => [message];
}
