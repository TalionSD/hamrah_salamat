import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';

class FeatureIntroductionWidget extends StatelessWidget {
  final String title;
  final String? description;
  final String imageUrl;
  final void Function()? onTap;
  const FeatureIntroductionWidget({
    super.key,
    required this.title,
    this.description,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: width / 2 - 15,
      height: height / 7 + 25,
      child: Stack(
        children: [
          Container(
            height: height / 7 + 10,
            padding: edgeInsetsGeometryOfScreens(context: context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.tertiary,
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  spreadRadius: 1.5,
                  blurRadius: 4,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Flexible(
                  flex: 8,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      if (description != null) ...[
                        SizedBox(
                          height: height / 100,
                        ),
                        Text(
                          description!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ],
                  ),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Image(
                    height: height / 10,
                    image: AssetImage(imageUrl),
                  ),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: linearGradient(context: context),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: GestureDetector(
                onTap: onTap,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'مشاهده',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 13,
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
