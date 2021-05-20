import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

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

  static Future<void> addUser({
    required String email,
    required String password,
    required String username,
  }) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    users.doc(user.user!.uid).set(
      {
        'achievements': {
          'diligent': 0,
          'experienced': 0,
          'friendly': 0,
          'neat': 0,
          'pretty': 0,
          'student': 0,
          'storyteller':0,
        },
      },
    );
    users
        .doc(user.user!.uid)
        .update(<String, dynamic>{
          'email': user.user!.email,
          'username': username,
          'uid': user.user!.uid,
        })
        .then((value) => print("User Added"))
        .catchError((Object error) => print("Failed to add user: $error"));
  }

  static Future<Map<String, dynamic>> getAchievements(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final user = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return (user.data() as Map<String, dynamic>)['achievements']
        as Map<String, dynamic>;
  }

  static Future<Map<String, dynamic>> getUsers() async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    var map = <String, dynamic>{};
    await users.get().then(
      (value) {
        value.docs.forEach((doc) {
          map[doc.id] = doc.data();
        });
      },
    );
    return map;
  }

  static Future<Map<String, dynamic>> getUserData(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final user = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return user.data() as Map<String, dynamic>;
  }

  static Future<void> addFriend(String uid, String username) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'subscriptions': FieldValue.arrayUnion(<dynamic>[uid]),
    });
  }

  static Future<List<String>> getSubscribers(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    List<String> subscribers = await users
        .where('subscriptions', arrayContains: uid)
        .get()
        .then((value) {
      return value.docs.map((e) => e.id).toList();
    });
    return subscribers;
  }

  static Future<List<String>> getSubscriptions(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    List<String> subscriptions = await users.doc(uid).get().then((value) {
      print(value);
      return (value.get('subscriptions') as List).cast<String>();
    });
    return subscriptions;
  }

  static Future<String> getUsernameById(String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    String username = await users
        .doc(uid)
        .get()
        .then((value) => value.get('username') as String);
    return username;
  }

  static Future<void> uploadAvatar(File avatar, String uid) async {
    try {
      await FirebaseStorage.instance.ref('uploads/$uid').putFile(avatar);
    } on FirebaseException catch (e) {}
  }

  static Future<String> getAvatarLink(String uid) async {
    var link =
        await FirebaseStorage.instance.ref('uploads/$uid').getDownloadURL();
    return link;
  }

  static Future<void> updateAchievement(
      String achievementName, int level, String uid) async {
    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    await users.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'achievements.$achievementName': level,
    });
  }
  static Future<int> getAchievementLevel(String achievementName, String uid) async {
    final CollectionReference users =
    FirebaseFirestore.instance.collection('users');
    final user = await users.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return ((user.data() as Map<String, dynamic>)['achievements']
    as Map<String, dynamic>)[achievementName] as int;
  }
}
