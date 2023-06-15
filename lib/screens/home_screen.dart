// import 'package:chat_app_v2/widgets/chat/new_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/items/item_card.dart';
import '../widgets/items/uploader.dart';
import '../widgets/search_field.dart';
import 'categories.dart';
import 'cart_screen.dart';

//  db.collection("chats").snapshots().listen((event) {
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String id = 'chat_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _firestore = FirebaseFirestore.instance;
  final db = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection('chats').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'AntiqMart',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartView(),
                  ),
                );
              },
              icon: const Icon(Icons.shopping_cart)),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('Logout'),
              ),
              const PopupMenuItem<String>(
                value: 'settings',
                child: Text('Settings'),
              ),
              // Add more PopupMenuItems as needed
            ],
            onSelected: (String value) {
              if (value == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
            child: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            SearchField(),
            CategoriesList(),
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Popular Product',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ItemStream(),
            //  NewMessage()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Uploader(),
            ),
          );
          // showModalBottomSheet(
          //     context: context,
          //     builder: (BuildContext context) {
          //       return Expanded(child: const Uploader());
          //     });
        },
      ),
    );
  }
}
