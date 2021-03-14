import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String username;
  final bool isMe;
  final String userImage;
  UserProfile(this.username, this.isMe, this.userImage);

  @override
  Widget build(BuildContext context) {
    if (!isMe)
      return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(userImage),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  username,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ));
    return Padding(
      padding: const EdgeInsets.all(0.0),
      // child: Row(
      //   children: [],
      // )
    );
  }
}
