import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  static final routeName = '/new-message';
  @override
  _NewMessageState createState() => _NewMessageState();
  final String chatId;
  final bool chatStatus;
  NewMessage(this.chatId, this.chatStatus);
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessaged = '';

  void _sendreq(
      String chatId, String message, String userId, String peerId) async {
    if (!widget.chatStatus) {
      await Firestore.instance
          .collection('massage_data')
          .document(userId)
          .collection(peerId)
          .document()
          .setData({'chat_id': chatId});
      await Firestore.instance
          .collection('massage_data')
          .document(peerId)
          .collection(userId)
          .document()
          .setData({'chat_id': chatId});
    }
    await Firestore.instance
        .collection('chats')
        .document(chatId)
        .collection('chat')
        .document()
        .setData({
      'text': _enteredMessaged,
      'createdAt': Timestamp.now(),
      'sender_id': userId
    });
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final myId = routeArgs['myId'];
    final peerId = routeArgs['peerId'];

    _sendreq(widget.chatId, _enteredMessaged, myId, peerId);
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
