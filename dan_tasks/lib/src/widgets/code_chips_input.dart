import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../data/code.dart';
import '../utils/utils.dart';
import '../widgets/code_block.dart';
import 'code_chips.dart';
import 'code_line.dart';

class CodeChipsInputState {
  final List<CodeSpan> code;
  final Map<CodeSpan, bool> spans;

  CodeChipsInputState({
    required this.code,
    required this.spans,
  });

  factory CodeChipsInputState.initial(List<CodeSpan> codeSpans) {
    return CodeChipsInputState(
      code: <CodeSpan>[],
      spans: Map.fromEntries(
        codeSpans.map((span) => MapEntry(span, false)),
      ),
    );
  }
}

class CodeChipsInputAction {
  final CodeSpan span;
  final bool taken;

  CodeChipsInputAction({
    required this.span,
    required this.taken,
  });
}

CodeChipsInputState codeChipsInputReducer(
  CodeChipsInputState state,
  CodeChipsInputAction action,
) {
  return CodeChipsInputState(
    code: List<CodeSpan>.of(state.code)
      ..let((_) => action.taken ? _.add : _.remove)(action.span),
    spans: Map.of(state.spans)..[action.span] = action.taken,
  );
}

Store<CodeChipsInputState, CodeChipsInputAction?> useCodeChipsInput(
  List<CodeSpan> codeSpans,
) {
  return useReducer<CodeChipsInputState, CodeChipsInputAction?>(
    (state, action) {
      if (action == null) {
        return state;
      }
      return codeChipsInputReducer(state, action);
    },
    initialState: CodeChipsInputState.initial(codeSpans),
    initialAction: null,
  );
}

class CodeChipsInput extends HookWidget {
  final List<CodeSpan> codeSpans;
  final ValueSetter<List<CodeSpan>> onSubmitted;

  const CodeChipsInput({
    required this.codeSpans,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    final store = useCodeChipsInput(codeSpans);
    final canSubmit = store.state.code.isNotEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        CodeBlock(
          code: CodeLine(
            spans: store.state.code,
            onPressed: (span) => store.dispatch(
              CodeChipsInputAction(
                span: span,
                taken: false,
              ),
            ),
          ),
          trailing: CupertinoButton(
            onPressed: canSubmit ? () => onSubmitted(store.state.code) : null,
            minSize: 40,
            padding: EdgeInsets.zero,
            child: Icon(
              Icons.play_arrow,
              color: canSubmit ? Colors.green : Colors.grey,
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        CodeChips(
          spans: store.state.spans,
          onPressed: (span) => store.dispatch(
            CodeChipsInputAction(
              span: span,
              taken: true,
            ),
          ),
        ),
      ],
    );
  }
}
