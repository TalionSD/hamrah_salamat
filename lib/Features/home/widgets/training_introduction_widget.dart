import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';

class TrainingIntroductionWidget extends StatelessWidget {
  final String lottieUrl;
  final String title;
  final String? description;
  final Color color;
  final void Function()? onTap;
  final double? lottieScale;
  const TrainingIntroductionWidget({
    super.key,
    required this.lottieUrl,
    required this.title,
    required this.color,
    this.onTap,
    this.description,
    this.lottieScale,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: width / 50, vertical: height / 80),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.tertiary,
        ),
        child: Row(
          children: [
            Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: color,
                ),
                child: Transform.scale(
                  scale: lottieScale ?? 1.5,
                  child: Lottie.asset(lottieUrl),
                ),
              ),
            ),
            Flexible(
              flex: 7,
              fit: FlexFit.tight,
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    if (description != null) ...[
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        description!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyMedium,
                      )
                    ],
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              fit: FlexFit.tight,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: linearGradient(context: context),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
