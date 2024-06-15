import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/custom_app_bar.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Features/diet_planning/data/diet_plan_templates.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/loading_for_get_diet_plan_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/view_diet_plan_screen.dart';

class ChooseDietPlanPatternScreen extends StatelessWidget {
  static const String routeName = '/choose_diet_plan_pattern_screen';

  const ChooseDietPlanPatternScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    List<Map<String, dynamic>> deitPlanCategories = [
      {
        "title": "برنامه غذایی مناسب برای افراد دارای اضافه وزن",
        "image_url": "assets/images/diet_planning/fat.png",
        "color": Colors.blue.withOpacity(0.5),
        "template": dietPlanForObesePeople,
      },
      {
        "title": "برنامه غذایی مناسب برای تثبیت وزن",
        "image_url": "assets/images/diet_planning/normal.png",
        "color": Colors.green.withOpacity(0.5),
        "template": dietPlanForWeightStabilization,
      },
      {
        "title": "برنامه غذایی مناسب برای افراد دارای کمبود وزن",
        "image_url": "assets/images/diet_planning/thin.png",
        "color": Colors.amber.withOpacity(0.5),
        "template": dietPlanForThinPeople,
      }
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'انتخاب برنامه غذایی'),
      body: Padding(
        padding: edgeInsetsGeometryOfScreens(context: context),
        child: AnimationList(
          duration: 1500,
          reBounceDepth: 30,
          children: List.generate(
            deitPlanCategories.length,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: height / 100),
                child: dietPlanPattern(
                  context: context,
                  title: deitPlanCategories[index]['title'],
                  imageUrl: deitPlanCategories[index]['image_url'],
                  color: deitPlanCategories[index]['color'],
                  onTap: () => Navigator.pushNamed(
                    context,
                    LoadingForGetDietPlanScreen.routeName,
                    arguments: {
                      "type_of_diet_planing": TypeOfDietPlaning.template,
                      "template": deitPlanCategories[index]['template'],
                      "screen": ViewDietPlanScreen.routeName,
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget dietPlanPattern({
    required BuildContext context,
    required String title,
    required String imageUrl,
    required Color color,
    void Function()? onTap,
  }) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 100,
                  color: color,
                ),
                Padding(
                  padding: edgeInsetsGeometryOfScreens(context: context),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: width / 20),
              child: Image(
                height: height / 10,
                image: AssetImage(imageUrl),
              ),
            )
          ],
        ),
      ),
    );
  }
}
