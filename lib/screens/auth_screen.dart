import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth_form/auth_form.dart';
import '../widgets/auth_form/auth_gmail.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;

  void _createUser(
    String email,
    String uid,
    String username,
    String url,
  ) async {
    await Firestore.instance.collection('user').document(uid).setData({
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
    AuthResult authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (islogin) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child(authResult.user.uid + '.jpg');

        await ref.putFile(image).onComplete;

        final url = await ref.getDownloadURL();
        _createUser(email, authResult.user.uid, username, url);
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
