import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat/message_bubble.dart';
// import '../chat/new_message.dart';

class Messages extends StatelessWidget {
  final String chatId;
  final bool chatStatus;
  Messages(this.chatId, this.chatStatus);
  @override
  Widget build(BuildContext context) {
    if (chatStatus)
      return StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('chats')
              .doc(chatId)
              .collection('chat')
              .orderBy('createdAt', descending: true)
              .limit(10)
              .snapshots(),
          builder: (ctx, chatSnapshot) {
            if (chatSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final chatDoc = chatSnapshot.data.docs;
            // print(chatDoc[0]['text']);
            return
                // Text(
                //     chatDoc[0]['text'] == null ? 'null' : chatDoc[0]['text']);
                // Text(chatDoc[0]['image_url']==null?'null':chatDoc[0]['imageU']);
                ListView.builder(
                    reverse: true,
                    itemCount: chatDoc.length,
                    itemBuilder: (ctx, index) {
                      return MessageBubble(
                        chatDoc[index]['text'] == null
                            ? ''
                            : chatDoc[index]['text'],
                        chatDoc[index]['image_url'] == null
                            ? ''
                            : chatDoc[index]['image_url'],
                        chatDoc[index]['sender_id'],
                      );
                    });
          });

    if (!chatStatus)
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            'You have not started any conversation with this person',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.black12),
          ),
        ),
      ]);
  }
}
