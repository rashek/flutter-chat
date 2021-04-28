import 'package:flutter/material.dart';

import '../../screens/all_user_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/requests_screen.dart';
// import '../../screens/main_tab_screen.dart';

class AppDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(icon, size: 26),
      title: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            // height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(30),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      'assets/images/logo.png',
                    ),
                    radius: 80,
                  ),
                ),
              ],
            ),
          ),
          buildListTile('Home', Icons.home_filled, () {
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
          }),
          buildListTile('Requests', Icons.group_rounded, () {
            Navigator.of(context)
                .pushReplacementNamed(RequestsScreen.routeName);
          }),
          buildListTile('All User', Icons.group_rounded, () {
            Navigator.of(context).pushReplacementNamed(AllUserScreen.routeName);
          }),
        ],
      ),
    );
  }
}
