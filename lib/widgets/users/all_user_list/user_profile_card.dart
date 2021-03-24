import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:chat/screens/chat_screen.dart';

class UserCard extends StatelessWidget {
  final String userId;
  final String username;
  final String userImage;
  final String myId;
  final String myName;
  final String myImage;
  final bool isMe;
  UserCard(
    this.userId,
    this.username,
    this.userImage,
    this.myId,
    this.myName,
    this.myImage,
    this.isMe,
  );
  void _sendRequest() async {
    await Firestore.instance
        .collection('user')
        .document(userId)
        .collection('requests')
        .document(myId)
        .setData({'uid': myId});
  }

  @override
  Widget build(BuildContext context) {
    if (!isMe)
      return Card(
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 5,
        ),
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(userImage),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        username,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                OutlinedButton(
                  onPressed: _sendRequest,
                  child: Text('Add +'),
                )
              ],
            )),
        // ),
      );

    return Padding(
      padding: const EdgeInsets.all(0.0),
    );
  }
}
