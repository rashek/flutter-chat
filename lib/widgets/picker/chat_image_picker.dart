import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatImagePicker extends StatefulWidget {
  ChatImagePicker(this.imagePickerfn, this.imageClearfn);
  final void Function(File pickedImage) imagePickerfn;
  final void Function() imageClearfn;
  @override
  _ChatImagePickerState createState() => _ChatImagePickerState();
}

class _ChatImagePickerState extends State<ChatImagePicker> {
  File _pickedImage;
  void _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 200,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickerfn(_pickedImage);
  }

  void _pickImagFromCamera() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 200,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickerfn(_pickedImage);
  }

  void _clearImageFromDisplay() {
    _pickedImage = null;
    setState(() {});
    widget.imageClearfn();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (_pickedImage != null)
          GestureDetector(
            onTap: () {
              _clearImageFromDisplay();
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: FileImage(_pickedImage),
            ),
          ),
        IconButton(
          // textColor: Theme.of(context).primaryColor,
          onPressed: _pickImageFromGallery,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).primaryColor,
          ),
          // label: Text('Add Image'),
        ),
        IconButton(
          // textColor: Theme.of(context).primaryColor,
          onPressed: _pickImagFromCamera,
          icon: Icon(
            Icons.camera,
            color: Theme.of(context).primaryColor,
          ),
          // label: Text('Add Image'),
        ),
      ],
    );
  }
}
