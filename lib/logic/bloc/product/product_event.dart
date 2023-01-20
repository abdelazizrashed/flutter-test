part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class GetProductEvent extends ProductEvent {
  final int id;

  const GetProductEvent(this.id);

  @override
  List<Object> get props => [id];
}
