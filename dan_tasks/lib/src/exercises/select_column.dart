import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/code.dart';
import '../data/data_frame.dart';
import '../widgets/code_block.dart';
import '../widgets/code_chips_input.dart';
import '../widgets/code_line.dart';
import '../widgets/data_frame_table_preview.dart';
import 'exercise_page.dart';

class SelectColumnExercise extends HookWidget {
  final DataFrame df;
  final String column;
  final ValueChanged<ExerciseResult> onSubmitted;

  const SelectColumnExercise({
    required this.df,
    required this.column,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        assert(df.columns.contains(column));
      },
      [],
    );
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text('Given a DataFrame'),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CodeBlock(
            code: CodeLine(
              spans: [CodeSpan(data: 'df')],
            ),
          ),
        ),
        DataFrameTablePreview(df: df),
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
                  text: 'Show column named "$column"',
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: CodeChipsInput(
            codeSpans: [
              CodeSpan(data: 'df'),
              CodeSpan(data: '['),
              CodeSpan(data: ']'),
              CodeSpan(data: '('),
              CodeSpan(data: ')'),
              for (final column in Set.of(
                df.columns.take(3).followedBy([column]),
              ))
                CodeSpan(data: "'$column'"),
            ],
            onSubmitted: (code) {
              final actual = code.map((span) => span.data).join();
              final expected = "df['$column']";
              onSubmitted(
                ExerciseResult(
                  isCorrect: actual == expected,
                  expected: expected,
                  actual: actual,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
