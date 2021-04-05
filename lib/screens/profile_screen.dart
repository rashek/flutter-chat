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
    final id = routeArgs['Id'];
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        body: Profile(),
        // floatingActionButton: FloatingActionButton(onPressed: () {})
        floatingActionButton: OpenContainer(
          closedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50))),
          closedBuilder: (context, openWidget) {
            return FloatingActionButton(
              // clipBehavior: null,
              // foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).primaryColor,
              child: Text("ADD"),
              onPressed: openWidget,
            );
          },
          openBuilder: (context, closedWidget) {
            return AddPostScreen(id, name);
          },
        ));
  }
}
