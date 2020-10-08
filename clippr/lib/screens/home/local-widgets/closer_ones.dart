import 'package:clippr/widgets/card_provider.dart';
import 'package:flutter/material.dart';
import '../../../widgets/text_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloserOnes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: TextSection('Les plus proches', 'Voici les coiffeurs les plus proches'),
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
