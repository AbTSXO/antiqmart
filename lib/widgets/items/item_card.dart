import '/widgets/items/item_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ItemStream extends StatelessWidget {
  const ItemStream({super.key});
  Future<User?> _getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: _getCurrentUser(),
        builder: (BuildContext context, AsyncSnapshot<User?> futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return StreamBuilder<QuerySnapshot<Object?>>(
            stream: FirebaseFirestore.instance
                .collection('items')
                .orderBy('createdAt', descending: false)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> itemsnapshot) {
              if (itemsnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (itemsnapshot.data == null) {
                return Text('No data available'); // Or any other fallback UI
              }

              final itemdocs = itemsnapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                    reverse: false,
                    itemCount: itemdocs.length,
                    itemBuilder: (context, index) {
                      return ItemBubble(
                          itemName: itemdocs[index]['itemName'],
                          description: itemdocs[index]['description'],
                          price: itemdocs[index]['price'],
                          itemurl: itemdocs[index]['item_url'],
                          key: ValueKey(itemdocs[index].id),
                          userImage: itemdocs[index]['userImage'],
                          // userPhone: itemdocs[index]['userPhone'],
                          time: itemdocs[index]['createdAt'],
                          location: itemdocs[index]['location']);
                    }),
              );
            },
          );
          // }
        });
    // 2
  }
}
