import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String image;
  final String senderId;
  MessageBubble(
    this.message,
    this.image,
    this.senderId,
  );
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final myId = routeArgs['myId'];
    final myName = routeArgs['my_name'];
    final myImage = routeArgs['my_image'];
    final peerName = routeArgs['peer_name'];
    final peerImage = routeArgs['peer_image'];
    return Stack(
      children: [
        Row(
            mainAxisAlignment: senderId == myId
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: senderId == myId
                      ? Colors.greenAccent
                      : Colors.greenAccent[400],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft: !(senderId == myId)
                        ? Radius.circular(0)
                        : Radius.circular(12),
                    bottomRight: senderId == myId
                        ? Radius.circular(0)
                        : Radius.circular(12),
                  ),
                ),
                width: 140,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  crossAxisAlignment: senderId == myId
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      senderId == myId ? myName : peerName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue[900]),
                    ),
                    if (image.length != 0) Image.network(image),
                    if (message.length != 0)
                      Text(
                        message,
                        style: TextStyle(color: Colors.black),
                        textAlign:
                            senderId == myId ? TextAlign.end : TextAlign.start,
                      ),
                  ],
                ),
              ),
            ]),
        Positioned(
          // top: -10,
          left: senderId == myId ? null : 120,
          right: senderId == myId ? 120 : null,
          child: CircleAvatar(
            backgroundImage: senderId == myId
                ? NetworkImage(myImage)
                : NetworkImage(peerImage),
            // NetworkImage(image),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
