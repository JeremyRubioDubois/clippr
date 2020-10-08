import 'package:flutter/material.dart';
import 'local-widgets/most_available.dart';
import 'local-widgets/closer_ones.dart';
import 'local-widgets/best_grades.dart';

class Home extends StatefulWidget{
  @override
  _HomeState createState() =>_HomeState();
}

class _HomeState extends State<Home>{

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('Home')
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 0),
        children: [
          BestGrades(),
          CloserOnes(),
          MostAvailable(),
        ],
      ),
    );
  }
}
