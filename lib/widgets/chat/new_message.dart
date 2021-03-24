import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NewMessage extends StatefulWidget {
  static final routeName = '/new-message';
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = new TextEditingController();
  var _enteredMessaged = '';
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    configLocalNotification();
  }

  Future<void> configLocalNotification() async {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void _sendreq(String nameval1, String nameval2, String idval1, String idval2,
      String message, bool isMe, dynamic notification) {
    Firestore.instance
        .collection('messages')
        .document(nameval1)
        .collection(idval1)
        .document(nameval2)
        .collection(idval2)
        .add({
      'text': _enteredMessaged,
      'createdAt': Timestamp.now(),
      'isMe': isMe,
      'notification': notification
    });
  }

  void _sendMessage() async {
    bool isMe = true;
    dynamic notify;
    FocusScope.of(context).unfocus();
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final myId = routeArgs['myId'];
    final myName = routeArgs['my_name'];
    final peerId = routeArgs['peerId'];
    final peerName = routeArgs['peer_name'];
    _sendreq(myName, peerName, myId, peerId, _enteredMessaged, isMe, notify);
    _sendreq(peerName, myName, peerId, myId, _enteredMessaged, !isMe, notify);
    Platform.isAndroid ? showNotification(notify) : '';
    _controller.clear();

    //________________________________

//    await flutterLocalNotificationsPlugin.show(
//        0, 'plain title', 'plain body', platformChannelSpecifics,
//        payload: 'item x');
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         content: Text('alert message'),
    //       );
    //     });
  }

  // Future onSelectNotification(String payload) {
  //   debugPrint("payload : $payload");
  //   showDialog(
  //     context: context,
  //     builder: (_) => new AlertDialog(
  //       title: new Text('Notification'),
  //       content: new Text('$payload'),
  //     ),
  //   );
  // }

  void showNotification(message) async {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final peerName = routeArgs['peer_name'];
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'com.example.chat' : '',
      'Flutter chat demo',
      'your channel description',
      playSound: true,
      enableVibration: true,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    print(_enteredMessaged);
//    print(message['body'].toString());
//    print(json.encode(message));

    await flutterLocalNotificationsPlugin.show(
        0, peerName, _enteredMessaged, platformChannelSpecifics,
        payload: '');
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
            //keyboardType: TextInputType.text,
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
