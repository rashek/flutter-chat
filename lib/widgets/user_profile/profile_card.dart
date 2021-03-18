import 'package:flutter/material.dart';

import 'package:chat/screens/chat_screen.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final String myName;
  final String myImage;
  final bool isMe;
  final String userImage;
  final String myId;
  final String peerId;
  ProfileCard(
    this.username,
    this.myName,
    this.myImage,
    this.isMe,
    this.userImage,
    this.myId,
    this.peerId,
  );

  @override
  Widget build(BuildContext context) {
    if (!isMe)
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ChatScreen.routeName, arguments: {
            'myId': myId,
            'peerId': peerId,
            'username': username,
            'my_name': myName,
            'my_image': myImage,
            'peer_name': username,
            'peer_image': userImage,
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
                    backgroundImage: NetworkImage(userImage),
<<<<<<< HEAD
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      username,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
=======
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(
                      username,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
>>>>>>> befa80abe6123eb7d54a508b90732c65ae3db12d
                ],
              )),
        ),
      );

    return Padding(
      padding: const EdgeInsets.all(0.0),
    );
  }
}
