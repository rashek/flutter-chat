import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String peerId;
  final bool isMe;
  final String userImage;
  ProfileCard(this.username, this.isMe, this.userImage, this.peerId);

  @override
  Widget build(BuildContext context) {
    if (!isMe)
      return GestureDetector(
        onTap: () async {
          print(peerId);
          var user = await FirebaseAuth.instance.currentUser();
          var uid = user.uid;
          Firestore.instance
              .collection('user')
              .document(uid)
              .collection(peerId);
          Firestore.instance
              .collection('user')
              .document(peerId)
              .collection(uid);
        },
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(userImage),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      username,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
        ),
      );

    return Padding(
      padding: const EdgeInsets.all(0.0),
    );
  }
}
