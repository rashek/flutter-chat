import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';
import '../screens/profile_screen.dart';
// import '../widgets/users/profile.dart';

class ChatScreen extends StatelessWidget {
  static final routeName = '/chat_screen';
  String chatId;
  bool chatStatus = false;

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final peerId = routeArgs['peerId'];
    final myId = routeArgs['myId'];
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
        body: StreamBuilder(
            stream: Firestore.instance
                .collection('massage_data')
                .document(myId)
                .collection(peerId)
                .snapshots(),
            builder: (ctx, massageSnapshot) {
              if (massageSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: Text('loading..'),
                );
              }
              chatId = myId + peerId;
              if (massageSnapshot.data.documents.length != 0) {
                chatId = massageSnapshot.data.documents[0]['chat_id'];
                chatStatus = true;
              }
              return Container(
                child: Column(
                  children: [
                    Expanded(child: Messages(chatId, chatStatus)),
                    NewMessage(chatId, chatStatus),
                  ],
                ),
              );
            }
            // floatingActionButton: FloatingActionButton(onPressed: () {}),
            ));
  }
}
