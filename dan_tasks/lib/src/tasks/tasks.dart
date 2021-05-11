import 'package:flutter/widgets.dart';

import 'basics/tasks.dart' as basics;

final tasks = <String, List<Widget Function(BuildContext, ValueChanged<bool>)>>{
  'creation': basics.tasks,
};
