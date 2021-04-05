import 'package:chat/widgets/post_operation/add_post.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatelessWidget {
  final String id;
  AddPostScreen(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: AddPost(id),
    );
  }
}
