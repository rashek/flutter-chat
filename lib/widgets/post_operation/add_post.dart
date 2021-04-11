import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../picker/post_image_picker.dart';

class AddPost extends StatefulWidget {
  final String Id;
  final String name;
  AddPost(this.Id, this.name);
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final _form = GlobalKey<FormState>();
  String description = '';
  File _postImageFile;

  void _pickedImage(File image) {
    _postImageFile = image;
  }

  void _onSubmit() async {
    _form.currentState.save();
    if (_postImageFile == null || description.isEmpty == true) {
      showDialog(
          context: context,
          builder: (ctx) {
            return Dialog(
              child: Container(
                height: 200,
                child: Center(
                    child: Text(
                  _postImageFile == null
                      ? 'Please Insert an Image'
                      : 'Please Add A Description',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
            );
          });
      return;
    }
    showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 24.0,
          title: Text(
            'Are you sure',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  'Press ok to continue or cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              ),
              onPressed: () async {
                final ref = FirebaseStorage.instance
                    .ref()
                    .child('post_image')
                    .child(widget.name + widget.Id)
                    .child(DateTime.now().toString() + '.jpg');
                await ref.putFile(_postImageFile);
                final url = await ref.getDownloadURL();
                await FirebaseFirestore.instance
                    .collection('user')
                    .doc(widget.Id)
                    .collection('posts')
                    .doc()
                    .set({
                  'post_creator': widget.name,
                  'post_description': description,
                  'post_img': url
                });
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      child: Column(
        children: [
          PostImagePicker(_pickedImage),
          TextFormField(
            key: ValueKey('description'),
            // validator: (value) {
            //   if (value.isEmpty || value.length < 4) {
            //     return 'User name must be 4 charecters atleast.';
            //   }
            //   return null;
            // },
            decoration: InputDecoration(labelText: 'description'),
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
