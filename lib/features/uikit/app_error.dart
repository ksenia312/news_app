import 'package:flutter/material.dart';

class AppError extends StatelessWidget {
  const AppError({super.key, required this.value});

  static Widget centered({required String value}) {
    return Center(
      child: AppError(
        value: value,
      ),
    );
  }

  final String value;

  @override
  Widget build(BuildContext context) {
    return Text(value);
  }
}
