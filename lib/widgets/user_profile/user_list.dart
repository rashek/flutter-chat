import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './my_profile.dart';
import './profile_card.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('user')
                  .orderBy('username', descending: false)
                  .snapshots(),
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
                      MyProfile(myuid),
                      Container(
                        child: ListView.builder(
                          itemCount: userDoc.length,
                          itemBuilder: (ctx, index) => ProfileCard(
                            userDoc[index]['username'],
                            userDoc[index]['uid'] == myuid,
                            userDoc[index]['image_url'],
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
