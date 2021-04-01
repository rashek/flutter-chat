import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../picker/post_image_picker.dart';

class AddPost extends StatefulWidget {
  final String Id;
  AddPost(this.Id);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _form = GlobalKey<FormState>();
  String description;
  File _postImageFile;

  void _pickedImage(File image) {
    _postImageFile = image;
  }

  void _onSubmit() async {
    if (_postImageFile == null || description.length == 0) {
      showAboutDialog(context: context, children: [Text('need an Image')]);
    }
    final ref = FirebaseStorage.instance
        .ref()
        .child('post_image')
        .child('.user.uid' + '.jpg');
    await ref.putFile(_postImageFile).onComplete;
    final url = await ref.getDownloadURL();
    await Firestore.instance
        .collection('user')
        .document(widget.Id)
        .collection('posts')
        .document()
        .setData({'post_description': description, 'post_img': url});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: ListView(
        children: [
          PostImagePicker(_pickedImage),
          TextFormField(
            // initialValue: _initValue['description'],
            decoration: InputDecoration(labelText: 'Description'),
            maxLines: 3,
            keyboardType: TextInputType.text,
            // focusNode: _descriptionFocusNode,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a value';
              }
              if (value.length < 10) {
                return 'Please enter at least 10 charecter';
              }
              return null;
            },
            onSaved: (value) {
              description = value;
            },
          ),
          ElevatedButton(
            child: Text('Post'),
            onPressed: _onSubmit,
          ),
        ],
      ),
    );
  }
}
