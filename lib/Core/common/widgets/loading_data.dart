import 'package:flutter/material.dart';

class LoadingData extends StatelessWidget {
  const LoadingData({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.surface.withAlpha(30),
              blurRadius: 20,
              spreadRadius: 10,
            )
          ],
        ),
        child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
          backgroundColor: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}
