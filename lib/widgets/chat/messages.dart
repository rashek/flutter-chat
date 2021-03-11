import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../chat/message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return StreamBuilder(
              stream: Firestore.instance
                  .collection('chat')
                  .orderBy('createdAt', descending: true)
                  .snapshots(),
              builder: (ctx, chatSnapshot) {
                if (chatSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final chatDoc = chatSnapshot.data.documents;
                return ListView.builder(
                  reverse: true,
                  itemCount: chatDoc.length,
                  itemBuilder: (ctx, index) => MessageBubble(
                    chatDoc[index]['text'],
                    chatDoc[index]['userId'] == futureSnapshot.data.uid,
                    chatDoc[index]['username'],
                    chatDoc[index]['userImage'],
                  ),
                );
              });
        });
  }
}
