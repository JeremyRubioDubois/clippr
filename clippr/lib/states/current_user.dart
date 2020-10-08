import 'package:clippr/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CurrentUser extends ChangeNotifier {
  OurUser _currentUser = OurUser();

  OurUser get getCurrentUser => _currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = 'error';
    try {
      User _firebaseUser = await _auth.currentUser;
      if (_firebaseUser != null) {
        _currentUser.uid = _firebaseUser.uid;
        _currentUser.email = _firebaseUser.email;
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = 'error';
    try {
      await _auth.signOut();
        _currentUser = OurUser();
        retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  /*Future<String> signUpWithPhone(String) async {
    String retVal = 'error';
    try {
      await _auth.signOut();
        _currentUser = OurUser();
        retVal = 'success';
    } catch (e) {
      print(e);
    }
    return retVal;
  }*/
}
