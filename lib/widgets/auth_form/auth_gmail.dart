import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthGmail extends StatefulWidget {
  AuthGmail(this.createFn);
  final void Function(
    String email,
    String uid,
    String username,
    String url,
  ) createFn;
  @override
  _AuthGmailState createState() => _AuthGmailState();
}

class _AuthGmailState extends State<AuthGmail> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool isLoading = false;

  // @override
  Future<FirebaseUser> handleSignIn() async {
    this.setState(() {
      isLoading = true;
    });

    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

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
      this.setState(() {
        isLoading = false;
      });
      if (documents.length == 0) {
        // Update data to server if new user
        widget.createFn(
          fireUser.email,
          fireUser.uid,
          fireUser.displayName,
          fireUser.photoUrl,
        );

        // Write data to local
        // currentUser = firebaseUser;
        // await prefs.setString('id', currentUser.uid);
        // await prefs.setString('nickname', currentUser.displayName);
        // await prefs.setString('photoUrl', currentUser.photoURL);

      }
    }
    return fireUser;
  }

  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? CircularProgressIndicator()
          : OutlinedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white)),
              child: Text('Login With Gmail'),
              onPressed: handleSignIn,
            ),
    );
  }
}
