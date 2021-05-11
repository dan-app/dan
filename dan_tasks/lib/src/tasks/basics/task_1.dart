import 'package:flutter/widgets.dart';

import '../../data/df_iris.dart';
import '../../exercises/exercise_page.dart';
import '../../exercises/select_row.dart';

class Task1 extends StatelessWidget {
  final ValueChanged<bool> onDone;

  const Task1({required this.onDone});

  @override
  Widget build(BuildContext context) {
    return ExercisePage(
      onDone: onDone,
      builder: (context, onSubmitted) => SelectRowExercise(
        df: dfIris,
        rowIndex: 1,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
