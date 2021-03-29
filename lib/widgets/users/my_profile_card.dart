import 'package:chat/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import '../../screens/profile_screen.dart';

class MyProfileCard extends StatelessWidget {
  final String myId;
  final String myName;
  final String myImage;
  MyProfileCard(this.myId, this.myName, this.myImage);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(ProfileScreen.routeName, arguments: {
          'Id': myId,
          'name': myName,
          'image': myImage,
        });
      },
      child: Container(
        padding: EdgeInsets.only(top: 8),
        width: 200,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundImage: NetworkImage(myImage),
                ),
                Text(
                  myName == null ? 'got null' : myName,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    // });
  }
}
