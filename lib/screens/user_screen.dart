import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/user_profile/user_profile.dart';

class UserScreen extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('dasd'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'Logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'Logout') {
                FirebaseAuth.instance.signOut();
                googleSignIn.disconnect();
                googleSignIn.signOut();
              }
            },
          ),
        ],
      ),
      body: FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder: (ctx, futureSnapshot) {
            if (futureSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            return StreamBuilder(
                stream: Firestore.instance
                    .collection('user')
                    // .orderBy('username')
                    .snapshots(),
                builder: (ctx, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final userDoc = userSnapshot.data.documents;
                  return ListView.builder(
                    // reverse: true,
                    itemCount: userDoc.length,
                    itemBuilder: (ctx, index) => UserProfile(
                      userDoc[index]['username'],
                      userDoc[index]['uid'] == futureSnapshot.data.uid,
                      userDoc[index]['image_url'],
                    ),
                  );
                });
          }),
    );
  }
}
