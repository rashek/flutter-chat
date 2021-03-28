import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationCard extends StatelessWidget {
  final String peerId;
  final String peerName;
  final String peerImage;
  final String myId;
  final String myName;
  final String myImage;
  final bool isMe;
  NotificationCard(
    this.peerId,
    this.peerName,
    this.peerImage,
    this.myId,
    this.myName,
    this.myImage,
    this.isMe,
  );
  void _addToFriendlist(idVal1, idVal2, username, imageurl) async {
    await Firestore.instance
        .collection('user')
        .document(idVal1)
        .collection('friend_list')
        .document(idVal2)
        .setData({
      'uid': idVal2,
      'username': username,
      'image_url': imageurl,
    });
  }

  void _removeRequest() async {
    await Firestore.instance
        .collection('user')
        .document(myId)
        .collection('requests')
        .document(peerId)
        .delete();
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
                      backgroundImage: NetworkImage(peerImage),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        peerName,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          _addToFriendlist(myId, peerId, peerName, peerImage);
                          _addToFriendlist(peerId, myId, myName, myImage);
                          _removeRequest();
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _removeRequest();
                        }),
                  ],
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
