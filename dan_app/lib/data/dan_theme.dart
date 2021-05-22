import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'dan_theme.freezed.dart';

@freezed
class DanTheme with _$DanTheme {
  const factory DanTheme({
    required String id,
    required String name,
    required int tasksCount,
    required IconData icon,
  }) = _DanTheme;
}
