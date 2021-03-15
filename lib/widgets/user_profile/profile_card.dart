import 'package:chat/screens/chat_screen.dart';
import 'package:chat/widgets/chat/messages.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  final String username;
  final bool isMe;
  final String userImage;
  ProfileCard(this.username, this.isMe, this.userImage);

  @override
  Widget build(BuildContext context) {
    if (!isMe)
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ChatScreen.routeName);
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
