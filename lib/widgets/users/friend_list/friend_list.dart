import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../my_profile_card.dart';
import 'friend_profile_card.dart';

class FriendList extends StatelessWidget {
  Future<QuerySnapshot> _fetchAllFriends(myuid) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(myuid)
        .collection('friend_list')
        .orderBy('username', descending: false)
        .get();
    return querySnapshot;
  }

  Future<QuerySnapshot> _fetchMyInfo(myId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('user')
        .where('uid', isEqualTo: myId)
        .get();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([
          _fetchMyInfo(FirebaseAuth.instance.currentUser.uid),
          _fetchAllFriends(FirebaseAuth.instance.currentUser.uid)
        ]),
        builder: (ctx, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.all(0),
            );
          }
          final myName = snapshot.data[0].docs[0]['username'];
          final myImage = snapshot.data[0].docs[0]['image_url'];
          final userDoc = snapshot.data[1].docs;
          final myuid = FirebaseAuth.instance.currentUser.uid;

          return SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                MyProfileCard(myuid, myName, myImage),
                Container(
                  child: ListView.builder(
                    itemCount: userDoc.length,
                    itemBuilder: (ctx, index) => FriendCard(
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
              ],
            ),
          );
        });
  }
}
