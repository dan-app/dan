import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final int taskNumber;
  final Function taskDoneCallback;

  const TaskPage({required this.taskNumber, required this.taskDoneCallback});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool progressVisible = false;

  Future<void> updateUser(CollectionReference users) {
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('themes')
        .doc(widget.taskNumber.toString())
        .update(<String, String>{
      'done': (widget.taskNumber + 1).toString()
    }).then((value) {
      widget.taskDoneCallback(0);
    }).catchError(
      (dynamic error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Что-то пошло не так'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                updateUser(FirebaseFirestore.instance.collection('users'));
              },
              child: Center(
                child: Text("Готово!"),
              ),
            ),
            if (progressVisible) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
