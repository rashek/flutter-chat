import 'package:flutter/material.dart';
import './profile_items/user_details.dart';
import './profile_items/posts.dart';

class Profile extends StatelessWidget {
  // static final routeName = '/_user_profile';

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    final Id = routeArgs['Id'];
    final name = routeArgs['name'];
    final image = routeArgs['image'];

    return Container(
      child: Column(
        children: [
          UserDtails(name, image),
          Expanded(child: Posts(Id)),
        ],
      ),
    );
  }
}
