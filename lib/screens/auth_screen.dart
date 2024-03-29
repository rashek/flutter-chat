import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
// import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form/auth_form.dart';
import '../widgets/auth_form/auth_gmail.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _createUser(
    String email,
    String uid,
    String username,
    String url,
  ) async {
    WidgetsFlutterBinding.ensureInitialized();
    await firestore.collection('user').doc(uid).set({
      'username': username,
      'email': email,
      'uid': uid,
      'image_url': url,
    });
  }

  void _submitAuthForm(
    String email,
    String username,
    String password,
    File image,
    bool islogin,
    BuildContext ctx,
  ) async {
    UserCredential userCredential;
    try {
      setState(() {
        _isLoading = true;
      });
      if (islogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(userCredential.user.uid + '.jpg');

        await ref.putFile(image);

        final url = await ref.getDownloadURL();
        _createUser(email, userCredential.user.uid, username, url);
      }
    } on PlatformException catch (err) {
      var message = 'An error';
      if (err.message != null) {
        message = err.message;
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(ctx).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      setState(() {
        _isLoading = false;
      });
      print(err);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body:
          // AuthForm(_submitAuthForm, _isLoading),
          Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AuthForm(_submitAuthForm, _isLoading),
          AuthGmail(_createUser),
        ],
      ),
    );
  }
}
