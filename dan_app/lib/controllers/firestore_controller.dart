import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreController {
  static Future<List<dynamic>> getUserProgress(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user = await users.doc(uid).collection('themes').get();
    var docs =
        user.docs.map<dynamic>((doc) => doc.data()['tasks_done']).toList();
    return docs;
  }
}
