import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:dan_app/data/dan_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<DanTheme> data;
  final Function taskOpenedCallback;
  final Function theoryOpenedCallback;

  HomePage({
    required this.data,
    required this.taskOpenedCallback,
    required this.theoryOpenedCallback,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<String, int> docs = {
    'creation': 3,
    'selection': 4,
    'grouping': 0,
    'merging': 0,
    'plotting': 0,
  };

  void setDocs() async {
    var docs = await FirestoreController.getUserProgress(
      FirebaseAuth.instance.currentUser!.uid,
    );

    setState(() {
      //this.docs = docs;
    });
  }

  @override
  void initState() {
    setDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.data
          .map(
            (e) => Card(
              child: ListTile(
                onTap: () {
                  showDialog<dynamic>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text(e.name),
                      content: Text(
                          "Using statistics functions, splitting data on some criteria and aggregating group values"),
                      actions: <Widget>[
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                widget.theoryOpenedCallback(e.id);
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
                                      widget.taskOpenedCallback(
                                        taskNumber: i,
                                        themeId: e.id,
                                      );
                                    },
                                    child: Text(
                                      (i + 1).toString(),
                                      style: TextStyle(
                                        color: docs[e.id] != null
                                            ? i < docs[e.id]!
                                                ? Colors.green
                                                : i == docs[e.id]
                                                    ? Colors.lightBlue
                                                    : Colors.grey
                                            : i == 0
                                                ? Colors.lightBlue
                                                : Colors.grey,
                                      ),
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
                leading: Icon(e.icon),
                title: Row(
                  children: [
                    Text(e.name),
                    Spacer(),
                    if (docs.isNotEmpty)
                      Text('${docs[e.id]}/${e.tasksCount}')
                    else
                      Text(''),
                  ],
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
