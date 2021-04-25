import 'dart:io';

import 'package:flutter/material.dart';

import 'utils/ui_utils.dart';

// https://github.com/flutter/flutter/issues/19280#issuecomment-569907178
final fontFamilyMonospace = Platform.isIOS
    ? 'Menlo' // or 'Courier'
    : 'monospace';

@visibleForTesting
extension ThemeDataDanStylesX on ThemeData {
  ThemeData applyDanStyles() {
    return copyWith(
      splashFactory: const NoSplashFactory(),
    );
  }
}
