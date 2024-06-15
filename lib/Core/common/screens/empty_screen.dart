import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hamrah_salamat/Core/common/widgets/empty_widget.dart';

class EmptyScreen extends StatelessWidget {
  final Widget content;
  final Widget? button;
  final Lottie? lottie;

  const EmptyScreen({
    super.key,
    required this.content,
    this.button,
    this.lottie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EmptyWidget(
        content: content,
        button: button,
        lottie: lottie,
      ),
    );
  }
}
