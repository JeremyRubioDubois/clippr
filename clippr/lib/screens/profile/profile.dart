import 'package:clippr/widgets/text_section.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'local-widget/login_methods.dart';

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User _firebaseUser;
  String _status;
  String _firstName = 'Jeremy';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _logout() async {
    /// Method to Logout the `FirebaseUser` (`_firebaseUser`)
    try {
      // signout code
      await FirebaseAuth.instance.signOut();
      _firebaseUser = null;
      setState(() {
        _status = 'Signed out\n';
      });
    } catch (e) {
      setState(() {
        _status = e.toString() + '\n';
      });
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return new StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return new Center(child: Text('Loading'));
            }

            var userData = snapshot.data;
            return Scaffold(
              body: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 50),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Container(
                                height: 75,
                                width: 75,
                                child: userData['profilePicture'] == null ||
                                        userData['profilePicture'] == ''
                                    ? CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(
                                            'assets/icon/logo-clippr.png'),
                                      )
                                    : CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            '${userData['profilePicture']}'),
                                      )),
                          ),
                          Flexible(
                            child: SizedBox(width: 15),
                          ),
                          Flexible(
                              flex: 7,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  userData['firstName'] == null ||
                                          userData['firstName'] == ''
                                      ? Text('Bonjour',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                          ))
                                      : Text('${userData['firstName']}',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 22.0,
                                          )),
                                  SizedBox(height: 6),
                                  Text('Une coupe de cheveux ?',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16.0,
                                      )),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 15),
                      Divider(color: Colors.grey[400]),
                      ListView(
                        padding: EdgeInsets.only(top: 0),
                        shrinkWrap: true,
                        children: <Widget>[
                          ListTile(
                            onTap: () => Navigator.pushNamed(
                                context, '/informations-personnelles'),
                            leading: Icon(Icons.account_box),
                            title: Text('Informations personnelles'),
                          ),
                          Divider(color: Colors.grey[400]),
                          ListTile(
                            onTap: () =>
                                Navigator.pushNamed(context, '/invite'),
                            leading: Icon(Icons.card_giftcard),
                            title: Text('Invitez vos amis'),
                          ),
                          //SizedBox(height: 15),
                          ListTile(
                            onTap: () => _logout(),
                            leading:
                                Icon(Icons.exit_to_app, color: Colors.red[800]),
                            title: Text(
                              'Se déconnecter',
                              style: TextStyle(color: Colors.red[800]),
                            ),
                          ),
                        ],
                      ),
                    ]),
              ),
            );
          });
    } else {
      return Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 65),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Votre profil',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                )),
                            SizedBox(height: 6),
                            Text(
                                'Connectez-vous pour suivre votre activité sur Clippr',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16.0,
                                )),
                          ],
                        )),
                  ],
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return FractionallySizedBox(
                                heightFactor: 0.80, child: LoginMethods());
                          }).whenComplete(() {
                        setState(() {
                          print('Completed');
                        });
                      });
                    },
                    child: Text('Connexion',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        )),
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Vous n\'avez pas encore de compte ?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Créer un compte en 2 min',
                  style: TextStyle(
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 30),
                Divider(),
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/settings');
                    },
                    leading: Icon(Icons.settings),
                    title: Text('Parametres'),
                  ),
                ),
                Card(
                  color: Colors.transparent,
                  elevation: 0,
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed('/settings');
                    },
                    leading: Icon(Icons.star),
                    title: Text('Notez Clippr'),
                  ),
                ),
              ]),
        ),
      );
    }
  }
}
