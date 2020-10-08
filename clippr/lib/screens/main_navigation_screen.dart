import 'package:clippr/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'favorites/favorites.dart';
import 'home/home.dart';

class MainNavigationScreen extends StatefulWidget{
  @override
  _MainNavigationScreenState createState() =>_MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen>{

  int _currentIndex = 0;
  
  final List<Widget> _children = <Widget>[
    Home(),
    Favorites(),
    Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Accueil')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favoris'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Compte'),
            
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue,
      ),
    );
  }
}
