import 'package:flutter/material.dart';
import 'package:clippr/widgets/text_section.dart';
import 'package:flutter/material.dart';

class Provider extends StatelessWidget {

  final _firstName;
  Provider(this._firstName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 50),
              TextSection(_firstName, 'Page coiffeur de $_firstName'),
              SizedBox(height: 15),
            ]),
      ),
    );
  }
}
