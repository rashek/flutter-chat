import 'package:flutter/material.dart';

class SmallPost extends StatelessWidget {
  final String postCreator;
  final String postDescription;
  final String postImage;

  SmallPost(this.postCreator, this.postDescription, this.postImage);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.network(
              postImage,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(postDescription.substring(0, 60) + '...'),
          ),
        ],
      ),
    );
  }
}
