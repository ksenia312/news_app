import 'package:flutter/material.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({super.key, this.caption});

  static Widget centered({String? caption}) {
    return Center(
      child: AppProgress(caption: caption),
    );
  }

  final String? caption;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CircularProgressIndicator.adaptive(),
        if (caption != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(caption!),
          ),
      ],
    );
  }
}
