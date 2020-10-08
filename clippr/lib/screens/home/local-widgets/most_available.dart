import 'package:clippr/widgets/card_provider.dart';
import 'package:flutter/material.dart';
import 'card_provider_list.dart';
import '../../../widgets/text_section.dart';
import '../../../models/user.dart';
import 'card_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//**/
void setData() async {
  final databaseReference = FirebaseFirestore.instance;
  final firebaseUser = await FirebaseAuth.instance.currentUser;
  databaseReference.collection("users").doc(firebaseUser.uid).set({
    "lastName": "Dubois",
    "firstName": "Damien",
    "grade": "4.1",
  }, SetOptions(merge: true)).then((_) {
    print("success!");
  });
}
/**/
/*
void getData() {
  final databaseReference = FirebaseFirestore.instance;
  databaseReference.collection("users").get().then((querySnapshot) {
    querySnapshot.docs.forEach((result) {
      return Text('test');
      print(result.data()['lastName']);
    });
  });
}
*/

class MostAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextSection('Les plus disponibles', 'Voici les coiffeurs les plus disponibles'),
        ),
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
            .collection('users')
            .where("coiffeur", isEqualTo: 1)
            .snapshots(),
          builder: (context, snapshot) {
            return !snapshot.hasData
                ? Center(child: CircularProgressIndicator())
                : Container(
                    height: 250.0,
                    child: ListView.builder(
                      //shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot data = snapshot.data.docs[index];
                        var firstName = data.data()['firstName'];
                        var lastName = data.data()['lastName'];
                        var _profilePicture = data.data()['profilePicture'];
                        var grade = data.data()['grade'];
                        return Container(
                          child: CardProvider(firstName, lastName, _profilePicture, grade)
                        );
                      },
                    )
                  );
          },
        ),
      ]
    );
  }
}
