import 'package:flutter/widgets.dart';

import '../data/df_iris.dart';
import 'exercise_page.dart';
import 'select_column.dart';

class SelectColumnExerciseTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ExercisePage(
      builder: (context, onSubmitted) => SelectColumnExercise(
        df: dfIris,
        column: dfIris.columns[1],
        onSubmitted: onSubmitted,
      ),
      onDone: (isCorrect) {
        // ignore: avoid_print
        print('isCorrect=$isCorrect');
      },
    );
  }
}
