import 'package:flutter/material.dart';
import 'package:jmoov/helpers.dart';

class Labelled extends StatelessWidget {
  final String label;
  final Widget child;

  const Labelled({
    super.key,
    required this.child,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    ThemeData t = theme(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: t.textTheme.labelLarge),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
