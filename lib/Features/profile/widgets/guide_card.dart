import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';

class GuideCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String question;
  final List<String> stepsAndTips;
  const GuideCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.question,
    required this.stepsAndTips,
  });

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  question,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: height / 30,
                ),
                ...List.generate(
                  stepsAndTips.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        SizedBox(
                          width: width / 2 + 50,
                          child: Text(
                            stepsAndTips[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        width: width / 2 - 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.tertiary,
          border: Border(
            left: BorderSide(color: Theme.of(context).primaryColor),
            right: BorderSide(color: Theme.of(context).primaryColor),
            top: BorderSide(color: Theme.of(context).primaryColor),
          ),
        ),
        child: Column(
          children: [
            Image(
              height: height / 6,
              image: AssetImage(imageUrl),
            ),
            Container(
              alignment: Alignment.center,
              width: width,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: linearGradient(context: context),
              ),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
              ),
            )
          ],
        ),
      ),
    );
  }
}
