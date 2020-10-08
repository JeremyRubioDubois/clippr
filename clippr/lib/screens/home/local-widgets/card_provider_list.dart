import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardProviderList extends StatefulWidget {
  @override
  _CardProviderListState createState() => _CardProviderListState();
}

class _CardProviderListState extends State<CardProviderList> {
  Future getPosts() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection('users').get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    //CollectionReference users = FirebaseFirestore.instance.collection('users');
    return Container(
      child: FutureBuilder(
        future: getPosts(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Impossible de charger le nom");
          } else {
            //return Text("Le compte connecté : ${data['firstName']} ${data['lastName']}");
            return ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, int index) {
                  print("here");
                  print("${snapshot.data.documents[index]['lastName']}");
                  print("here");
                  return GestureDetector(
                    onTap: () {
                      print("test");
                    },
                    child: Container(
                      width: 200,
                      child: Column(children: [
                        Image.network(
                            'https://media-exp1.licdn.com/dms/image/C5603AQF56AZZqLHjQQ/profile-displayphoto-shrink_100_100/0?e=1606953600&v=beta&t=ebHBYArJQMC3DRSq0yfSlGFjEMqYw-tug_aKXA0HBTI'),
                        //Text('${[index]}'),
                        //Text(snapshot.data[index]['phone'].toString(),
                        //Text("Item count ${index}"),
                        //Text('${data['phone']}'),
                        //Text(users.lastName[index])
                      ]),
                    ),
                  );
                });
          }

          return Text("Loading ...");
        },
      ),
    );
  }
}
