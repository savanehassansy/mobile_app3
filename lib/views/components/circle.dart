import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jmoov/palette.dart';

class Circle extends StatefulWidget {
  final double? size;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final Color? color;

  const Circle({
    super.key,
    this.size,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.color,
  });

  @override
  State<Circle> createState() => _CircleState();
}

class _CircleState extends State<Circle> {
  bool grow = false;
  final Duration _duration = const Duration(seconds: 3);

  void _animate() {
    Timer.periodic(
      _duration,
      (timer) {
        grow = !grow;
        setState(() {});
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _animate();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top,
      left: widget.left,
      right: widget.right,
      bottom: widget.bottom,
      child: AnimatedContainer(
        duration: _duration,
        height: widget.size ?? 300,
        width: widget.size ?? 300,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: widget.color ?? Palette.accentColor,
            width: grow ? 30 : 15,
          ),
        ),
      ),
    );
  }
}
