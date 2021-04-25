import 'package:flutter/widgets.dart';

import '../../data/df_iris.dart';
import '../../exercises/exercise_page.dart';
import '../../exercises/select_column.dart';

class Task0 extends StatelessWidget {
  final ValueChanged<bool> onDone;

  const Task0({required this.onDone});

  @override
  Widget build(BuildContext context) {
    return ExercisePage(
      onDone: onDone,
      builder: (context, onSubmitted) => SelectColumnExercise(
        df: dfIris,
        column: dfIris.columns[1],
        onSubmitted: onSubmitted,
      ),
    );
  }
}
