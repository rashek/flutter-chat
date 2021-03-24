import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import './my_profile_card.dart';
import 'user_profile_card.dart';

class AllUserList extends StatefulWidget {
  @override
  _AllUserListState createState() => _AllUserListState();
}

class _AllUserListState extends State<AllUserList> {
  String myName;
  bool a = true;
  String myImage;

  Future<QuerySnapshot> _fetchAlluser() async {
    final ab = await Firestore.instance
        .collection('user')
        .orderBy('username', descending: false)
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
          return FutureBuilder(
              future: _fetchAlluser(),
              builder: (ctx, userSnapshot) {
                if (userSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final userDoc = userSnapshot.data.documents;
                final myuid = futureSnapshot.data.uid;
                return SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      // MyProfileCard(myuid, _fetchMyInfo),
                      Container(
                        child: ListView.builder(
                          itemCount: userDoc.length,
                          itemBuilder: (ctx, index) => UserProfileCard(
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
