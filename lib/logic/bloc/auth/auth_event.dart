part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String pass;

  const LoginEvent(this.email, this.pass);

  @override
  List<Object> get props => [
        email,
        pass,
      ];
}

class RegisterEvnet extends AuthEvent {
  final String name;
  final String phone;
  final String email;
  final String pass;
  final String confirmPass;

  const RegisterEvnet(
    this.name,
    this.phone,
    this.email,
    this.pass,
    this.confirmPass,
  );

  @override
  List<Object> get props => [
        email,
        pass,
        name,
        phone,
        confirmPass,
      ];
}

class LogoutEvent extends AuthEvent {}
