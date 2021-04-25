import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../data/code.dart';
import '../styles.dart';

class CodeLine extends StatelessWidget {
  final List<CodeSpan> spans;
  final ValueChanged<CodeSpan>? onPressed;

  const CodeLine({
    required this.spans,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          for (final span in spans)
            TextSpan(
              text: span.data,
              recognizer: TapGestureRecognizer()
                ..onTap = () => onPressed?.call(span),
            ),
        ],
        style: TextStyle(
          fontFamily: fontFamilyMonospace,
        ),
      ),
    );
  }
}
