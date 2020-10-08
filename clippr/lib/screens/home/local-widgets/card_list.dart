import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import '../../../services/database.dart';
//import '../../../models/user.dart';

class CardList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user_names = [
      'Jeremy Dubois',
      'Alexis Deroeux',
      'Jean Depuis',
      'Jeremy Dubois',
      'Jeremy Dubois',
      'Jeremy Dubois'
    ];
    final user_grades = ['4/5', '5/5', '4,5/5', '4,5/5', '4,5/5', '4,5/5'];

    CollectionReference users = FirebaseFirestore.instance.collection('users');
    print(users);

    return ListView.builder(
        itemCount: 10,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(user_names[index]);
            },
            child: Container(
              width: 200,
              child: Column(children: [
                Image.network(
                    'https://media-exp1.licdn.com/dms/image/C5603AQF56AZZqLHjQQ/profile-displayphoto-shrink_100_100/0?e=1606953600&v=beta&t=ebHBYArJQMC3DRSq0yfSlGFjEMqYw-tug_aKXA0HBTI'),
                Text(user_names[index]),
                Text(user_grades[index]),
                //Text(users.lastName[index])
              ]),
            ),
          );
        });
  }
}
