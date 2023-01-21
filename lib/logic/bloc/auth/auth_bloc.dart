// import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:evaluation_project/domain/models/auth/auth_model.dart';
import 'package:evaluation_project/logic/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  static AuthBloc of(BuildContext context) =>
      BlocProvider.of<AuthBloc>(context);

  final AuthRepository _repository;

  AuthBloc({
    required AuthRepository repository,
  })  : _repository = repository,
        super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<RegisterEvnet>(_onRegisterEvnet);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      bool networkStatus = await InternetConnectionChecker().hasConnection;
      if (!networkStatus) {
        emit(const AuthNetworkConnectionError("No internet connection"));
        return;
      }
      final model = await _repository.login(
        event.email,
        event.pass,
        onError: (message) {
          emit(AuthError(message));
        },
      );
      if (model == null) return;
      emit(AuthLoaded(model));
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      emit(const AuthError("Something went wrong!"));
    }
  }

  Future<void> _onRegisterEvnet(
      RegisterEvnet event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      bool networkStatus = await InternetConnectionChecker().hasConnection;
      if (!networkStatus) {
        emit(const AuthNetworkConnectionError("No internet connection"));
        return;
      }
      final model = await _repository.register(
        event.name,
        event.phone,
        event.email,
        event.pass,
        event.confirmPass,
        onError: (message) {
          emit(AuthError(message));
        },
      );
      if (model == null) return;
      emit(AuthLoaded(model));
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      emit(const AuthError("Something went wrong!"));
    }
  }

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _repository.logout();
      emit(LogoutSuccess());
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      emit(const AuthError("Something went wrong!"));
    }
  }
}
