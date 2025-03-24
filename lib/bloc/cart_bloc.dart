import 'package:assingmentapp/bloc/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/product_model.dart';

part 'cart_event.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final List<Product> cart = [];

  CartBloc() : super(CartUpdated([], 0)) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart); // ✅ This was causing the error
    on<UpdateCart>(_onUpdateCart);
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    print("🚀 Adding product: ${event.product.title}");

    final index = cart.indexWhere((item) => item.id == event.product.id);
    if (index != -1) {
      cart[index] = cart[index].copyWith(quantity: cart[index].quantity + 1);
      print("✅ Updated quantity: ${cart[index].quantity}");
    } else {
      cart.add(event.product.copyWith(quantity: 1));
      print("🆕 New product added: ${event.product.title}");
    }

    _updateState(emit);
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartState> emit) {
    print("❌ Removing product: ${event.product.title}");

    cart.removeWhere((item) => item.id == event.product.id);
    _updateState(emit);
  }

  void _onUpdateCart(UpdateCart event, Emitter<CartState> emit) {
    final index = cart.indexWhere((item) => item.id == event.product.id);
    if (index != -1) {
      if (event.increase) {
        cart[index] = cart[index].copyWith(quantity: cart[index].quantity + 1);
      } else {
        if (cart[index].quantity > 1) {
          cart[index] =
              cart[index].copyWith(quantity: cart[index].quantity - 1);
        } else {
          cart.removeAt(index);
        }
      }
    }
    _updateState(emit);
  }

  void _updateState(Emitter<CartState> emit) {
    double total =
        cart.fold(0, (sum, item) => sum + (item.price * item.quantity));
    print("📢 Cart Updated - Total: ₹$total, Items: ${cart.length}");
    print(
        "🛒 Current Cart Items: ${cart.map((item) => "${item.title} x${item.quantity}").toList()}");
    emit(CartUpdated(List.from(cart), total));
  }
}
