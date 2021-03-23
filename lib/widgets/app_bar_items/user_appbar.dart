import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

AppBar userAppBar({dynamic googleSignIn, dynamic context, String title}) {
  return AppBar(
    title: Text(title),
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
