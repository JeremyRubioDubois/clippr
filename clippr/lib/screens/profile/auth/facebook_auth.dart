import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:clippr/screens/profile/auth/custom_web_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

String your_client_id = "221195605847679";
String your_redirect_url =
    "https://www.facebook.com/connect/login_success.html";
FirebaseAuth auth = FirebaseAuth.instance;
User user;

loginWithFacebook(BuildContext context) async {
  String result = await Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CustomWebView(
        selectedUrl:
            'https://www.facebook.com/dialog/oauth?client_id=$your_client_id&redirect_uri=$your_redirect_url&response_type=token&scope=email,public_profile,',
      ),
      maintainState: true,
    ),
  );
  if (result != null) {
    try {
      final facebookAuthCred = FacebookAuthProvider.credential(result);
      final User user =
          (await auth.signInWithCredential(facebookAuthCred)).user;

      print("The user (from Facebook) is " + user.displayName);

      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'firstName': user.displayName,
        'email': '',
        'phone': '',
        'grade': '',
        'profilePicture': user.photoURL,
      });
    } catch (e) {}
  }
}
