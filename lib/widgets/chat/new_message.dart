import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../picker/chat_image_picker.dart';

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
  File _pickImageFile;
  void _sendreq(
      String chatId, String message, String userId, String peerId) async {
    if (!widget.chatStatus) {
      await FirebaseFirestore.instance
          .collection('massage_data')
          .doc(userId)
          .collection(peerId)
          .doc()
          .set({'chat_id': chatId});
      await FirebaseFirestore.instance
          .collection('massage_data')
          .doc(peerId)
          .collection(userId)
          .doc()
          .set({'chat_id': chatId});
    }
    if (_pickImageFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('chat_image')
          .child(userId)
          .child(DateTime.now().toString() + '.jpg');
      await ref.putFile(_pickImageFile);
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('chat')
          .doc()
          .set({
        'image_url': url,
        'createdAt': Timestamp.now(),
        'sender_id': userId
      });
      setState(() {
        _pickImageFile = null;
      });
    }
    if (_enteredMessaged.length != 0)
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(chatId)
          .collection('chat')
          .doc()
          .set({
        'text': _enteredMessaged,
        'createdAt': Timestamp.now(),
        'sender_id': userId
      });
  }

  void _pickedImage(File image) {
    _pickImageFile = image;
    setState(() {});
  }

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final myId = routeArgs['myId'];
    final peerId = routeArgs['peerId'];

    _sendreq(widget.chatId, _enteredMessaged, myId, peerId);
    _enteredMessaged = '';
    _controller.clear();
    setState(() {});
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
          onPressed:
              _enteredMessaged.trim().length != 0 || _pickImageFile != null
                  ? _sendMessage
                  : null,
        ),
        ChatImagePicker(_pickedImage),
      ]),
    );
  }
}
