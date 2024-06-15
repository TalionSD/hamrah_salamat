import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/custom_app_bar.dart';

import 'package:hamrah_salamat/Features/profile/data/guide.dart';
import 'package:hamrah_salamat/Features/profile/widgets/guide_card.dart';

class HelpScreen extends StatelessWidget {
  static const String routeName = '/hepl_screen';

  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: const CustomAppBar(title: 'راهنما'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 30),
        child: AnimationList(
          duration: 1500,
          reBounceDepth: 30,
          cacheExtent: 50,
          children: List.generate(
            guide.length,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height / 100),
                child: GuideCard(
                  title: guide[index]['title'],
                  imageUrl: guide[index]['image_url'],
                  question: guide[index]['question'],
                  stepsAndTips: guide[index]['steps_and_tips'],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
