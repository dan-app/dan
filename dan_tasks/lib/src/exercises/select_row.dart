import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/code.dart';
import '../data/data_frame.dart';
import '../widgets/code_block.dart';
import '../widgets/code_chips_input.dart';
import '../widgets/code_line.dart';
import '../widgets/data_frame_table_preview.dart';
import 'exercise_page.dart';

class SelectRowExercise extends HookWidget {
  final DataFrame df;
  final int rowIndex;
  final ValueChanged<ExerciseResult> onSubmitted;

  const SelectRowExercise({
    required this.df,
    required this.rowIndex,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    useEffect(
      () {
        assert(rowIndex < df.rowsCount);
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
                  text: 'Show row № ${rowIndex + 1} (having index $rowIndex)',
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
              for (final i in {0, 1, 2, rowIndex}) CodeSpan(data: '$i'),
            ],
            onSubmitted: (code) {
              final actual = code.map((span) => span.data).join();
              final expected = 'df[$rowIndex]';
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
    if (code.length == 4) {
      if (code[0].data == 'df' && code[1].data == '[' && code[3].data == ']') {
        final row = int.tryParse(code[2].data);
        if (row != null && 0 <= row && row < df.rowsCount) {
          return DataFrameTablePreview(
            df: df.selectRow(row),
          );
        }
      }
    }
    return null;
  }
}
