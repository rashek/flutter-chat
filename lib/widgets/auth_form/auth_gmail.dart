import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGmail extends StatefulWidget {
  @override
  _AuthGmailState createState() => _AuthGmailState();
}

class _AuthGmailState extends State<AuthGmail> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLoading;
  // @override
  Future<void> handleSignIn() async {
    this.setState(() {
      isLoading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser fireUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (fireUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: fireUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;

      if (documents.length == 0) {
        // Update data to server if new user
        Firestore.instance.collection('user').document(fireUser.uid).setData({
          // 'nickname': fireUser.displayName,
          'username': fireUser.displayName,
          'email': fireUser.email,
          'image_url': fireUser.photoUrl,
        });

        // Write data to local
        // currentUser = firebaseUser;
        // await prefs.setString('id', currentUser.uid);
        // await prefs.setString('nickname', currentUser.displayName);
        // await prefs.setString('photoUrl', currentUser.photoURL);
      }
    }
  }

  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        child: Text('Login with Gmail'),
        onPressed: handleSignIn,
      ),
    );
  }
}
