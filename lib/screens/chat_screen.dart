import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';
import '../screens/profile_screen.dart';
// import '../widgets/users/profile.dart';

class ChatScreen extends StatelessWidget {
  static final routeName = '/chat_screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final peerId = routeArgs['peerId'];
    final peerName = routeArgs['peer_name'];
    final peerImage = routeArgs['peer_image'];
    return Scaffold(
      appBar: AppBar(
          title: InkWell(
              child: Text(peerName),
              onTap: () {
                Navigator.of(context).pushNamed(
                  ProfileScreen.routeName,
                  arguments: {
                    'Id': peerId,
                    'name': peerName,
                    'image': peerImage,
                  },
                );
              })),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessage(),
          ],
        ),
      ),
    );
  }
}
