import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreController {
  static Future<Map<String, int>> getUserProgress(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    var user = await users.doc(uid).collection('themes').get();
    return Map.fromEntries(
      user.docs.map(
        (doc) => MapEntry(
          doc.id,
          doc.data()['tasks_done'] as int,
        ),
      ),
    );
  }
}
