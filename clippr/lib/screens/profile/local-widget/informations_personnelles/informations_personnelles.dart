import 'package:clippr/widgets/text_section.dart';
import 'package:flutter/material.dart';

class InformationsPersonnelles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informations personnelles'),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('Maquette à créer')
          ],
        ),
      ),
    );
  }
}
