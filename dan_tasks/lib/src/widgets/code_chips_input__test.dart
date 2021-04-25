import 'package:flutter/material.dart';

import '../data/code.dart';
import 'code_chips_input.dart';

final _exampleSpans = [
  for (int i = 0; i < 5; i += 1)
    for (final s in 'hello world 123 [ ]'.split(' '))
      CodeSpan(
        data: s,
      ),
];

class CodeChipsInputTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CodeChipsInput(
            codeSpans: _exampleSpans,
            onSubmitted: print,
          ),
        ),
      ),
    );
  }
}
