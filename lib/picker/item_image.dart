import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemImagePicker extends StatefulWidget {
  const ItemImagePicker({super.key, required this.imagePickFn});
  final void Function(File pickedImage) imagePickFn;
  @override
  State<ItemImagePicker> createState() => _ItemImagePickerState();
}

class _ItemImagePickerState extends State<ItemImagePicker> {
  File _pickedImage = File('');
  void _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.pickImage(
      source: source,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
    widget.imagePickFn(_pickedImage);

    FirebaseStorage.instance
        .ref()
        .child('items_image/${DateTime.now().millisecondsSinceEpoch}.jpg');
    // .child('userId' + '.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.grey,
            image: _pickedImage != null
                ? DecorationImage(image: FileImage(_pickedImage))
                : null,
          ),
        ),

        // CircleAvatar(
        //     radius: 40,
        //     backgroundColor: Colors.grey,
        //     backgroundImage:
        //         _pickedImage != null ? FileImage(_pickedImage) : null),
        // : const AssetImage('assets/images/user.png'),
        ElevatedButton.icon(
          onPressed: () {
            showDialog(
              barrierColor: Colors.transparent,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text("Choose Profile Picture"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text("Pick from Gallery"),
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_camera),
                        title: const Text("Capture with Camera"),
                        onTap: () {
                          _pickImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.camera_alt),
          label: const Text("Pick Post Picture"),
        ),
      ],
    );
  }
}
