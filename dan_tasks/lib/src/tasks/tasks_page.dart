import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../exercises/exercise_page.dart';
import '../utils/utils.dart';

class TaskPage extends HookWidget {
  final List<ExerciseBuilder> exerciseBuilders;
  final ValueChanged<bool> onDone;

  const TaskPage({
    required this.exerciseBuilders,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    final currentExerciseIndex = useState(0);
    final exerciseResults = useState(
      List<bool?>.filled(exerciseBuilders.length, null),
    );
    return Navigator(
      pages: [
        MaterialPage<void>(
          key: ValueKey(currentExerciseIndex.value),
          child: Column(
            children: [
              SizedBox(height: 16),
              SafeArea(
                child: _Header(
                  currentExerciseIndex: currentExerciseIndex.value,
                  exerciseResults: exerciseResults.value,
                ),
              ),
              Expanded(
                child: ExercisePage(
                  key: ValueKey(currentExerciseIndex.value),
                  builder: exerciseBuilders[currentExerciseIndex.value],
                  onDone: (result) {
                    exerciseResults.value = List.of(exerciseResults.value)
                      ..[currentExerciseIndex.value] = result;
                    if (currentExerciseIndex.value <
                        exerciseBuilders.length - 1) {
                      currentExerciseIndex.value += 1;
                    } else {
                      onDone(exerciseResults.value.every((it) => it!));
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ],
      onPopPage: (route, dynamic result) => route.didPop(result),
    );
  }
}

class _Header extends StatelessWidget {
  final int currentExerciseIndex;
  final List<bool?> exerciseResults;

  const _Header({
    required this.currentExerciseIndex,
    required this.exerciseResults,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (final result in exerciseResults.enumerate())
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 32,
              maxHeight: 32,
            ),
            child: ColoredBox(
              color: _resultColor(result.value).withOpacity(.64),
              child: Center(
                child: Text(
                  '${result.key + 1}',
                  style: TextStyle(
                    fontWeight: currentExerciseIndex == result.key
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
      ].addAround(SizedBox(width: 16)).toList(),
    );
  }
}

Color _resultColor(bool? result) {
  return result == null
      ? Colors.grey
      : result
          ? Colors.green
          : Colors.red;
}
