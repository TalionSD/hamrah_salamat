import 'package:flutter/material.dart';

class AboutUsCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String expertise;
  final String skills;
  final List<Map<String, dynamic>> communicationTools;

  const AboutUsCard({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.expertise,
    required this.skills,
    required this.communicationTools,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.tertiary,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Flexible(
            flex: 4,
            fit: FlexFit.tight,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage(imageUrl),
                ),
              ),
            ),
          ),
          const Flexible(flex: 1, fit: FlexFit.tight, child: SizedBox()),
          Flexible(
            flex: 7,
            fit: FlexFit.tight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Divider(
                  color: Theme.of(context).colorScheme.surface,
                ),
                Text(
                  expertise,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(
                  height: height / 100,
                ),
                Text(
                  skills,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // SizedBox(
                //   height: height / 100,
                // ),
                // Wrap(
                //   children: List.generate(
                //     communicationTools.length,
                //     (index) => GestureDetector(
                //       onTap: () {},
                //       child: Icon(
                //         communicationTools[index]['icon'],
                //         color: communicationTools[index]['color'],
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
