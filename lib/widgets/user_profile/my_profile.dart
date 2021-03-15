import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  MyProfile(this.name, this.image);
  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(image),
          ),
          Text(name)
        ],
      ),
    );
  }
}
