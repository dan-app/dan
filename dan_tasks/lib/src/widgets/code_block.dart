import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CodeBlock extends StatelessWidget {
  final Widget code;
  final Widget? trailing;

  const CodeBlock({
    required this.code,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).textTheme.bodyText1!.color!;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: textColor.withOpacity(.05),
        border: Border.all(
          width: 0,
          color: textColor.withOpacity(.2),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12),
            child: code,
          ),
          if (trailing != null)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: trailing,
            ),
        ],
      ),
    );
  }
}
