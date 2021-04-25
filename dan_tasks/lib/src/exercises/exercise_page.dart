import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../styles.dart';

class ExerciseResult {
  final bool isCorrect;
  final String expected;
  final String actual;

  ExerciseResult({
    required this.isCorrect,
    required this.expected,
    required this.actual,
  });
}

class ExercisePage extends HookWidget {
  final Widget Function(BuildContext, ValueChanged<ExerciseResult>) builder;
  final ValueChanged<bool> onDone;

  const ExercisePage({
    required this.builder,
    required this.onDone,
  });

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
              children: [
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
                  title: Text(isCorrect ? 'Отлично!' : 'Правильный ответ:'),
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
                child: Text('Продолжить'),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
