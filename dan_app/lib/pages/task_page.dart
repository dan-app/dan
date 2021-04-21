import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final int taskNumber;

  const TaskPage({required this.taskNumber});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool progressVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                CollectionReference users =
                    FirebaseFirestore.instance.collection('users');
                Future<void> updateUser() {
                  return users
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('tasks')
                      .doc(widget.taskNumber.toString())
                      .update(<String, String>{'done': 'true'})
                      .then((value) => print("User Updated"))
                      .catchError((dynamic error) =>
                          print("Failed to update user: $error"));
                }
              },
              child: Text("Готово!"),
            ),
            if (progressVisible) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
