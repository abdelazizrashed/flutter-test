import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:evaluation_project/domain/models/home/home_model.dart';
import 'package:evaluation_project/logic/repositories/home/home_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository _repository;
  HomeBloc({required HomeRepository repository})
      : _repository = repository,
        super(HomeInitial()) {
    on<GetHomeDataEvent>(_onGetHomeDataEvent);
  }

  Future<void> _onGetHomeDataEvent(
      GetHomeDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      bool networkStatus = await InternetConnectionChecker().hasConnection;
      if (!networkStatus) {
        emit(const HomeNetworkConnectionError("No internet connection"));
        return;
      }
      final model = await _repository.getData(
        onError: (message) {
          emit(HomeError(message));
        },
      );
      if (model == null) return;
      emit(HomeLoaded(model));
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      emit(const HomeError("Something went wrong!"));
    }
  }
}
