import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  static final routeName = '/new-message';
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessaged = '';

  void _sendreq(String nameval1, String nameval2, String idval1, String idval2,
      String message, bool isMe) {
    Firestore.instance
        .collection('messages')
        .document(nameval1)
        .collection(nameval2)
        .document(idval1)
        .collection(idval2)
        .add({
      'text': _enteredMessaged,
      'createdAt': Timestamp.now(),
      'isMe': isMe
    });
  }

  void _sendMessage() async {
    bool isMe = true;
    FocusScope.of(context).unfocus();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final myId = routeArgs['myId'];
    final myName = routeArgs['my_name'];
    final peerId = routeArgs['peerId'];
    final peerName = routeArgs['peer_name'];
    _sendreq(myName, peerName, myId, peerId, _enteredMessaged, isMe);
    _sendreq(peerName, myName, peerId, myId, _enteredMessaged, !isMe);
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
          onPressed: _enteredMessaged.trim().isEmpty ? null : _sendMessage,
        )
      ]),
    );
  }
}
