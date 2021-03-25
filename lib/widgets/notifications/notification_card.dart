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
  void _requestAction(ignore) async {
    if (!ignore) {
      await Firestore.instance
          .collection('user')
          .document(myId)
          .collection('friend_list')
          .document(peerId)
          .setData({
        'uid': peerId,
        'username': peerName,
        'image_url': peerImage,
      });
    }

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
                          _requestAction(false);
                        }),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          _requestAction(false);
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
