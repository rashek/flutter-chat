import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String name;
  final String image;
  // final String myName;
  // final String myImage;
  // final String peerName;
  // final String peerImage;
  MessageBubble(
    this.message,
    this.isMe,
    this.name,
    this.image,
    // this.myName,
    // this.myImage,
    // this.peerImage,
    // this.peerName,
  );
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final testingid = routeArgs['myId'];
    return Stack(
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isMe ? Colors.greenAccent : Colors.greenAccent[400],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isMe ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isMe ? Radius.circular(0) : Radius.circular(12),
                  ),
                ),
                width: 140,
                padding: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Column(
                  crossAxisAlignment:
                      isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      //isMe ? peerName : myName,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue[900]),
                    ),
                    Text(
                      message,
                      style: TextStyle(color: Colors.black),
                      textAlign: isMe ? TextAlign.end : TextAlign.start,
                    ),
                  ],
                ),
              ),
            ]),
        Positioned(
          // top: -10,
          left: isMe ? null : 120,
          right: isMe ? 120 : null,
          child: CircleAvatar(
            backgroundImage:
                //isMe ? NetworkImage(peerImage) : NetworkImage(myImage),
                NetworkImage(image),
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
