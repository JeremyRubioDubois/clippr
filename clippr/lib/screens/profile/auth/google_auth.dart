import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  User user  =
      (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      
  print("The user (from Google) is " + user.displayName);

  await FirebaseFirestore.instance
      .collection('users')
      .doc(user.uid)
      .set({
        'firstName': user.displayName,
        'email' : user.email,
        'phone': '',
        'grade': '',
        'profilePicture' : user.photoURL,
      });
}
