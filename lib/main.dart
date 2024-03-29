import 'package:chat/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import './screens/auth_screen.dart';
import './screens/all_user_screen.dart';
import './screens/profile_screen.dart';
import './screens/chat_screen.dart';
import 'screens/main_tab_screen.dart';
import 'widgets/chat/new_message.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        theme: ThemeData(
          primaryColor: Colors.greenAccent[400],
          backgroundColor: Colors.greenAccent[200],
          accentColor: Colors.greenAccent[200],
          accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.greenAccent[400],
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              )),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              return MainTabScreen();
              // return ChatScreen();
            }
            return AuthScreen();
          },
        ),
        routes: {
          MainTabScreen.routeName: (ctx) => MainTabScreen(),
          ChatScreen.routeName: (ctx) => ChatScreen(),
          // NewMessage.routeName: (ctx) => NewMessage(),
          ProfileScreen.routeName: (ctx) => ProfileScreen(),
          AllUserScreen.routeName: (ctx) => AllUserScreen(),
        });
  }
}
