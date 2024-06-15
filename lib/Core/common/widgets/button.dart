import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';

class Button extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final Gradient? gradient;
  final VoidCallback? onPressed;
  final Widget child;
  final Color? boxShadowColor;
  final Color? foregroundColor;

  const Button({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width,
    this.gradient,
    this.boxShadowColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(12);
    final gradient = this.gradient ?? linearGradient(context: context);
    return Container(
      width: width,
      height: 48,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: borderRadius,
        boxShadow: [
          BoxShadow(
            color: boxShadowColor ?? Theme.of(context).colorScheme.secondary.withOpacity(0.2),
            spreadRadius: 1.5,
            blurRadius: 4,
            offset: const Offset(0, 4), // shadow position vertically
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.tertiary,
        ),
        child: child,
      ),
    );
  }
}
