import 'package:flutter/material.dart';

import '../widgets/users/all_user_list/all_users_list.dart';
import '../widgets/app_bar_items/app_drawer.dart';

class AllUserScreen extends StatelessWidget {
  static const routeName = '/All_user';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All User Screen'),
      ),
      drawer: AppDrawer(),
      body: AllUserList(),
    );
  }
}
