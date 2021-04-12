import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import './my_profile_card.dart';
import 'notification_card.dart';

class NotificationList extends StatelessWidget {
  Future<QuerySnapshot> _fetchMyInfo(myId) async {
    final ab = await FirebaseFirestore.instance
        .collection('user')
        .where('uid', isEqualTo: myId)
        .get();
    return ab;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _fetchMyInfo(FirebaseAuth.instance.currentUser.uid),
        builder: (ctx, mySnapshot) {
          if (mySnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final myName = mySnapshot.data.docs[0]['username'];
          final myImage = mySnapshot.data.docs[0]['image_url'];
          final myuid = FirebaseAuth.instance.currentUser.uid;
          return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('user')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection('requests')
                  .snapshots(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final userDoc = userSnapshot.data.docs;
                if (userDoc.length == 0)
                  return Center(child: Text("No Notification"));
                return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // MyProfileCard(myuid, _fetchMyInfo),
                      Container(
                        child: ListView.builder(
                          itemCount: userDoc.length,
                          itemBuilder: (ctx, index) => NotificationCard(
                            userDoc[index]['uid'],
                            userDoc[index]['username'],
                            userDoc[index]['image_url'],
                            myuid,
                            myName,
                            myImage,
                            userDoc[index]['uid'] == myuid,
                          ),
                          shrinkWrap: true,
                        ),
                      ),
                      // Text(mySnapshot.data.documents[0]['username'])
                    ],
                  ),
                );
              });
        });
  }
}
