import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyProfile extends StatelessWidget {
  MyProfile(this.myid);
  final String myid;

  Future<QuerySnapshot> _fetchuser() async {
    var a = await Firestore.instance
        .collection('user')
        .where('uid', isEqualTo: myid)
        .getDocuments();
    return a;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchuser(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final userDoc = userSnapshot.data.documents;
          // print(userDoc.length);
          return Container(
            // height: 100,
            padding: EdgeInsets.only(top: 8),
            width: 200,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(userDoc[0]['image_url']),
                    ),
                    Text(
                      userDoc[0]['username'] == null
                          ? 'got null'
                          : userDoc[0]['username'],
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
