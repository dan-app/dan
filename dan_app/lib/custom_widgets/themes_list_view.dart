import 'package:dan_app/data/dan_theme.dart';
import 'package:flutter/material.dart';

class ThemesListView extends StatelessWidget {
  final List<DanTheme> data;

  const ThemesListView({required this.data});

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
                                    onPressed: () {},
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
                                            onPressed: () {},
                                            child: Text((i + 1).toString())),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ));
                },
                leading: FlutterLogo(),
                title: Text('One-line with leading widget'),
              ),
            ),
          )
          .toList(),
    );
  }
}
