import 'package:flutter/material.dart';

import '../data/code.dart';
import '../styles.dart';

class CodeChips extends StatelessWidget {
  final Map<CodeSpan, bool> spans;
  final ValueChanged<CodeSpan> onPressed;

  const CodeChips({
    required this.spans,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = Color.lerp(theme.canvasColor, theme.dividerColor, 0.2)!;
    final textColor = theme.textTheme.bodyText1!.color!;
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.center,
      children: [
        for (final span in spans.entries)
          IgnorePointer(
            ignoring: span.value,
            child: ActionChip(
              backgroundColor: Colors.transparent,
              side: BorderSide(
                color: borderColor,
                width: 0,
              ),
              elevation: 1,
              pressElevation: 0.5,
              label: Text(
                span.key.data,
                style: TextStyle(
                  fontFamily: fontFamilyMonospace,
                  color: textColor.withOpacity(span.value ? 0.1 : 1),
                ),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onPressed: () {
                if (!span.value) {
                  onPressed(span.key);
                }
              },
            ),
          ),
      ],
    );
  }
}
