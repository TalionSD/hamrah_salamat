import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';

import 'package:hamrah_salamat/Features/diet_planning/providers/diet_plan_provider.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/calculate_nutrition_needs_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/custom_time_line.dart';
import 'package:hamrah_salamat/Features/profile/classes/user.dart';

class BmiStatusScreen extends StatefulWidget {
  static const String routeName = '/bmi_status_screen';

  const BmiStatusScreen({
    super.key,
  });

  @override
  State<BmiStatusScreen> createState() => _BmiStatusScreenState();
}

class _BmiStatusScreenState extends State<BmiStatusScreen> {
  User? user;

  List<Map<String, dynamic>> moreWeight = [
    {
      "title": "مقدار کمبود وزن",
      "weight": null,
    },
    {
      "title": "مقدار اضافه وزن",
      "weight": null,
    },
  ];

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      user = ModalRoute.of(context)!.settings.arguments as User;

      DietPlanProvider dietPlanProvider = Provider.of<DietPlanProvider>(context, listen: false);
      if (user != null) {
        dietPlanProvider.getBMIStatus(
          user: User(
            height: user!.height,
            weight: user!.weight,
            age: user!.age,
            gender: user!.gender,
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Consumer<DietPlanProvider>(
      builder: (context, dietPlanProvider, _) {
        moreWeight[0]['weight'] = dietPlanProvider.bmiStatus?.weightLoss;
        moreWeight[1]['weight'] = dietPlanProvider.bmiStatus?.excessWeight;

        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
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
                    stepIndex: 2,
                    onTap: () => Navigator.pushNamed(
                      context,
                      NutritionNeedsScreen.routeName,
                      arguments: User(
                        height: user!.height,
                        weight: user!.weight,
                        age: user!.age,
                        gender: user!.gender,
                        bmiStatus: dietPlanProvider.bmiStatus!.status!,
                        activityLevel: ActivityLevel.noActivity,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: edgeInsetsGeometryOfScreens(context: context),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: width / 30, vertical: height / 50),
                        decoration: BoxDecoration(gradient: linearGradient(context: context), borderRadius: BorderRadius.circular(20)),
                        child: RichText(
                          text: TextSpan(
                            text: 'شاخص توده بدنی : ',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                            children: [
                              TextSpan(
                                text: dietPlanProvider.bmi.toString(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Image(
                        height: height / 3,
                        image: AssetImage(dietPlanProvider.bmiStatus?.imageUrl ?? 'assets/images/common/loading.png'),
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Column(
                        children: [
                          Text(
                            dietPlanProvider.bmiStatus?.status ?? "",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height / 100,
                      ),
                      Text(
                        dietPlanProvider.bmiStatus?.description ?? "",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Wrap(
                        children: List.generate(
                          moreWeight.length,
                          (index) => moreWeight[index]['weight'] != null
                              ? Container(
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Theme.of(context).colorScheme.tertiary,
                                    border: Border.all(color: Theme.of(context).primaryColor),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        moreWeight[index]['title'],
                                        style: Theme.of(context).textTheme.titleSmall,
                                      ),
                                      SizedBox(
                                        height: height / 100,
                                      ),
                                      Text(
                                        '${moreWeight[index]['weight']} کیلوگرم',
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
