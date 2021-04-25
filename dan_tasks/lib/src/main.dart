import 'package:flutter/material.dart';

import 'styles.dart';
import 'utils/utils.dart';

@visibleForTesting
void main() {
  runApp(App());
}

@visibleForTesting
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => Theme(
        data: Theme.of(context).let(
          (theme) => theme.copyWith(
            textTheme: theme.textTheme.apply(
              fontSizeFactor: 1,
            ),
          ),
        ),
        child: child!,
      ),
      theme: ThemeData.light().applyDanStyles(),
      darkTheme: ThemeData.dark().applyDanStyles(),
      home: HomePage(),
    );
  }
}

@visibleForTesting
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Text('Hi'),
      ),
    );
  }
}
