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
      showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 24.0,
                title: Text(
                  'Are you sure to send a request',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                content: Text(
                  'Press yes to continue or no to cancel',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                      child: Text('No',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () => Navigator.of(context).pop()),
                  TextButton(
                      child: Text('Yes',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      onPressed: () async {
                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(widget.userId)
                            .collection('requests')
                            .doc(widget.myId)
                            .set({
                          'uid': widget.myId,
                          'username': widget.myName,
                          'image_url': widget.myImage,
                        });
                      }),
                ]);
          });
    } else if (!check) {
      await FirebaseFirestore.instance
          .collection('user')
          .doc(widget.userId)
          .collection('requests')
          .doc(widget.myId)
          .delete();
    }
    setState(() {});
  }

  Future<QuerySnapshot> _checkRequest() async {
    final ab = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.userId)
        .collection('requests')
        .where('uid', isEqualTo: widget.myId)
        .get();
    return ab;
  }

  Future<QuerySnapshot> _checkFriendList() async {
    final ab = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.userId)
        .collection('friend_list')
        .where('uid', isEqualTo: widget.myId)
        .get();
    return ab;
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isMe)
      return FutureBuilder(
          future: Future.wait([
            _checkRequest(),
            _checkFriendList(),
          ]),
          builder: (context, AsyncSnapshot<List<QuerySnapshot>> snapshot) {
            if (!snapshot.hasData) {
              return Padding(
                padding: EdgeInsets.all(0),
              );
            }
            final checkRequest = snapshot.data[0].docs;
            final checkFriend = snapshot.data[1].docs;
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
                          onPressed: checkFriend.length < 1
                              ? () {
                                  _sendRequest(checkRequest.length < 1);
                                }
                              : null,
                          child: !(checkRequest.length < 1)
                              ? Text('Added')
                              : checkFriend.length < 1
                                  ? Text('Add +')
                                  : Text('Friends'))
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
