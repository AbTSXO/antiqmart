import 'package:flutter/material.dart';

import 'cart_screen.dart';

// class AddToCartButton extends StatefulWidget {
//   final Product product;
//   final VoidCallback onAddedToCart;

//   const AddToCartButton({
//     required this.product,
//     required this.onAddedToCart,
//   });

//   @override
//   _AddToCartButtonState createState() => _AddToCartButtonState();
// }

// class _AddToCartButtonState extends State<AddToCartButton> {
//   int quantity = 1;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         IconButton(
//           icon: Icon(Icons.remove),
//           onPressed: () {
//             if (quantity > 1) {
//               setState(() {
//                 quantity--;
//               });
//             }
//           },
//         ),
//         Text(quantity.toString()),
//         IconButton(
//           icon: Icon(Icons.add),
//           onPressed: () {
//             setState(() {
//               quantity++;
//             });
//           },
//         ),
//         IconButton(
//           icon: Icon(Icons.add_shopping_cart),
//           onPressed: () {
//             for (var i = 0; i < quantity; i++) {
//               widget.onAddedToCart();
//               widget.product.quantity++;
//             }
//           },
//         ),
//       ],
//     );
//   }
// }
