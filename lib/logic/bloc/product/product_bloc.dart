// import 'package:bloc/bloc.dart';
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:evaluation_project/domain/models/product/product_model.dart';
import 'package:evaluation_project/logic/repositories/product/product_repository.dart';
import 'package:evaluation_project/service_locator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  static ProductBloc get() => getIt.get<ProductBloc>();

  final ProductRepository _repository;
  ProductBloc({required ProductRepository repository})
      : _repository = repository,
        super(ProductInitial()) {
    on<GetProductEvent>(_onGetProductEvent);
  }

  Future<void> _onGetProductEvent(
      GetProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      bool networkStatus = await InternetConnectionChecker().hasConnection;
      if (!networkStatus) {
        emit(const ProductNetworkConnectionError("No internet connection"));
        return;
      }
      final model = await _repository.getProduct(
        event.id,
        onError: (message) {
          emit(ProductError(message));
        },
      );
      if (model == null) return;
      emit(ProductLoaded(model));
    } catch (e, t) {
      debugPrint(e.toString());
      debugPrint(t.toString());
      emit(const ProductError("Something went wrong!"));
    }
  }
}
