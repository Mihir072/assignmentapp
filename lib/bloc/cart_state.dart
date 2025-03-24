import 'package:equatable/equatable.dart';
import '../models/product_model.dart';

abstract class CartState extends Equatable {
  final List<Product> cart;
  final double totalPrice;

  const CartState({this.cart = const [], this.totalPrice = 0});

  @override
  List<Object> get props => [cart, totalPrice];
}

class CartUpdated extends CartState {
  const CartUpdated(List<Product> cart, double totalPrice)
      : super(cart: cart, totalPrice: totalPrice);
}
