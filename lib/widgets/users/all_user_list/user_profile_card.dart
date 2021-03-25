import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:chat/screens/chat_screen.dart';

class UserCard extends StatefulWidget {
  final String userId;
  final String username;
  final String userImage;
  final String myId;
  final String myName;
  final String myImage;
  final bool isMe;
  UserCard(
    this.userId,
    this.username,
    this.userImage,
    this.myId,
    this.myName,
    this.myImage,
    this.isMe,
  );

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  void _sendRequest(check) async {
    if (check) {
      await Firestore.instance
          .collection('user')
          .document(widget.userId)
          .collection('requests')
          .document(widget.myId)
          .setData({
        'uid': widget.myId,
        'username': widget.myName,
        'image_url': widget.myImage,
      });
    } else if (!check) {
      await Firestore.instance
          .collection('user')
          .document(widget.userId)
          .collection('requests')
          .document(widget.myId)
          .delete();
    }
    setState(() {});
  }

  Future<QuerySnapshot> _fetchStatus() async {
    final ab = await Firestore.instance
        .collection('user')
        .document(widget.userId)
        .collection('requests')
        .where('uid', isEqualTo: widget.myId)
        .getDocuments();
    return ab;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isMe)
      return FutureBuilder(
          future: _fetchStatus(),
          builder: (context, checksnapshot) {
            if (checksnapshot.connectionState == ConnectionState.waiting) {
              return Text('Loading');
            }
            final checkStatus = checksnapshot.data.documents;
            print(checkStatus.length);
            return Card(
              margin: EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 5,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(widget.userImage),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              widget.username,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      OutlinedButton(
                        onPressed: () {
                          _sendRequest(checkStatus.length < 1);
                        },
                        child: checkStatus.length < 1
                            ? Text('Add +')
                            : Text('Added'),
                      )
                    ],
                  )),
              // ),
            );
          });

    return Padding(
      padding: const EdgeInsets.all(0.0),
    );
  }
}
