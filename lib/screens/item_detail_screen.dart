// import 'package:chat_app_v2/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/items/item_card.dart';
import '../widgets/items/uploader.dart';
import '../widgets/search_field.dart';
import 'cart_screen.dart';

class ItemDetailScreen extends StatefulWidget {
  const ItemDetailScreen(
      {Key? key,
      // required this.userPhone,
      required this.userImage,
      required this.itemurl,
      required this.price,
      required this.description,
      required this.location,
      required this.itemName})
      : super(key: key);
  // final String userPhone;
  final String userImage;
  final String itemurl;
  final String price;
  final String description;
  final String location;
  final String itemName;
  @override
  State<ItemDetailScreen> createState() => _ItemDetailScreenState();
}

class _ItemDetailScreenState extends State<ItemDetailScreen> {
  bool showMore = false;

  void toggleShowMore() {
    setState(() {
      showMore = !showMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.itemName),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.itemurl),
                fit: BoxFit.cover,
              ),
            ),
            height: 270,
            width: double.infinity,
          ),
          // Padding(
          //   padding: const EdgeInsets.all(10),
          //   child: Text(
          //     description,
          //     style: const TextStyle(fontSize: 16),
          //   ),
          // ),

          Expanded(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(widget.userImage),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Seller',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  widget.location,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              '\$ ${widget.price}',
                              style: const TextStyle(
                                color: Color(0XFFc37e37),
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Icon(Icons.favorite_border),
                              SizedBox(width: 10),
                              Text(
                                'Save',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(width: 10),
                              Text(
                                'widget.userPhone',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.all(10),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: const [
                              Icon(Icons.chat),
                              SizedBox(width: 10),
                              Text(
                                'Chat with Seller',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Card(
                      //   margin: const EdgeInsets.all(10),
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(10),
                      //     child: Row(
                      //       children: const [
                      //         Icon(
                      //           Icons.report,
                      //         ),
                      //         SizedBox(width: 10),
                      //         Text(
                      //           'Report',
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.w700,
                      //             fontSize: 14,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),

                      if (showMore)
                        Text(
                          widget.description,
                          style: const TextStyle(fontSize: 16),
                        ),
                      TextButton(
                        onPressed: toggleShowMore,
                        child: Text(
                          showMore ? 'See Less' : 'See More',
                          style: const TextStyle(color: Color(0XFFc37e37)),
                        ),
                      ),
                      Row(children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, left: 16.0, right: 16.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:
                                      const Color(0XFFc37e37).withOpacity(0.3),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(20.0),
                                  child: Icon(
                                    Icons.shopping_cart,
                                    color: Color(0XFFc37e37),
                                  ),
                                ),
                              ),
                            )),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 16.0, right: 16.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CartView()),
                                  );
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color(0XFFc37e37),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(20.0),
                                      child: Text(
                                        'Buy Now',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ),
                            ))
                      ])
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}
