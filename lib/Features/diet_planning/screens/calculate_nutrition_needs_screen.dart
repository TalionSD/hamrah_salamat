import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Core/common/widgets/loading_data.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/diet_planning/providers/diet_plan_provider.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/choose_type_of_diet_planning_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/custom_time_line.dart';
import 'package:hamrah_salamat/Features/profile/classes/user.dart';

class NutritionNeedsScreen extends StatefulWidget {
  static const String routeName = '/nutrition_needs_screen';

  const NutritionNeedsScreen({super.key});

  @override
  State<NutritionNeedsScreen> createState() => _NutritionNeedsScreenState();
}

class _NutritionNeedsScreenState extends State<NutritionNeedsScreen> {
  late DietPlanProvider _dietPlanProvider;
  User? user;

  int _selectedIndex = 0;

  List<Map<String, dynamic>> nutritionNeeds = [];
  List<Map<String, dynamic>> activities = [
    {
      "title": "بدون فعالیت",
      "value": ActivityLevel.noActivity,
    },
    {
      "title": "انجام فعالیت های سبک و کم",
      "value": ActivityLevel.lowActivity,
    },
    {
      "title": "انجام فعالیت های متوسط مانند ورزش، دویدن و موارد دیگر",
      "value": ActivityLevel.moderateActivity,
    },
    {
      "title": "انجام فعالیت سنگین در طول روز مانند بدنسازی حرفه ای، ورزش سنگین و موارد دیگر",
      "value": ActivityLevel.highActivity,
    },
  ];

  @override
  void initState() {
    _dietPlanProvider = Provider.of<DietPlanProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      user = ModalRoute.of(context)!.settings.arguments as User;

      _dietPlanProvider.calculateNutritionNeeds(
        user: User(
          height: user!.height,
          weight: user!.weight,
          age: user!.age,
          gender: user!.gender,
          bmiStatus: user!.bmiStatus,
          activityLevel: user!.activityLevel,
        ),
      );

      nutritionNeeds = <Map<String, dynamic>>[
        {
          "title": "کالری مورد نیاز روزانه",
          "value": _dietPlanProvider.nutritionNeeds!.calories,
          "image_url": "assets/images/diet_planning/calories.png",
          "color": Colors.redAccent.withOpacity(0.5),
        },
        {
          "title": "کربوهیدرات مورد نیاز روزانه",
          "value": _dietPlanProvider.nutritionNeeds!.carbohydrates,
          "image_url": "assets/images/diet_planning/carbohydrate.png",
          "color": Colors.greenAccent.withOpacity(0.5),
        },
        {
          "title": "پروتئین مورد نیاز روزانه",
          "value": _dietPlanProvider.nutritionNeeds!.protein,
          "image_url": "assets/images/diet_planning/protein.png",
          "color": Colors.cyanAccent.withOpacity(0.5),
        },
        {
          "title": "چربی مورد نیاز روزانه",
          "value": _dietPlanProvider.nutritionNeeds!.lipid,
          "image_url": "assets/images/diet_planning/lipid.png",
          "color": Colors.orangeAccent.withOpacity(0.5),
        },
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<DietPlanProvider>(
        builder: (context, dietPlanProvider, _) {
          if (dietPlanProvider.status == AppState.loading) {
            return const LoadingData();
          }
          return Column(
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
                  stepIndex: 3,
                  onTap: () => Navigator.pushNamed(context, ChooseTypeOfDietPlanningScreen.routeName),
                ),
              ),
              Padding(
                padding: edgeInsetsGeometryOfScreens(context: context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'میزان فعالیت در روز 🏃‍♂️',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          activities.length,
                          (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedIndex = index;

                                _dietPlanProvider.calculateNutritionNeeds(
                                  user: User(
                                    height: user!.height,
                                    weight: user!.weight,
                                    age: user!.age,
                                    gender: user!.gender,
                                    bmiStatus: user!.bmiStatus,
                                    activityLevel: activities[_selectedIndex]['value'],
                                  ),
                                );

                                nutritionNeeds[0]['value'] = dietPlanProvider.nutritionNeeds!.calories;
                                nutritionNeeds[1]['value'] = dietPlanProvider.nutritionNeeds!.carbohydrates;
                                nutritionNeeds[2]['value'] = dietPlanProvider.nutritionNeeds!.protein;
                                nutritionNeeds[3]['value'] = dietPlanProvider.nutritionNeeds!.lipid;
                              });
                            },
                            child: Container(
                              width: width / 3,
                              height: height / 5 + 10,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: _selectedIndex == index ? Theme.of(context).primaryColor.withOpacity(0.1) : Theme.of(context).colorScheme.tertiary,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                  color: _selectedIndex == index ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.tertiary,
                                  width: 2,
                                ),
                                boxShadow: _selectedIndex == index
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
                              child: Text(
                                activities[index]['title'],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height / 50,
                    ),
                    Text(
                      'نیازهای روزانه بدن شما 💪',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: height / 100,
                    ),
                    SizedBox(
                      height: height / 2 - 40,
                      child: GridView.builder(
                        itemCount: nutritionNeeds.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: nutritionNeeds[index]['color'],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                clipBehavior: Clip.hardEdge,
                                padding: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: Image(
                                  height: height / 10,
                                  image: AssetImage(
                                    nutritionNeeds[index]['image_url'],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Text(
                                    nutritionNeeds[index]['title'],
                                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    nutritionNeeds[index]['value'],
                                    style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
