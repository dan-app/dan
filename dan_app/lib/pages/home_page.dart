import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/data/dan_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<DanTheme> data;
  final Function taskOpenedCallback;
  final Function theoryOpenedCallback;
  late Map<String, int> docs;

  HomePage({
    required this.data,
    required this.taskOpenedCallback,
    required this.theoryOpenedCallback,
  });

  void setDocs() async {
    docs = await FirestoreController.getUserProgress(
      FirebaseAuth.instance.currentUser!.uid,
    );
  }

  @override
  Widget build(BuildContext context) {
    setDocs();

    return ListView(
      children: data
          .map(
            (e) => Card(
              child: ListTile(
                onTap: () {
                  showDialog<dynamic>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(e.name),
                      content: Text("Basics of data analysis"),
                      actions: <Widget>[
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                theoryOpenedCallback(e.id);
                              },
                              child: Text('Theory'),
                            ),
                            Row(
                              children: [
                                ...List<TextButton>.generate(
                                  e.tasksCount,
                                  (i) => TextButton(
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: Size(30, 30),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                      taskOpenedCallback(
                                        taskNumber: i,
                                        themeId: e.id,
                                      );
                                    },
                                    child: Text(
                                      (i + 1).toString(),
                                      style: TextStyle(
                                          color: i < docs[e.id]!
                                              ? Colors.green
                                              : i == docs[e.id]
                                                  ? Colors.lightBlue
                                                  : Colors.grey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
                leading: FlutterLogo(),
                title: Text(e.name),
              ),
            ),
          )
          .toList(),
    );
  }
}
