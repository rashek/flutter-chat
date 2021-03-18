import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
<<<<<<< HEAD
  final String myName;
  final String myImage;
  final String peerName;
  final String peerImage;
  MessageBubble(
    this.message,
    this.isMe,
    this.myName,
    this.myImage,
    this.peerName,
    this.peerImage,
=======
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
>>>>>>> befa80abe6123eb7d54a508b90732c65ae3db12d
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color:
                      isMe ? Colors.grey[300] : Theme.of(context).accentColor,
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
<<<<<<< HEAD
                      isMe ? myName : peerName,
=======
                      name,
                      //isMe ? peerName : myName,
>>>>>>> befa80abe6123eb7d54a508b90732c65ae3db12d
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue[900]),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: isMe
                            ? Colors.black
                            : Theme.of(context).accentTextTheme.headline1.color,
                      ),
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
<<<<<<< HEAD
                isMe ? NetworkImage(myImage) : NetworkImage(peerImage),
=======
                //isMe ? NetworkImage(peerImage) : NetworkImage(myImage),
                NetworkImage(image),
>>>>>>> befa80abe6123eb7d54a508b90732c65ae3db12d
          ),
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}
