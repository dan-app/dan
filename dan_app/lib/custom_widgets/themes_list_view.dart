import 'package:dan_app/data/theory_exercise.dart';
import 'package:flutter/material.dart';

class ThemesListView extends StatelessWidget {
  final List<TheoryExercise> data;

  const ThemesListView({required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data
          .map(
            (e) => Card(
              child: ListTile(
                leading: FlutterLogo(),
                title: Text('One-line with leading widget'),
              ),
            ),
          )
          .toList(),
    );
  }
}
