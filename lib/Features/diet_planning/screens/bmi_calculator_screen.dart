import 'package:flutter/material.dart';

import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/utils/translator.dart';
import 'package:hamrah_salamat/Core/common/widgets/edge_insets_geometry.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/common/widgets/snack_bar.dart';

import 'package:hamrah_salamat/Features/diet_planning/screens/bmi_status_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/custom_time_line.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/gender_box.dart';
import 'package:hamrah_salamat/Features/diet_planning/widgets/height_gauge.dart';
import 'package:hamrah_salamat/Features/profile/classes/user.dart';
import 'package:vertical_weight_slider/vertical_weight_slider.dart';

class BmiCalculatorScreen extends StatefulWidget {
  static const String routeName = '/bmi_calculator_screen';

  const BmiCalculatorScreen({super.key});

  @override
  State<BmiCalculatorScreen> createState() => _BmiCalculatorScreenState();
}

class _BmiCalculatorScreenState extends State<BmiCalculatorScreen> {
  late WeightSliderController _controller;

  int _selectedIndex = 0;
  double heightPerson = 150;
  double weightPerson = 50;
  int agePerson = 20;

  @override
  void initState() {
    _controller = WeightSliderController(
      initialWeight: weightPerson,
      minWeight: 10,
      interval: 0.1,
      maxWeight: 200,
    );
    super.initState();
  }

  final List<Map<String, dynamic>> genders = <Map<String, dynamic>>[
    {
      "gender": Gender.male,
      "image_url": "assets/images/genders/male.png",
    },
    {
      "gender": Gender.female,
      "image_url": "assets/images/genders/female.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
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
              stepIndex: 1,
              onTap: () => Navigator.pushNamed(
                context,
                BmiStatusScreen.routeName,
                arguments: User(
                  height: heightPerson,
                  weight: weightPerson,
                  age: agePerson,
                  gender: genders[_selectedIndex]['gender'] == Gender.female ? 'خانم' : 'آقا',
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width / 60, vertical: height / 40),
            child: Column(
              children: [
                Row(
                  children: genders.map((gen) {
                    int index = genders.indexOf(gen);
                    bool isSelected = _selectedIndex == index;

                    return Flexible(
                      flex: 6,
                      fit: FlexFit.tight,
                      child: GestureDetector(
                        onTap: () => setState(() {
                          _selectedIndex = index;
                        }),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: GenderBox(
                            title: Translation.translator[gen['gender']]!,
                            imageUrl: gen['image_url'],
                            isSelected: isSelected,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: height / 50,
                ),
                SizedBox(
                  height: height * 0.5 + 20,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Flexible(
                          flex: 10,
                          fit: FlexFit.tight,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'قد : ',
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    Text(
                                      '${heightPerson.toString().split('.')[0]} سانتی متر',
                                      style: Theme.of(context).textTheme.titleSmall,
                                    ),
                                  ],
                                ),
                                HeightGauge(
                                  context: context,
                                  value: heightPerson,
                                  onChanged: (newHeight) {
                                    setState(() {
                                      heightPerson = newHeight;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Flexible(
                          flex: 1,
                          fit: FlexFit.tight,
                          child: SizedBox(),
                        ),
                        Flexible(
                          flex: 10,
                          fit: FlexFit.tight,
                          child: Column(
                            children: [
                              Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: Container(
                                  width: width,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.tertiary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'وزن : ',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                          Text(
                                            '${weightPerson.toStringAsFixed(1)} کیلوگرم',
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                        ],
                                      ),
                                      LimitedBox(
                                        maxHeight: height / 10,
                                        child: VerticalWeightSlider(
                                          controller: _controller,
                                          isVertical: false,
                                          decoration: PointerDecoration(
                                            width: 100.0,
                                            height: 3.0,
                                            largeColor: Theme.of(context).colorScheme.surface,
                                            mediumColor: Theme.of(context).colorScheme.onSurface,
                                            smallColor: Theme.of(context).colorScheme.onSurface.withOpacity(0.4),
                                            gap: 30.0,
                                          ),
                                          onChanged: (double value) {
                                            setState(() {
                                              weightPerson = value;
                                            });
                                          },
                                          indicator: Container(
                                            height: 3.0,
                                            width: 100.0,
                                            alignment: Alignment.centerLeft,
                                            decoration: BoxDecoration(
                                              gradient: linearGradient(context: context),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const Flexible(
                                flex: 2,
                                fit: FlexFit.tight,
                                child: SizedBox(),
                              ),
                              Flexible(
                                flex: 5,
                                fit: FlexFit.tight,
                                child: Container(
                                  width: width,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.tertiary,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Wrap(
                                        children: [
                                          Text(
                                            'سن : ',
                                            style: Theme.of(context).textTheme.bodyMedium,
                                          ),
                                          Text(
                                            '$agePerson سال',
                                            style: Theme.of(context).textTheme.titleSmall,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          increaseAndDecreaseAgeButton(
                                            context: context,
                                            child: Icon(
                                              Icons.add_sharp,
                                              color: Theme.of(context).colorScheme.tertiary,
                                            ),
                                            onTap: () {
                                              if (agePerson < 60) {
                                                setState(() {
                                                  agePerson++;
                                                });
                                              } else {
                                                showSnackBar(context, message: 'بیشتر از این مقدار مجاز نمیباشد', snackbarType: SnackBarType.error);
                                              }
                                            },
                                          ),
                                          increaseAndDecreaseAgeButton(
                                            context: context,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                bottom: 13,
                                              ),
                                              child: Icon(
                                                Icons.minimize_outlined,
                                                color: Theme.of(context).colorScheme.tertiary,
                                              ),
                                            ),
                                            onTap: () {
                                              if (agePerson > 3) {
                                                setState(() {
                                                  agePerson--;
                                                });
                                              } else {
                                                showSnackBar(context, message: 'کمتر از این مقدار مجاز نمیباشد', snackbarType: SnackBarType.error);
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height / 50,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container increaseAndDecreaseAgeButton({
    required BuildContext context,
    required Widget child,
    required void Function()? onTap,
  }) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: linearGradient(context: context),
        // shape: BoxShape.circle,
      ),
      child: GestureDetector(
        onLongPress: onTap,
        onTap: onTap,
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
