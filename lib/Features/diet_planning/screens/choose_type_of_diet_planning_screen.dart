import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/custom_app_bar.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/choose_deit_plan_pattern_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/loading_for_get_diet_plan_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/view_diet_plan_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/custom_time_line.dart';

class ChooseTypeOfDietPlanningScreen extends StatefulWidget {
  static const String routeName = '/choose_type_of_diet_planning';

  const ChooseTypeOfDietPlanningScreen({super.key});

  @override
  State<ChooseTypeOfDietPlanningScreen> createState() => _ChooseTypeOfDietPlanningScreenState();
}

class _ChooseTypeOfDietPlanningScreenState extends State<ChooseTypeOfDietPlanningScreen> {
  final List<Map<String, dynamic>> plans = <Map<String, dynamic>>[
    {
      "title": 'استفاده از برنامه های پیشفرض',
      'description': 'برنامه های غذایی از پیش نوشته شده مناسب برای افراد با رژیم های مختلف',
      "image_url": "assets/images/diet_planning/template.png",
      "type_of_diet_planing": TypeOfDietPlaning.template,
      "available": true,
    },
    {
      "title": 'ایجاد برنامه غذایی دلخواه',
      'description': 'برنامه غذایی دلخواه خود را تهیه کنید و در همراه سلامت به آسانی آن را مدیریت کنید',
      "image_url": "assets/images/diet_planning/custom.png",
      "type_of_diet_planing": TypeOfDietPlaning.custom,
      "available": true,
    },
    {
      "title": 'تهیه برنامه غذایی با استفاده از هوش مصنوعی',
      'description': 'برنامه غذایی مناسب با کالری مورد نیاز خود را در گروه بندی های غذایی مختلف با استفاده از هوش مصنوعی تهیه کنید',
      "image_url": "assets/images/diet_planning/ai.png",
      "type_of_diet_planing": TypeOfDietPlaning.ai,
      "available": false,
    },
  ];
  bool? showTileLine;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (ModalRoute.of(context)!.settings.arguments != null) {
      showTileLine = ModalRoute.of(context)!.settings.arguments as bool;
    }

    return Scaffold(
      appBar: showTileLine != null ? const CustomAppBar(title: 'انتخاب شیوه برنامه غذایی') : null,
      body: Column(
        children: [
          Visibility(
            visible: (showTileLine == null),
            child: Container(
              padding: edgeInsetsGeometryOfScreens(context: context),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
                    spreadRadius: 1.5,
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: CustomTimeLine(
                stepIndex: 4,
                onTap: () => Navigator.pushNamed(context, ChooseTypeOfDietPlanningScreen.routeName),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: edgeInsetsGeometryOfScreens(context: context),
              child: AnimationList(
                duration: 1500,
                reBounceDepth: 30,
                children: List.generate(
                  plans.length,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: height / 100),
                      child: boxTypeDietPlanning(
                        title: plans[index]['title'],
                        description: plans[index]['description'],
                        imageUrl: plans[index]['image_url'],
                        onTap: () {
                          if (!plans[index]['available']) {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: Wrap(
                                  alignment: WrapAlignment.center,
                                  children: [
                                    const Image(
                                      image: AssetImage('assets/images/common/developing.png'),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height / 50),
                                      child: Text(
                                        'این بخش در حال توسعه می باشد...',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.titleLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top: height / 50),
                                      child: Button(
                                        width: width,
                                        gradient: linearGradient(context: context),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'تایید',
                                          style: Theme.of(context).textTheme.labelMedium,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (plans[index]['type_of_diet_planing'] == TypeOfDietPlaning.template) {
                            Navigator.pushNamed(context, ChooseDietPlanPatternScreen.routeName);
                          } else if (plans[index]['type_of_diet_planing'] == TypeOfDietPlaning.custom) {
                            Navigator.pushNamed(
                              context,
                              LoadingForGetDietPlanScreen.routeName,
                              arguments: {
                                "type_of_diet_planing": TypeOfDietPlaning.custom,
                                "screen": ViewDietPlanScreen.routeName,
                              },
                            );
                          }
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget boxTypeDietPlanning({
    required String title,
    required String description,
    required String imageUrl,
    void Function()? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.topRight,
        padding: edgeInsetsGeometryOfScreens(context: context),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 7,
                  fit: FlexFit.tight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                const Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: SizedBox(),
                ),
                Flexible(
                  flex: 4,
                  fit: FlexFit.tight,
                  child: Image(
                    height: 150,
                    image: AssetImage(imageUrl),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
