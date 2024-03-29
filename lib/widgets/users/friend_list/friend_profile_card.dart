import 'package:flutter/material.dart';

import 'package:chat/screens/chat_screen.dart';

class FriendCard extends StatelessWidget {
  final String peerId;
  final String peerName;
  final String perrImage;
  final String myId;
  final String myName;
  final String myImage;
  final bool isMe;
  FriendCard(
    this.peerId,
    this.peerName,
    this.perrImage,
    this.myId,
    this.myName,
    this.myImage,
    this.isMe,
  );

  @override
  Widget build(BuildContext context) {
    if (!isMe)
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: {
            'myId': myId,
            'my_name': myName,
            'my_image': myImage,
            'peerId': peerId,
            'peer_name': peerName,
            'peer_image': perrImage,
          });
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
                  backgroundImage: NetworkImage(perrImage),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    peerName,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

    return Padding(
      padding: const EdgeInsets.all(0.0),
    );
  }
}
