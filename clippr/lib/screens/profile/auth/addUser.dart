import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OurUser {
  String uid;
  String lastName;
  String firstName;
  String phone;
  String groupeId;
  String email;
  final firestoreInstance = FirebaseFirestore.instance;

  OurUser({
    this.uid,
    this.lastName,
    this.firstName,
    this.phone,
    this.groupeId,
    this.email
  });
      
  void _onPressed(OurUser user) async {
    var firebaseUser = await FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("users").doc(firebaseUser.uid).set({
      "name": "john",
      "age": 50,
      "email": "example@example.com",
      "address": {"street": "street 24", "city": "new york"}
    }).then((_) {
      print("success!");
    });
  }

}
