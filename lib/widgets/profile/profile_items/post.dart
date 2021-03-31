import 'package:flutter/material.dart';

class Post extends StatelessWidget {
  final String postDescription;
  final String postImage;

  const Post(this.postDescription, this.postImage);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        Image(image: NetworkImage(postImage)),
        Text(postDescription),
      ],
    ));
  }
}
