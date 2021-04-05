import 'package:chat/widgets/post_operation/add_post.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  final String id;
  final String name;
  AddPostScreen(this.id, this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: AddPost(id, name),
    );
  }
}
