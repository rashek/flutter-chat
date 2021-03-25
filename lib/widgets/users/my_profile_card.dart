import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyProfileCard extends StatelessWidget {
  MyProfileCard(this.myName, this.myImage);
  final String myName;
  final String myImage;

  // Future<QuerySnapshot> _fetchuser() async {
  //   var a = await Firestore.instance
  //       .collection('user')
  //       .where('uid', isEqualTo: myid)
  //       .getDocuments();
  //   myInfo(
  //     a.documents[0]['username'],
  //     a.documents[0]['image_url'],
  //   );
  //   return a;
  // }

  @override
  Widget build(BuildContext context) {
    // return
    // FutureBuilder(
    //     future: _fetchuser(),
    //     builder: (ctx, userSnapshot) {
    //       if (userSnapshot.connectionState == ConnectionState.waiting) {
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //       final userDoc = userSnapshot.data.documents;
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
                backgroundImage: NetworkImage(myImage),
              ),
              Text(
                myName == null ? 'got null' : myName,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
    // });
  }
}
