import 'package:flutter/material.dart';

import '../widgets/notifications/notification.dart';
import '../widgets/app_bar_items/app_drawer.dart';

class RequestsScreen extends StatelessWidget {
  static final routeName = '/requests';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Requests'),
      ),
      drawer: AppDrawer(),
      body: NotificationList(),
    );
  }
}
