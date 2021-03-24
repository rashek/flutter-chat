import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import './my_profile_card.dart';
import 'user_profile_card.dart';

class AllUserList extends StatelessWidget {
  Future<QuerySnapshot> _fetchAlluser() async {
    final ab = await Firestore.instance
        .collection('user')
        .orderBy('username', descending: false)
        .getDocuments();
    return ab;
  }

  Future<QuerySnapshot> _fetchMyInfo(myId) async {
    final ab = await Firestore.instance
        .collection('user')
        .where('uid', isEqualTo: myId)
        .getDocuments();
    return ab;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          final myuid = futureSnapshot.data.uid;
          return FutureBuilder(
              future: _fetchMyInfo(myuid),
              builder: (ctx, mySnapshot) {
                if (mySnapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final myName = mySnapshot.data.documents[0]['username'];
                final myImage = mySnapshot.data.documents[0]['image_url'];
                return FutureBuilder(
                    future: _fetchAlluser(),
                    builder: (ctx, userSnapshot) {
                      if (userSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final userDoc = userSnapshot.data.documents;
                      return SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          children: [
                            Container(
                              child: ListView.builder(
                                itemCount: userDoc.length,
                                itemBuilder: (ctx, index) => UserCard(
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
        });
  }
}
