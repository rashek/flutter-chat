import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'user_profile_card.dart';

class AllUserList extends StatelessWidget {
  Future<QuerySnapshot> _fetchAlluser() async {
    final querySnapshot = await Firestore.instance
        .collection('user')
        .orderBy('username', descending: false)
        .getDocuments();
    return querySnapshot;
  }

  Future<QuerySnapshot> _fetchMyInfo(myId) async {
    final querySnapshot = await Firestore.instance
        .collection('user')
        .where('uid', isEqualTo: myId)
        .getDocuments();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final myuid = futureSnapshot.data.uid;
          return FutureBuilder(
              future: Future.wait([_fetchMyInfo(myuid), _fetchAlluser()]),
              builder: (ctx, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.all(0),
                  );
                }
                final myName = snapshot.data[0].documents[0]['username'];
                final myImage = snapshot.data[0].documents[0]['image_url'];
                final userDoc = snapshot.data[1].documents;
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
                    ],
                  ),
                );
              });
        });
  }
}
