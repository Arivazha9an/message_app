import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});
  final void Function(File pickedImage) onPickImage;
  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedimageFile;

  void _pickimage() async {
    final pickedimage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    if (pickedimage == null) {
      return;
    }

    setState(() {
      _pickedimageFile = File(pickedimage.path);
    });
    widget.onPickImage(_pickedimageFile!);
  }

  @override
  Widget build(BuildContext context) {
    // throw UnimplementedError();
    return Column(
      children: [
        CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey,
            foregroundImage:
                _pickedimageFile != null ? FileImage(_pickedimageFile!) : null),
        TextButton.icon(
          onPressed: _pickimage,
          icon: const Icon(Icons.image),
          label: const Text(
            'Add Image',
            style: TextStyle(color: Colors.black),
          ),
        )
      ],
    );
  }
}
