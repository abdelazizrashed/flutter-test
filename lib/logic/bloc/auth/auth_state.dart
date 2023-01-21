part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class LogoutSuccess extends AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoaded extends AuthState {
  final AuthModel model;

  const AuthLoaded(this.model);

  @override
  List<Object> get props => [model];
}

class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthNetworkConnectionError extends AuthState {
  final String message;

  const AuthNetworkConnectionError(this.message);

  @override
  List<Object> get props => [message];
}
