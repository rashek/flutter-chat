import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/user_profile/user_list.dart';
import '../widgets/app_bar_items/user_appbar.dart';
import '../widgets/app_bar_items/app_drawer.dart';

class AllUserScreen extends StatelessWidget {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userAppBar(googleSignIn: googleSignIn, context: context),
      drawer: AppDrawer(),
      body: UserList(),
      bottomNavigationBar: BottomNavigationBar(
        // onTap: ,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group_rounded),
            // ignore: deprecated_member_use
            title: Text('bottom 1'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_a_photo),
            // ignore: deprecated_member_use
            title: Text('bottom 2'),
          ),
        ],
      ),
    );
  }
}
