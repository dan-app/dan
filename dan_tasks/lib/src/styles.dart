import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'utils/ui_utils.dart';

// https://github.com/flutter/flutter/issues/19280#issuecomment-569907178
final fontFamilyMonospace = kIsWeb
    ? 'TODO'
    : defaultTargetPlatform == TargetPlatform.iOS
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
