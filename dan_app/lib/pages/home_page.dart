import 'package:dan_app/data/dan_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<DanTheme> data;
  final Function taskOpenedCallback;
  final Function theoryOpenedCallback;

  const HomePage({required this.data, required this.taskOpenedCallback, required this.theoryOpenedCallback});

  @override
  Widget build(BuildContext context) {
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
                      content: Text("Что-то умное надо написать"),
                      actions: <Widget>[
                        Column(
                          children: [
                            TextButton(
                              onPressed: () {theoryOpenedCallback(e.id);},
                              child: Text('Теория'),
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
                                      Navigator.of(context, rootNavigator: true).pop();
                                      taskOpenedCallback(taskNumber:i, themeId:e.id);
                                    },
                                    child: Text(
                                      (i + 1).toString(),
                                    ),
                                  ),
                                ),
                              ],
                            )
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
