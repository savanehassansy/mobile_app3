import 'package:flutter/material.dart';
import 'package:jmoov/palette.dart';

class Loading extends StatelessWidget {
  final double? value;

  const Loading({
    super.key,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            color: Palette.accentColor,
            backgroundColor: Palette.primaryColor,
            value: value,
            strokeCap: StrokeCap.round,
          ),
          value != null
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: FittedBox(
                    child: Text(
                      "${(value ?? 0) * 100}%",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
