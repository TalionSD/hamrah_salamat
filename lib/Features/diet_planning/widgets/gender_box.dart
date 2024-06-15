import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';

class GenderBox extends StatelessWidget {
  final String title;
  final String imageUrl;
  final bool isSelected;
  const GenderBox({super.key, required this.title, required this.imageUrl, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).colorScheme.tertiary,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(20),
            ),
            border: Border(
              left: BorderSide(
                color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.tertiary,
                width: 2,
              ),
              right: BorderSide(
                color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.tertiary,
                width: 2,
              ),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 4,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Transform.scale(
            scale: 1.3,
            child: Image(
              color: !isSelected ? Theme.of(context).colorScheme.onSurface : null,
              height: height / 12,
              image: AssetImage(imageUrl),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: height / 100),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: isSelected
                ? linearGradient(context: context)
                : LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.onSurface,
                      Theme.of(context).colorScheme.onSurface,
                    ],
                  ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                      spreadRadius: 1.5,
                      blurRadius: 4,
                      offset: const Offset(0, 4), 
                    )
                  ]
                : null,
          ),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
      ],
    );
  }
}
