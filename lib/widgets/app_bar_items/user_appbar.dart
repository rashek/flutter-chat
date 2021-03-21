import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

AppBar userAppBar({dynamic googleSignIn, dynamic context}) {
  return AppBar(
    title: Text('Chat Window'),
    actions: [
      DropdownButton(
        icon: Icon(Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color),
        items: [
          DropdownMenuItem(
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.exit_to_app),
                  SizedBox(
                    width: 8,
                  ),
                  Text('Logout'),
                ],
              ),
            ),
            value: 'Logout',
          )
        ],
        onChanged: (itemIdentifier) {
          if (itemIdentifier == 'Logout') {
            FirebaseAuth.instance.signOut();
            googleSignIn.disconnect();
            googleSignIn.signOut();
          }
        },
      ),
    ],
  );
}
