import 'package:flutter/material.dart';

class LargePost extends StatelessWidget {
  final String postCreator;
  final String postDescription;
  final String postImage;

  LargePost(this.postCreator, this.postDescription, this.postImage);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(postCreator),
      ),
      body: Card(
        child: Column(
          children: [
            Stack(
              children: [
                Image.network(
                  postImage,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 20,
                  right: 10,
                  child: Container(
                    // width: 300,
                    color: Colors.black54,
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 20,
                    ),
                    child: Text(
                      postCreator,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(postDescription),
            ),
          ],
        ),
      ),
    );
  }
}
