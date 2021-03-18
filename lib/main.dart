import 'package:chat/widgets/chat/messages.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/auth_screen.dart';

import './screens/user_screen.dart';
<<<<<<< HEAD
import './widgets/chat/messages.dart';
=======
import 'screens/chat_screen.dart';
import 'widgets/chat/new_message.dart';
>>>>>>> befa80abe6123eb7d54a508b90732c65ae3db12d

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Chat App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Colors.pink,
          accentColor: Colors.deepPurple,
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.pink,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.hasData) {
              return UserScreen();
              // return ChatScreen();
            }
            return AuthScreen();
          },
        ),
        routes: {
          ChatScreen.routeName: (ctx) => ChatScreen(),
<<<<<<< HEAD
=======
          NewMessage.routeName: (ctx) => NewMessage(),
>>>>>>> befa80abe6123eb7d54a508b90732c65ae3db12d
        });
  }
}
