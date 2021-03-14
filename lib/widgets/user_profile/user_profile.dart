import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String username;
  final bool isMe;
  final String userImage;
  UserProfile(this.username, this.isMe, this.userImage);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(userImage),
        ),
        Text(username),
      ],
    );
  }
}
