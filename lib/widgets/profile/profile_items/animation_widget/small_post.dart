import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

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
            child: CachedNetworkImage(
              imageUrl: postImage,
              width: double.infinity,
              height: 200,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    // colorFilter:
                    //     ColorFilter.mode(Colors.red, BlendMode.colorBurn)
                  ),
                ),
              ),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(postDescription.length > 60
                ? postDescription.substring(0, 60) + '...'
                : postDescription),
          ),
        ],
      ),
    );
  }
}
