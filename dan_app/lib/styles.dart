import 'package:flutter/material.dart';

import 'utils/ui_utils.dart';

extension ThemeDataDanStylesX on ThemeData {
  ThemeData applyDanStyles() {
    return copyWith(
      splashFactory: const NoSplashFactory(),
    );
  }
}
