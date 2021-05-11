import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dan_tasks/dan_tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final String themeId;
  final int taskNumber;
  final void Function({required int taskNumber, required String themeId})
      taskDoneCallback;

  const TaskPage(
      {required this.taskNumber,
      required this.taskDoneCallback,
      required this.themeId});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  bool progressVisible = false;

  Future<void> updateUser(CollectionReference users) {
    return users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('themes')
        .doc(widget.themeId)
        .set(<String, int>{
      'tasks_done': widget.taskNumber + 1,
    }).then((value) {
      widget.taskDoneCallback(taskNumber: -1, themeId: '');
    }).catchError(
      (dynamic error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Something went wrong'),
          ),
        );
      },
    );
  }

  void onDone({required bool isCorrect}) {
    setState(() {
      progressVisible = true;
    });
    if (isCorrect) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Well done!'),
        ),
      );
      updateUser(FirebaseFirestore.instance.collection('users'));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You made some mistakes, try again later'),
        ),
      );
      // exit task anyway
      widget.taskDoneCallback(taskNumber: -1, themeId: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final task = tasks[widget.themeId]![widget.taskNumber](
      context,
      (isCorrect) => onDone(isCorrect: isCorrect),
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: task),
            if (progressVisible) CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
