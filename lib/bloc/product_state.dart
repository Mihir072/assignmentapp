part of 'product_bloc.dart';

abstract class ProductState extends Equatable {
  final List<Product> products;
  final bool isLoadingMore;

  const ProductState({this.products = const [], this.isLoadingMore = false});

  @override
  List<Object> get props => [products, isLoadingMore];
}

class ProductInitial extends ProductState {}

class ProductLoaded extends ProductState {
  const ProductLoaded(List<Product> products, {super.isLoadingMore})
      : super(products: products);
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
}
