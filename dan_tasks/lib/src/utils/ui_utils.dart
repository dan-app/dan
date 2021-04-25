import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

List<ScrollController> useLinkedScrollControllers({
  required int count,
  List<Object?>? keys,
}) {
  return use(
    _LinkedScrollControllersHook(
      count: count,
      keys: keys,
    ),
  );
}

class _LinkedScrollControllersHook extends Hook<List<ScrollController>> {
  final int count;

  const _LinkedScrollControllersHook({
    required this.count,
    List<Object?>? keys,
  }) : super(keys: keys);

  @override
  HookState<List<ScrollController>, Hook<List<ScrollController>>>
      createState() => _ScrollControllerHookState();
}

class _ScrollControllerHookState
    extends HookState<List<ScrollController>, _LinkedScrollControllersHook> {
  late final LinkedScrollControllerGroup _group = LinkedScrollControllerGroup();
  late final List<ScrollController> _controllers = List.generate(
    hook.count,
    (_) => _group.addAndGet(),
  );

  @override
  String get debugLabel => 'useLinkedScrollControllers';

  @override
  List<ScrollController> build(BuildContext context) => _controllers;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
  }
}

class NoSplashFactory extends InteractiveInkFeatureFactory {
  const NoSplashFactory();

  @override
  // ignore: long-parameter-list
  InteractiveInkFeature create({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Offset position,
    required Color color,
    required TextDirection textDirection,
    bool containedInkWell = false,
    RectCallback? rectCallback,
    BorderRadius? borderRadius,
    ShapeBorder? customBorder,
    double? radius,
    VoidCallback? onRemoved,
  }) {
    return _NoSplash(
      controller: controller,
      referenceBox: referenceBox,
      color: color,
      onRemoved: onRemoved,
    );
  }
}

class _NoSplash extends InteractiveInkFeature {
  _NoSplash({
    required MaterialInkController controller,
    required RenderBox referenceBox,
    required Color color,
    VoidCallback? onRemoved,
  }) : super(
          controller: controller,
          referenceBox: referenceBox,
          color: color,
          onRemoved: onRemoved,
        );

  @override
  // ignore: no-empty-block
  void paintFeature(Canvas canvas, Matrix4 transform) {}
}
