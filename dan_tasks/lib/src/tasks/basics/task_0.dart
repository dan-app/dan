import 'package:flutter/widgets.dart';

import '../../data/df_iris.dart';
import '../../exercises/create_series.dart';
import '../../exercises/select_column.dart';
import '../../exercises/select_row.dart';
import '../tasks_page.dart';

class Task0 extends StatelessWidget {
  final ValueChanged<bool> onDone;

  const Task0({required this.onDone});

  @override
  Widget build(BuildContext context) {
    return TaskPage(
      exerciseBuilders: [
        (context, onSubmitted) => CreateSeriesExercise(
          values: const [3, 5, 7, 9],
          onSubmitted: onSubmitted,
        ),
        (context, onSubmitted) => SelectColumnExercise(
          df: dfIris,
          column: dfIris.columns[1],
          onSubmitted: onSubmitted,
        ),
        (context, onSubmitted) => SelectRowExercise(
          df: dfIris,
          rowIndex: 1,
          onSubmitted: onSubmitted,
        ),
        (context, onSubmitted) => CreateSeriesExercise(
          values: const [13, 17, 8, 2, 20],
          onSubmitted: onSubmitted,
        ),
        (context, onSubmitted) => SelectColumnExercise(
          df: dfIris,
          column: dfIris.columns[2],
          onSubmitted: onSubmitted,
        ),
        (context, onSubmitted) => SelectRowExercise(
          df: dfIris,
          rowIndex: 3,
          onSubmitted: onSubmitted,
        ),
      ],
      onDone: onDone,
    );
  }
}
