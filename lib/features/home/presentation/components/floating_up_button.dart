import 'package:flutter/material.dart';
import 'package:news_app/uikit/app_icons.dart';

class FloatingUpButton extends StatefulWidget {
  const FloatingUpButton({super.key, required this.scrollController});

  final ScrollController scrollController;

  @override
  State<FloatingUpButton> createState() => _FloatingUpButtonState();
}

class _FloatingUpButtonState extends State<FloatingUpButton> {
  @override
  void initState() {
    widget.scrollController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      return widget.scrollController.offset > 100
          ? FloatingActionButton(
              onPressed: _scrollUp,
              child: Icon(AppIcons.arrowUp),
            )
          : const SizedBox.shrink();
    } catch (_) {
      return const SizedBox.shrink();
    }
  }

  void _scrollUp() {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }
}
