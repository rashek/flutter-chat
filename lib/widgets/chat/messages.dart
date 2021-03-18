import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final myId = routeArgs['myId'];
    final myName = routeArgs['my_name'];
    final myImage = routeArgs['my_image'];
    final peerId = routeArgs['peerId'];
    final peerName = routeArgs['peer_name'];
    final peerImage = routeArgs['peer_image'];

    return StreamBuilder(
        stream: Firestore.instance
            .collection('messages')
            .document(myName)
            .collection(peerName)
            .document(myId)
            .collection(peerId)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final chatDoc = chatSnapshot.data.documents;
          // print(chatDoc);
          if (chatDoc.length == 0)
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'You have not started any conversation with this person',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // backgroundColor: Colors.green,

                        fontSize: 20,
                        color: Colors.black12),
                  ),
                ),
              ],
            );
          return ListView.builder(
              reverse: true,
              itemCount: chatDoc.length,
              itemBuilder: (ctx, index) {
                if (chatDoc[index]['isMe']) {
                  return MessageBubble(
                    chatDoc[index]['text'],
                    chatDoc[index]['isMe'],
                    myName,
                    myImage,
                  );
                } else {
                  return MessageBubble(
                    chatDoc[index]['text'],
                    chatDoc[index]['isMe'],
                    peerName,
                    peerImage,
                  );
                }
              });
        });
  }
}
