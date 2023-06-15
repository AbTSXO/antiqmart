import 'package:flutter/material.dart';
import 'dart:io';
import '../../picker/item_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../screens/home_screen.dart';

class ImageUploader extends StatefulWidget {
  const ImageUploader({super.key, required this.submitFun});

  final void Function(String itemName, String location, String description,
      String price, BuildContext context, File image) submitFun;
  @override
  State<ImageUploader> createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
  final _formKey = GlobalKey<FormState>();

  String _location = '';
  String _itemName = '';
  String _description = '';
  String _price = '';
  File _itemurl = File('');
  void _pickedImage(File image) {
    _itemurl = image;
  }

  Future<void> _postItem() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_itemurl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState!.save();
      widget.submitFun(
          _location, _itemName, _description, _price, context, _itemurl);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('The antique furniture item has been posted.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
    //
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              key: _formKey,
              child: Column(
                // mainAxisAlignment: MainAxisSize.min,
                children: [
                  // if (!_isLogin)
                  ItemImagePicker(
                    imagePickFn: _pickedImage,
                  ),
                  TextFormField(
                    autocorrect: true,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: true,
                    decoration:
                        const InputDecoration(labelText: 'Name of the item'),
                    key: const ValueKey('item'),
                    validator: (value) {
                      if (value!.isEmpty || value.length > 25) {
                        return 'Please enter at least 25 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _itemName = value!;
                    },
                  ),
                  TextFormField(
                    autocorrect: true,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: true,
                    decoration:
                        const InputDecoration(labelText: 'city, country'),
                    key: const ValueKey('location'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your location.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _location = value!;
                    },
                  ),
                  TextFormField(
                    autocorrect: true,
                    textCapitalization: TextCapitalization.none,
                    enableSuggestions: true,
                    decoration: InputDecoration(labelText: 'Description'),
                    key: const ValueKey('description'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a description.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Price'),
                    key: const ValueKey('price'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a price.';
                      }
                      if (int.tryParse(value) == null) {
                        return 'Please enter a valid price.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _price = int.parse(value!).toString();
                    },
                  ),

                  const SizedBox(
                    height: 12,
                  ),

                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _postItem();
                          // Navigator.pop(context);
                        },
                        child: const Text('Post Item'),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  )
                ],
              )),
        )),
      ),
    );
  }
}

class Uploader extends StatefulWidget {
  const Uploader({super.key});
  static String id = 'auth_screen';

  @override
  State<Uploader> createState() => _UploaderState();
}

class _UploaderState extends State<Uploader> {
  final user = FirebaseAuth.instance.currentUser;
  final messageTextController = TextEditingController();
  void _submitAuthForm(String location, String itemName, String description,
      String price, BuildContext context, File image) async {
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    final ref = FirebaseStorage.instance
        .ref()
        .child('items_image/${DateTime.now().millisecondsSinceEpoch}.jpg');

    // .child('items_image')
    // .child('${user.uid}.jpg');
    await ref.putFile(image);

    final url = await ref.getDownloadURL();

    await FirebaseFirestore.instance.collection('items').add({
      'location': location,
      'itemName': itemName,
      'createdAt': Timestamp.now(),
      'description': description,
      'price': price,
      'item_url': url,
      'userId': user.uid,
      'username': userData['username'],
      'userImage': userData['image_url'],
    });
    // }
    // } on PlatformException catch (err) {
    //   var message = 'An error occurred, please check your credentials!';

    //   if (err.message != null) {
    //     message = err.message!;
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text(message),
    //       backgroundColor: Colors.red,
    //     ));
    //   }
    //   setState(() {
    //     _isloading = false;
    //   });
    // } catch (err) {
    //   print(err);
    //   setState(() {
    //     _isloading = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ImageUploader(
      submitFun: _submitAuthForm,
      // isLoading: _isloading,
    ));
  }
}
