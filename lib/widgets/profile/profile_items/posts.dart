import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './post.dart';

class Posts extends StatelessWidget {
  final String Id;
  Posts(this.Id);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firestore.instance
            .collection('user')
            .document(Id)
            .collection('posts')
            .getDocuments(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final postData = snapshot.data.documents;
          print(postData.length);
          return Container(
            child: ListView.builder(
                itemCount: postData.length,
                itemBuilder: (ctx, index) => Post(
                      postData[index]['post_description'],
                      postData[index]['post_img'],
                    )),
          );
        });
  }
}
