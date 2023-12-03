import 'package:flutter/material.dart';

class AppBottomSheet {
  AppBottomSheet._();

  static const shape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(16),
    ),
  );

  static Future<T?> show<T>(
    BuildContext context, {
    required AnimationController controller,
    required Widget Function(BuildContext) builder,
  }) {
    return showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      useSafeArea: true,
      isScrollControlled: true,
      transitionAnimationController: controller,
      shape: shape,
      builder: builder,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height - 50,
      ),
    );
  }
}

class BottomSheetControllerBuilder extends StatefulWidget {
  const BottomSheetControllerBuilder({super.key, required this.builder});

  final Widget Function(BuildContext, AnimationController) builder;

  @override
  State<BottomSheetControllerBuilder> createState() =>
      _BottomSheetControllerBuilderState();
}

class _BottomSheetControllerBuilderState
    extends State<BottomSheetControllerBuilder>
    with SingleTickerProviderStateMixin {
  late final controller = BottomSheet.createAnimationController(this)
    ..duration = const Duration(milliseconds: 500);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, controller);
  }
}
