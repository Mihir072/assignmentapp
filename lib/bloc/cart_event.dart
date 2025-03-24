part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class UpdateCart extends CartEvent {
  final Product product;
  final bool increase;
  UpdateCart(this.product, this.increase);
}
