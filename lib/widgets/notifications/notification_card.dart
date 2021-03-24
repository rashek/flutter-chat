import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String username;
  final String myName;
  final String myImage;
  final bool isMe;
  final String userImage;
  final String myId;
  final String peerId;
  NotificationCard(
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
                Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {}),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {}),
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
