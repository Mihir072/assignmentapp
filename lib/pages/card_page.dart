import 'package:assingmentapp/bloc/cart/cart_bloc.dart';
import 'package:assingmentapp/bloc/cart/cart_state.dart';
import 'package:assingmentapp/widget/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../util/colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Shopping Cart',
          style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomBarWidget()),
              (route) => false,
            );
          },
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated && state.cart.isNotEmpty) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(10),
                    itemCount: state.cart.length,
                    itemBuilder: (context, index) {
                      final product = state.cart[index];
                      return Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(product.thumbnail,
                                width: 60, height: 60, fit: BoxFit.cover),
                          ),
                          title: Text(product.title,
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "₹${(product.price * product.quantity).toStringAsFixed(2)}",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 16)),
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove_circle),
                                    onPressed: () {
                                      context
                                          .read<CartBloc>()
                                          .add(UpdateCart(product, false));
                                    },
                                  ),
                                  Text("${product.quantity}",
                                      style: TextStyle(fontSize: 16)),
                                  IconButton(
                                    icon: Icon(Icons.add_circle),
                                    onPressed: () {
                                      context
                                          .read<CartBloc>()
                                          .add(UpdateCart(product, true));
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(RemoveFromCart(product));
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10)
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total: ₹${state.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_bag, color: Colors.white),
                          label: Text("Checkout",
                              style:
                                  GoogleFonts.josefinSans(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                            backgroundColor: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      height: 100,
                      "https://cdn-icons-gif.flaticon.com/15547/15547234.gif"),
                  SizedBox(height: 10),
                  Text('Your cart is empty',
                      style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
