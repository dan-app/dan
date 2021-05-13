import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/code.dart';
import '../data/data_frame.dart';
import '../widgets/code_chips_input.dart';
import '../widgets/data_frame_table_preview.dart';
import 'exercise_page.dart';

class CreateSeriesExercise extends HookWidget {
  final List<int> values;
  final ValueChanged<ExerciseResult> onSubmitted;

  const CreateSeriesExercise({
    required this.values,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Task: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(
                  text: 'Create series from the values: ',
                ),
                TextSpan(
                  text: values.join(', '),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CodeChipsInput(
            codeSpans: [
              CodeSpan(data: 'pd.DataFrame'),
              CodeSpan(data: 'pd.Series'),
              CodeSpan(data: 'pd.create'),
              CodeSpan(data: '['),
              CodeSpan(data: ']'),
              CodeSpan(data: '('),
              CodeSpan(data: ')'),
              CodeSpan(data: '{'),
              CodeSpan(data: '}'),
              for (final val in List.of(values)
                ..addAll([
                  (values[0] + values[1]) ~/ 2,
                  (values[1] + values[2]) ~/ 2,
                ])
                ..sort())
                CodeSpan(data: '$val'),
              for (int i = 1; i < values.length; i += 1) CodeSpan(data: ', '),
            ],
            onSubmitted: (code) {
              final actual = code.map((span) => span.data).join();
              final expected = 'pd.Series([${values.join(', ')}])';
              onSubmitted(
                ExerciseResult(
                  isCorrect: actual == expected,
                  expected: expected,
                  actual: actual,
                  output: _output(code),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ignore: avoid-returning-widgets
  Widget? _output(List<CodeSpan> code) {
    if (code.length >= 5 &&
        code[0].data == 'pd.Series' &&
        code[1].data == '(' &&
        code[2].data == '[' &&
        code[code.length - 2].data == ']' &&
        code[code.length - 1].data == ')') {
      final actualValues = <int>[];
      for (int i = 0; i < code.length - 5; i += 1) {
        final isValue = i % 2 == 0;
        final span = code[i + 3].data;
        if (isValue) {
          final val = int.tryParse(span);
          if (val == null) {
            return null;
          }
          actualValues.add(val);
        } else {
          if (span != ', ') {
            return null;
          }
        }
      }
      return DataFrameTablePreview(
        df: DataFrame.fromLists({'': actualValues}),
      );
    }
    return null;
  }
}
