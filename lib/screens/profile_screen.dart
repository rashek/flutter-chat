import 'package:flutter/material.dart';

import '../widgets/profile/profile.dart';

class ProfileScreen extends StatelessWidget {
  static final routeName = '/profile_screen';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final name = routeArgs['name'];
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Profile());
  }
}
