// import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './my_profile.dart';
import './profile_card.dart';

class UserList extends StatefulWidget {
  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> {
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

  _fetchMyInfo(String value1, String value2) {
    if (a) {
      setState(() {
        myName = value1;
        myImage = value2;
        a = false;
      });
    }
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
                      MyProfile(myuid, _fetchMyInfo),
                      Container(
                        child: ListView.builder(
                          itemCount: userDoc.length,
                          itemBuilder: (ctx, index) => ProfileCard(
                            userDoc[index]['username'],
                            myName,
                            myImage,
                            userDoc[index]['uid'] == myuid,
                            userDoc[index]['image_url'],
                            myuid,
                            userDoc[index]['uid'],
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
