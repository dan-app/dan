import 'package:dan_app/custom_widgets/themes_list_view.dart';
import 'package:dan_app/data/theory_exercise.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemesListView(data: [
      TheoryExercise(),
      TheoryExercise(),
      TheoryExercise(),
      TheoryExercise(),
      TheoryExercise(),
      TheoryExercise(),
      TheoryExercise(),
      TheoryExercise(),
      TheoryExercise(),
    ]);
  }
}
