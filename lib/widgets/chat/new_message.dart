import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  static final routeName = '/new-message';

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessaged = '';

  void sendMessage() async {
    FocusScope.of(context).unfocus();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final peerId = routeArgs['peerId'];
    final username = routeArgs['username'];
    final user = await FirebaseAuth.instance.currentUser();
    final senderData =
        await Firestore.instance.collection('user').document(user.uid).get();
    Firestore.instance
        .collection('user')
        .document(user.uid)
        .collection(peerId)
        .add({
      'text': _enteredMessaged,
      'createdAt': Timestamp.now(),
      'userId': peerId,
      'peerUsername': username,
      'username': user.displayName,
      'userImage': senderData['image_url'],
    });
    Firestore.instance
        .collection('user')
        .document(peerId)
        .collection(user.uid)
        .add({
      'text': _enteredMessaged,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'peerUsername': user.displayName,
      'username': username,
      'userImage': senderData['image_url'],
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(labelText: 'Send a message...'),
            onChanged: (value) {
              setState(() {
                _enteredMessaged = value;
              });
            },
          ),
        ),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(
            Icons.send,
          ),
          onPressed: _enteredMessaged.trim().isEmpty ? null : sendMessage,
        )
      ]),
    );
  }
}
