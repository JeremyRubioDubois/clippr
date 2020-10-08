import 'package:flutter/material.dart';
import '../../widgets/text_section.dart';
import 'local-widgets/image_banner.dart';

class LocationDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ImageBanner('assets/images/lake.jpg'),
          TextSection('Summaary1', 'LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLorem'),
          TextSection('Summaary2', 'LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLorem'),
          TextSection('Summaary3', 'LoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLoremLorem'),
        ],
      ),
    );
  }
}
