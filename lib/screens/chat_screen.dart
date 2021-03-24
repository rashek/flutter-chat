import 'package:chat/screens/PeerProfile.dart';
import 'package:flutter/material.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  static final routeName = '/chat_screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final peerName = routeArgs['peer_name'];
    final peerImage = routeArgs['peer_image'];
    return Scaffold(
      appBar: AppBar(
        title: Text(peerName),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 30,
            ),
            child: PopupMenuButton(
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.account_circle_outlined,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: Text('Profile')),
                    ],
                  ),
                  value: 'peerProfile',
                )
              ],
              child: Icon(
                Icons.more_vert,
                size: 35,
              ),
              onSelected: (value) {
                if (value == 'peerProfile') {
                  Navigator.of(context)
                      .pushNamed(PeerProfile.routeName, arguments: {
                    'peer_name': peerName,
                    'peer_image': peerImage,
                  });
                }
              },
            ),
          ),
        ],
      ),
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
