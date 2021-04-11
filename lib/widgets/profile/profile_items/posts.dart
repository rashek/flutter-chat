import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'post_animation.dart';

class Posts extends StatelessWidget {
  final String Id;
  Posts(this.Id);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(Id)
            .collection('posts')
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final postData = snapshot.data.docs;
          if (postData.length == 0)
            return Center(
              child: Text('You have no post available'),
            );
          return Container(
            child: ListView.builder(
                itemCount: postData.length,
                itemBuilder: (ctx, index) => PostAnimation(
                      postData[index]['post_creator'],
                      postData[index]['post_description'],
                      postData[index]['post_img'],
                    )),
          );
        });
  }
}
