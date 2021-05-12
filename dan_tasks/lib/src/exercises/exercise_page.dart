import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/code.dart';
import '../styles.dart';
import '../widgets/code_block.dart';
import '../widgets/code_line.dart';

class ExerciseResult {
  final bool isCorrect;
  final String expected;
  final String actual;
  final Widget? output;

  ExerciseResult({
    required this.isCorrect,
    required this.expected,
    required this.actual,
    required this.output,
  });
}

typedef ExerciseBuilder = Widget Function(
  BuildContext,
  ValueChanged<ExerciseResult>,
);

class ExercisePage extends HookWidget {
  final ExerciseBuilder builder;
  final ValueChanged<bool> onDone;

  const ExercisePage({
    Key? key,
    required this.builder,
    required this.onDone,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final resultState = useState<ExerciseResult?>(null);
    final result = resultState.value;
    return Scaffold(
      body: builder(
        context,
        (result) => resultState.value = result,
      ),
      bottomSheet: result == null
          ? null
          : ExerciseResultBottomSheet(
              data: result,
              onContinuePressed: () => onDone(result.isCorrect),
            ),
    );
  }
}

class ExerciseResultBottomSheet extends StatelessWidget {
  final ExerciseResult data;
  final VoidCallback onContinuePressed;

  const ExerciseResultBottomSheet({
    required this.data,
    required this.onContinuePressed,
  });

  @override
  Widget build(BuildContext context) {
    final isCorrect = data.isCorrect;
    final output = data.output;
    final baseColor = isCorrect ? Colors.green : Colors.red;
    return ColoredBox(
      color: baseColor.withOpacity(.5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: 72,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (output != null) ...[
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Your code output is:',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: CodeBlock(
                      code: CodeLine(
                        spans: [CodeSpan(data: data.actual)],
                      ),
                    ),
                  ),
                  output,
                ],
                ListTile(
                  leading: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 40,
                      minWidth: 40,
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).canvasColor,
                      ),
                      child: Icon(
                        isCorrect ? Icons.check : Icons.close,
                        color: baseColor,
                      ),
                    ),
                  ),
                  title: Text(isCorrect ? 'Right!' : 'The right answer is:'),
                  subtitle: isCorrect
                      ? null
                      : Text(
                          data.expected,
                          style: TextStyle(fontFamily: fontFamilyMonospace),
                        ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                borderRadius: BorderRadius.circular(4),
                color: baseColor,
                onPressed: onContinuePressed,
                child: Text('Continue'),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
