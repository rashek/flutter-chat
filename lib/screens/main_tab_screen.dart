import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/users/friend_list/friend_list.dart';
import '../widgets/notifications/notification.dart';
import '../widgets/app_bar_items/user_appbar.dart';
import '../widgets/app_bar_items/app_drawer.dart';
import '../widgets/app_bar_items/user_bottom_navbar.dart';

class MainTabScreen extends StatefulWidget {
  static final routeName = '/main_tab';
  @override
  _MainTabScreenState createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final List<Map<String, Object>> _pages = [
    {'page': FriendList(), 'title': 'Chat'},
    {'page': NotificationList(), 'title': 'Myposts'},
  ];

  int _selectPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userAppBar(
          googleSignIn: googleSignIn,
          context: context,
          title: _pages[_selectPageIndex]['title']),
      drawer: AppDrawer(),
      body: _pages[_selectPageIndex]['page'],
      bottomNavigationBar: UserBottomNavbar(_selectPage, _selectPageIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
