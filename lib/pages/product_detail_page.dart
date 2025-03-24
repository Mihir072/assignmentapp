// import 'package:assingmentapp/models/product_model.dart';
// import 'package:assingmentapp/util/colors.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class ProductDetailPage extends StatefulWidget {
//  final Product product;
//   final Function(Product) addToCart;
//   const ProductDetailPage(
//       {super.key, required this.product, required this.addToCart});

//   @override
//   ProductDetailPageState createState() => ProductDetailPageState();
// }

// class ProductDetailPageState extends State<ProductDetailPage> {
//   void _addToCart() {
//     widget.addToCart(widget.product);
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(
//           "🎉 ${widget.product.title} added to cart!",
//           style: GoogleFonts.josefinSans(color: Colors.black, fontSize: 16),
//         ),
//         backgroundColor: Colors.white,
//         behavior: SnackBarBehavior.floating,
//         elevation: 8,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         margin: EdgeInsets.all(16),
//         action: SnackBarAction(
//           label: 'Undo',
//           textColor: Colors.pinkAccent,
//           onPressed: () {},
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Item Details",
//           style: GoogleFonts.josefinSans(
//               fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: mainColor,
//         centerTitle: true,
//         leading: IconButton(
//           icon:
//               Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(15),
//                 child: Image.network(
//                   widget.product.thumbnail,
//                   height: 250,
//                   width: double.infinity,
//                   fit: BoxFit.fill,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 widget.product.title,
//                 style: GoogleFonts.josefinSans(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 widget.product.description,
//                 style: GoogleFonts.josefinSans(
//                     fontSize: 16, color: Colors.grey[700]),
//               ),
//               const SizedBox(height: 5),
//               SizedBox(
//                 height: 0.2,
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.black),
//                 ),
//               ),
//               const SizedBox(height: 15),
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.shade100,
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Text(
//                   "Return Policy: ${widget.product.returnPolicy}",
//                   style:
//                       GoogleFonts.josefinSans(color: Colors.blue, fontSize: 16),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Text(
//                 "Product Details",
//                 style: GoogleFonts.josefinSans(
//                     fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               Text("Brand: ${widget.product.brand}",
//                   style: GoogleFonts.josefinSans(fontSize: 16)),
//               Text("Stock: ${widget.product.stock}",
//                   style: GoogleFonts.josefinSans(fontSize: 16)),
//               Text("SKU: ${widget.product.sku}",
//                   style: GoogleFonts.josefinSans(fontSize: 16)),
//               Text("Weight: ${widget.product.weight}g",
//                   style: GoogleFonts.josefinSans(fontSize: 16)),
//              Text(
//   "Dimensions: ${widget.product.dimensions.width} x ${widget.product.dimensions.height} x ${widget.product.dimensions.depth} cm",
// ),

//                   style: GoogleFonts.josefinSans(fontSize: 16)),
//               Text("Warranty: ${widget.product['warrantyInformation']}",
//                   style: GoogleFonts.josefinSans(fontSize: 16)),
//               Text("Shipping: ${widget.product['shippingInformation']}",
//                   style: GoogleFonts.josefinSans(fontSize: 16)),
//               Text("Availability: ${widget.product['availabilityStatus']}",
//                   style: GoogleFonts.josefinSans(fontSize: 16)),
//               const SizedBox(height: 15),
//               Center(
//                 child: Image.network(
//                   widget.product['meta']?['qrCode'] ??
//                       "https://via.placeholder.com/150",
//                   errorBuilder: (context, error, stackTrace) {
//                     return Text(
//                       "QR Code not available!",
//                       style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.red),
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 15),
//               SizedBox(
//                 height: 0.2,
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.black),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 "Reviews",
//                 style: GoogleFonts.josefinSans(
//                     fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               ...List.generate(widget.product['reviews'].length, (index) {
//                 final review = widget.product['reviews'][index];
//                 return Card(
//                   elevation: 3,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   margin: const EdgeInsets.symmetric(vertical: 8),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.pinkAccent,
//                       child: Text(
//                         review['reviewerName'][0],
//                         style: GoogleFonts.josefinSans(color: Colors.white),
//                       ),
//                     ),
//                     title: Text(
//                       review['reviewerName'],
//                       style:
//                           GoogleFonts.josefinSans(fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(review['comment'],
//                         style: GoogleFonts.josefinSans()),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(Icons.star, color: Colors.amber),
//                         Text(" ${review['rating']}",
//                             style: GoogleFonts.josefinSans()),
//                       ],
//                     ),
//                   ),
//                 );
//               }),
//               const SizedBox(height: 20),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: mainColor,
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                   ),
//                   onPressed: _addToCart,
//                   child: Text("Buy Now",
//                       style: GoogleFonts.josefinSans(
//                           fontSize: 18, color: Colors.white)),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:assingmentapp/bloc/cart_bloc.dart';
import 'package:assingmentapp/bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product_model.dart';
import '../util/colors.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;
  const ProductDetailPage(
      {super.key,
      required this.product,
      required Null Function(dynamic product) addToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Details",
            style: GoogleFonts.josefinSans(
                fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: mainColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                product.thumbnail,
                height: 250,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 16),
            Text(product.title,
                style: GoogleFonts.josefinSans(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(product.description,
                style:
                    GoogleFonts.josefinSans(fontSize: 16, color: Colors.grey)),
            const SizedBox(height: 5),
            Divider(color: Colors.black),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text("Return Policy: ${product.returnPolicy}",
                  style: GoogleFonts.josefinSans(
                      color: Colors.blue, fontSize: 16)),
            ),
            const SizedBox(height: 20),
            Text("Product Details",
                style: GoogleFonts.josefinSans(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text("Brand: ${product.brand}",
                style: GoogleFonts.josefinSans(fontSize: 16)),
            Text("Stock: ${product.stock}",
                style: GoogleFonts.josefinSans(fontSize: 16)),
            Text("SKU: ${product.sku}",
                style: GoogleFonts.josefinSans(fontSize: 16)),
            Text("Weight: ${product.weight}g",
                style: GoogleFonts.josefinSans(fontSize: 16)),
            Text(
                "Dimensions: ${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth} cm",
                style: GoogleFonts.josefinSans(fontSize: 16)),
            Text("Warranty: ${product.warrantyInformation}",
                style: GoogleFonts.josefinSans(fontSize: 16)),
            Text("Shipping: ${product.shippingInformation}",
                style: GoogleFonts.josefinSans(fontSize: 16)),
            Text("Availability: ${product.availabilityStatus}",
                style: GoogleFonts.josefinSans(fontSize: 16)),
            const SizedBox(height: 15),
            Center(
              child: Image.network(
                product.meta.qrCode,
                errorBuilder: (context, error, stackTrace) {
                  return Text("QR Code not available!",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red));
                },
              ),
            ),
            const SizedBox(height: 15),
            Divider(color: Colors.black),
            const SizedBox(height: 10),
            Text("Reviews",
                style: GoogleFonts.josefinSans(
                    fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...product.reviews.map((review) {
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.pinkAccent,
                    child: Text(review.reviewerName[0],
                        style: GoogleFonts.josefinSans(color: Colors.white)),
                  ),
                  title: Text(review.reviewerName,
                      style:
                          GoogleFonts.josefinSans(fontWeight: FontWeight.bold)),
                  subtitle:
                      Text(review.comment, style: GoogleFonts.josefinSans()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.star, color: Colors.amber),
                      Text(" ${review.rating}",
                          style: GoogleFonts.josefinSans()),
                    ],
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () {
                      context.read<CartBloc>().add(AddToCart(product));
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "🎉 ${product.title} added to cart!",
                            style: GoogleFonts.josefinSans(
                                color: Colors.black, fontSize: 16),
                          ),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          margin: EdgeInsets.all(16),
                          action: SnackBarAction(
                            label: 'Undo',
                            textColor: Colors.pinkAccent,
                            onPressed: () {},
                          ),
                        ),
                      );
                    },
                    child: Text("Buy Now",
                        style: GoogleFonts.josefinSans(
                            fontSize: 18, color: Colors.white)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
