import 'dart:math';

import 'package:flutter/material.dart';

class WavyLine extends StatefulWidget {
  final Gradient gradient;
  final double? begin;
  final double? end;
  final int seconds;

  const WavyLine({super.key, required this.gradient, this.begin, this.end, required this.seconds});

  @override
  State<WavyLine> createState() => _WavyLineState();
}

class _WavyLineState extends State<WavyLine> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.seconds),
    )..repeat(reverse: false);
    _animation = Tween<double>(begin: widget.begin, end: widget.end).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipPath(
          clipper: WavyLineClipper(_animation.value),
          child: Container(
            decoration: BoxDecoration(
              // color: widget.color,
              gradient: widget.gradient,
            ),
            width: MediaQuery.of(context).size.width,
            height: 130,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class WavyLineClipper extends CustomClipper<Path> {
  final double animationValue;

  WavyLineClipper(this.animationValue);

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, size.height / 2);
    for (double i = 0; i < size.width; i++) {
      path.lineTo(i, size.height / 2 + 20 * sin((i / size.width * 2 * pi) + (animationValue * 2 * pi)));
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WavyLineClipper oldClipper) => true;
}
