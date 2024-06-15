import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  final Lottie? lottie;
  final Widget content;
  final Widget? button;

  const EmptyWidget({
    super.key,
    this.lottie,
    required this.content,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          lottie ?? Lottie.asset('assets/lottie/empty.json'),
          const SizedBox(
            height: 20,
          ),
          content,
          const SizedBox(
            height: 10,
          ),
          if (button != null) button!,
        ],
      ),
    );
  }
}
