import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostImagePicker extends StatefulWidget {
  PostImagePicker(this.imagePickerfn);
  final void Function(File pickedImage) imagePickerfn;
  @override
  _PostImagePickerState createState() => _PostImagePickerState();
}

class _PostImagePickerState extends State<PostImagePicker> {
  File _pickedImage;
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImageFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickerfn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: _pickedImage != null ? Image.file(_pickedImage) : null,
        ),
        // CircleAvatar(
        //   radius: 40,
        //   backgroundImage:
        //       _pickedImage != null ? FileImage(_pickedImage) : null,
        // ),
        FlatButton.icon(
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
