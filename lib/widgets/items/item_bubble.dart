import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../screens/item_detail_screen.dart';
import 'package:intl/intl.dart';

class ItemBubble extends StatefulWidget {
  const ItemBubble({
    Key? key,
    // required this.userPhone,
    required this.description,
    required this.price,
    required this.itemurl,
    required this.userImage,
    required this.time,
    required this.itemName,
    required this.location,
  }) : super(key: key);
  // final String userPhone;
  final String userImage;
  final String itemurl;
  final String price;
  final String itemName;
  final Timestamp time;
  final String description;
  final String location;

  @override
  State<ItemBubble> createState() => _ItemBubbleState();
}

class _ItemBubbleState extends State<ItemBubble> {
  bool showMore = false;

  void toggleShowMore() {
    setState(() {
      showMore = !showMore;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12),
                  ),
                ),
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ItemDetailScreen(
                                  // userPhone: widget.userPhone,
                                  userImage: widget.userImage,
                                  itemurl: widget.itemurl,
                                  price: widget.price,
                                  description: widget.description,
                                  itemName: widget.itemName,
                                  location: widget.location,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(widget.itemurl),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            height: 270,
                            width: double.infinity,
                          ),
                        ),
                        Positioned(
                            bottom: 20,
                            left: 20,
                            child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.userImage))),
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade800,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.sell_outlined,
                                  color: Colors.white,
                                  size: 14,
                                ),
                                Text(
                                  '${widget.price} ETB',
                                  style: const TextStyle(
                                    color: Color(0XFFc37e37),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.itemName,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.location,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Spacer(),

                        Text(
                          DateFormat('dd-MM-yy').format(widget.time.toDate()),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),

                        // PopupMenuButton<String>(
                        //   itemBuilder: (BuildContext context) =>
                        //       <PopupMenuEntry<String>>[
                        //     PopupMenuItem<String>(
                        //       value: 'option1',
                        //       child: Text(
                        //         description,
                        //         style: const TextStyle(
                        //           color: Colors.grey,
                        //           fontSize: 16,
                        //         ),
                        //         textAlign: TextAlign.start,
                        //       ),
                        //     ),
                        //     // Add more PopupMenuItems as needed
                        //   ],
                        //   child: const Icon(Icons.more_vert),
                        // ),
                      ],
                    ),
                    if (showMore)
                      Text(
                        widget.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                    TextButton(
                      onPressed: toggleShowMore,
                      child: Icon(
                        showMore
                            ? Icons.arrow_circle_up_outlined
                            : Icons.arrow_circle_down_outlined,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
