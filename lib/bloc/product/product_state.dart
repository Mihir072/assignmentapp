part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  final List<Product> products;
  final bool isLoadingMore;

  const ProductState({this.products = const [], this.isLoadingMore = false});

  @override
  List<Object> get props => [products, isLoadingMore];
}

class ProductInitial extends ProductState {}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
}

class ProductLoaded extends ProductState {
  @override
  // ignore: overridden_fields
  final List<Product> products;

  @override
  // ignore: overridden_fields
  final bool isLoadingMore;

  const ProductLoaded(this.products, {this.isLoadingMore = false});

  @override
  List<Object> get props => [products, isLoadingMore];
}
