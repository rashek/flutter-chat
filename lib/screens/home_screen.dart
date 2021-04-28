import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/users/friend_list/friend_list.dart';

import '../widgets/app_bar_items/user_appbar.dart';
import '../widgets/app_bar_items/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  static final routeName = '/main_tab';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userAppBar(
        googleSignIn: googleSignIn,
        context: context,
        title: 'Chat Room',
      ),
      drawer: AppDrawer(),
      body: FriendList(),
    );
  }
}
