import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Features/profile/screens/help_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/sport_exercises_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/yoga_exercises_screen.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/common/widgets/loading_data.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/diet_plan_tracking_screen.dart';
import 'package:hamrah_salamat/Features/profile/providers/profile_provider.dart';
import 'package:hamrah_salamat/Features/profile/screens/about_us_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/loading_for_get_diet_plan_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/edit_profile_screen.dart';
import 'package:hamrah_salamat/Features/profile/widgets/wavy_line.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile_screen';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileProvider _profileProvider;

  bool _isVisibleBox = false;
  bool _isVisibleTxet = false;

  Timer? timerBox;
  Timer? timerText;

  final List<Map<String, dynamic>> profileItems = [
    {
      "title": "ویرایش پروفایل",
      "icon": Icons.person_pin_circle_outlined,
      "icon_bg_color": Colors.amberAccent,
      "route": EditProfileScreen.routeName,
    },
    {
      "title": "برنامه غذایی من",
      "icon": Icons.toc_rounded,
      "icon_bg_color": Colors.greenAccent,
      "route": LoadingForGetDietPlanScreen.routeName,
    },
    {
      "title": "درباره ما",
      "icon": Icons.question_mark_rounded,
      "icon_bg_color": Colors.cyanAccent,
      "route": AboutUsScreen.routeName,
    },
    {
      "title": "راهنما",
      "icon": Icons.info_outline_rounded,
      "icon_bg_color": Colors.pinkAccent,
      "route": HelpScreen.routeName,
    },
    {
      "title": "تمرینات یوگا",
      "icon": Icons.accessibility_new_rounded,
      "icon_bg_color": Colors.lightGreenAccent,
      "route": YogaExercisesScreen.routeName,
    },
    {
      "title": "تمرینات ورزشی",
      "icon": Icons.info_outline_rounded,
      "icon_bg_color": Colors.lightBlue.shade100,
      "route": SportExercisesScreen.routeName,
    },
  ];

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      _profileProvider.getUser(context: context);
    });

    timerBox = Timer(const Duration(milliseconds: 150), () {
      setState(() {
        _isVisibleBox = true;
      });
    });
    timerBox = Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        _isVisibleTxet = true;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    timerBox?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, _) {
          if (profileProvider.status == AppState.loading) {
            return const LoadingData();
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: height / 3 - 50,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: height / 5,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                          ),
                        ),
                      ),
                      Positioned(
                        top: height / 20,
                        left: 0,
                        right: 0,
                        child: Stack(
                          children: [
                            WavyLine(
                              gradient: linearGradient(context: context),
                              begin: 0,
                              end: 2,
                              seconds: 5,
                            ),
                            WavyLine(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor,
                                  Theme.of(context).colorScheme.surface,
                                ],
                              ),
                              begin: 2,
                              end: 6,
                              seconds: 6,
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: height / 9,
                        right: 0,
                        left: 0,
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          padding: EdgeInsets.only(top: height / 50),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).colorScheme.surface,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.surface.withOpacity(0.3),
                                spreadRadius: 1.5,
                                blurRadius: 4,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Image(
                            height: height / 8,
                            image: AssetImage(profileProvider.user?.imageUrl ?? 'assets/images/common/loading.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  profileProvider.user?.fullname ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(
                  height: height / 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 110),
                  child: Wrap(
                    children: List.generate(
                      profileItems.length,
                      (index) => GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          profileItems[index]['route'],
                          arguments: profileItems[index]['route'] == LoadingForGetDietPlanScreen.routeName
                              ? {
                                  "screen": DietPlanTrackingScreen.routeName,
                                }
                              : null,
                        ),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeInOut,
                          width: _isVisibleBox ? width - width / 2 - 20 : 0,
                          margin: const EdgeInsets.all(10),
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.topCenter,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            gradient: linearGradient(context: context),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: profileItems[index]['icon_bg_color'],
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  profileItems[index]['icon'],
                                  size: 45,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              SizedBox(
                                height: height / 50,
                              ),
                              if (_isVisibleTxet)
                                Text(
                                  profileItems[index]['title'],
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.tertiary),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
