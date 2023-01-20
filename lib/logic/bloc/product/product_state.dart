part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final ProductModel model;

  const ProductLoaded(this.model);

  @override
  List<Object> get props => [model];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}

class ProductNetworkConnectionError extends ProductState {
  final String message;

  const ProductNetworkConnectionError(this.message);

  @override
  List<Object> get props => [message];
}
