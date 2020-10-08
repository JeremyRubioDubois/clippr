//import 'location_fact.dart';

class Location {
  String name;
  String imagePath;

  Location(this.name, this.imagePath);

  static List<Location> fetchAll() {
    return [
      Location('1', 'assets/images/kiyomizu-dera.jpg'),
      Location('2', 'assets/images/kiyomizu-dera.jpg'),
      Location('3', 'assets/images/kiyomizu-dera.jpg'),
      Location('4', 'assets/images/kiyomizu-dera.jpg'),
    ];
  }
}
