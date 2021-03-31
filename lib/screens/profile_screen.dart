import 'package:chat/screens/add_post_screen.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

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
        body: Profile(),
        floatingActionButton: OpenContainer(
          closedBuilder: (context, openWidget) {
            return FloatingActionButton(
              // foregroundColor: Colors.white,
              backgroundColor: Colors.white,
              child: Text("ADD"),
              onPressed: openWidget,
            );
          },
          openBuilder: (context, closedWidget) {
            return AddPost();
          },
        ));
  }
}
