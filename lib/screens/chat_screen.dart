import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  static final routeName = '/chat_screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final myId = routeArgs['myId'];
    final peerId = routeArgs['peerId'];
    final username = routeArgs['username'];
    final myName = routeArgs['my_name'];
    final myImage = routeArgs['my_image'];
    final peerName = routeArgs['peer_name'];
    final peerImage = routeArgs['peer_image'];
    // print(username);
    // print(peerId);
    return Scaffold(
      appBar: AppBar(title: Text(username)),
      body: Container(
        child: Column(
          children: [
            Expanded(
                child: Messages(
              myId,
              peerId,
              myName,
              myImage,
              peerName,
              peerImage,
            )),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
