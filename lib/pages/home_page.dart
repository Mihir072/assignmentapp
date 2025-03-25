import 'package:assingmentapp/bloc/cart/cart_bloc.dart';
import 'package:assingmentapp/bloc/cart/cart_state.dart';
import 'package:assingmentapp/bloc/product/product_bloc.dart';
import 'package:assingmentapp/widget/loader_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:badges/badges.dart' as badges;
import '../pages/card_page.dart';
import '../pages/product_detail_page.dart';
import '../util/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchProducts());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        context.read<ProductBloc>().add(FetchMoreProducts());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Catalogue',
          style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: mainColor,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: context.read<CartBloc>(),
                      child: CartPage(),
                    ),
                  ),
                );
              },
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  int cartItemCount =
                      state is CartUpdated ? state.cart.length : 0;
                  return badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -4, end: -4),
                    badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
                    badgeContent: Text(cartItemCount.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                    child: Icon(Icons.shopping_cart,
                        size: 28, color: Colors.white),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductInitial) {
            return Center(child: LoaderPage());
          } else if (state is ProductLoaded) {
            return Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.6,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount:
                        state.products.length + (state.isLoadingMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == state.products.length) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final product = state.products[index];
                      double discountPrice = product.price -
                          (product.price * product.discountPercentage / 100);

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetailPage(
                                product: product,
                                addToCart: (product) {
                                  context
                                      .read<CartBloc>()
                                      .add(AddToCart(product));
                                },
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24),
                                ),
                                child: Image.network(
                                  product.thumbnail,
                                  height: 150,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14)),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "₹${product.price.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            Text(
                                              "₹${discountPrice.toStringAsFixed(2)}",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red),
                                            ),
                                            Text(
                                              "-${product.discountPercentage}% Off",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.green,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            context
                                                .read<CartBloc>()
                                                .add(AddToCart(product));
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "🎉 Added to cart! Ready to checkout?",
                                                  style:
                                                      GoogleFonts.josefinSans(
                                                          color: Colors.black,
                                                          fontSize: 16),
                                                ),
                                                backgroundColor: Colors.white,
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                elevation: 8,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                margin: EdgeInsets.all(16),
                                                action: SnackBarAction(
                                                  label: 'Undo',
                                                  textColor: Colors.pinkAccent,
                                                  onPressed: () {},
                                                ),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: mainColor),
                                          child: Text('Add',
                                              style: GoogleFonts.josefinSans(
                                                  color: Colors.white)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text("Failed to load products"));
          }
        },
      ),
    );
  }
}
