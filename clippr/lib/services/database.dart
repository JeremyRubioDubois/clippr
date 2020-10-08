import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart';

class Database {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = 'error';

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'lastName': user.lastName,
        'firstName': user.firstName,
        'phone': user.phone,
        'groupeId': user.groupeId,
      });
    } catch (e) {
      print(e);
    }

    return retVal;
  }
}
