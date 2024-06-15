import 'package:flutter/material.dart';

LinearGradient linearGradient({required BuildContext context}) {
  return LinearGradient(
    colors: [
      Theme.of(context).colorScheme.primary,
      Theme.of(context).colorScheme.secondary,
    ],
  );
}
