import 'package:flutter/widgets.dart';

import 'task_0.dart';

final tasks = <Widget Function(BuildContext, ValueChanged<bool>)>[
  (context, onDone) => Task0(onDone: onDone),
  (context, onDone) => Task0(onDone: onDone),
  (context, onDone) => Task0(onDone: onDone),
];
