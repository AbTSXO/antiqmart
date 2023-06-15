import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.imagePickFn});
  final void Function(File pickedImage) imagePickFn;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
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
    final ref = FirebaseStorage.instance
        .ref()
        .child('user_image')
        .child('userId' + '.jpg');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage) : null
            // : const AssetImage('assets/images/user.png'),
            ),
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
        // TextButton.icon(
        //   onPressed: _pickImage,
        //   icon: const Icon(
        //     Icons.image,
        //     color: Colors.blue,
        //   ),
        //   label: const Text(
        //     'Add Image',
        //     style: TextStyle(color: Colors.blue),
        //   ),
        // ),
      ],
    );
  }
}
