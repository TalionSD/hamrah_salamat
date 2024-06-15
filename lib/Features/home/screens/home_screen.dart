import 'dart:io';

import 'package:animation_list/animation_list.dart';
import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Features/profile/screens/about_us_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/edit_profile_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/help_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/sport_exercises_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/yoga_exercises_screen.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/gradient.dart';
import 'package:hamrah_salamat/Core/common/widgets/loading_data.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/choose_type_of_diet_planning_screen.dart';
import 'package:hamrah_salamat/Features/home/data/articles.dart';
import 'package:hamrah_salamat/Features/home/data/feature_introduction.dart';
import 'package:hamrah_salamat/Features/home/screens/article_view_screen.dart';
import 'package:hamrah_salamat/Features/home/widgets/article_widget.dart';
import 'package:hamrah_salamat/Features/home/widgets/feature_introduction_widget.dart';
import 'package:hamrah_salamat/Features/home/widgets/training_introduction_widget.dart';
import 'package:hamrah_salamat/Features/profile/providers/profile_provider.dart';
import 'package:hamrah_salamat/Features/root/screens/root_screens.dart';
import 'package:hamrah_salamat/Features/targeting/screens/select_category_of_target_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home_screen';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late ProfileProvider _profileProvider;

  @override
  void initState() {
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    Future.delayed(Duration.zero).then((_) {
      _profileProvider.getUser(context: context);
    });
    super.initState();
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  List<Map<String, dynamic>> drawerItems = <Map<String, dynamic>>[
    {
      "title": "دریافت برنامه غذایی",
      "icon": Icons.toc_rounded,
      "route": ChooseTypeOfDietPlanningScreen.routeName,
    },
    {
      "title": "ساخت هدف",
      "icon": Icons.add_box_outlined,
      "route": SelectCategoryOfTargetScreen.routeName,
    },
    {
      "title": "ویرایش پروفایل",
      "icon": Icons.person_pin_circle_outlined,
      "route": EditProfileScreen.routeName,
    },
    {
      "title": "درباره ما",
      "icon": Icons.question_mark_rounded,
      "route": AboutUsScreen.routeName,
    },
    {
      "title": "راهنما",
      "icon": Icons.info_outline_rounded,
      "route": HelpScreen.routeName,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();

        exit(0);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'همراه سلامت',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          surfaceTintColor: Theme.of(context).colorScheme.surface,
          centerTitle: true,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: InkWell(
              onTap: _openEndDrawer,
              child: ShaderMask(
                blendMode: BlendMode.srcATop,
                shaderCallback: (Rect bounds) {
                  return linearGradient(context: context).createShader(bounds);
                },
                child: const Icon(
                  Icons.menu,
                ),
              ),
            ),
          ),
        ),
        key: _scaffoldKey,
        drawer: buildDrawer(),
        body: Consumer<ProfileProvider>(
          builder: (context, profileProvider, _) {
            if (profileProvider.status == AppState.loading) {
              return const LoadingData();
            }
            return AnimationList(
              duration: 500,
              cacheExtent: 100,
              children: [
                SizedBox(
                  height: height / 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    applicationFeatures.length,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: width / 100),
                      child: FeatureIntroductionWidget(
                        title: applicationFeatures[index]['title'],
                        description: applicationFeatures[index]['description'],
                        imageUrl: applicationFeatures[index]['image_url'],
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          RootScreens.routeName,
                          arguments: applicationFeatures[index]['root_item'],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: width / 30, left: width / 30, top: height / 40, bottom: height / 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'مقالات علمی جدید 📃',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: height / 100,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(articles.length, (index) {
                            var article = articles[index];

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5),
                              child: ArticleWidget(
                                author: article['author'],
                                authorImageUrl: article['author_image_url'],
                                title: article['title'],
                                articleImageUrl: article['article_image_url'],
                                uploadDate: article['upload_date'],
                                studyTime: article['study_time'],
                                description: article['description'],
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  ArticleViewScreen.routeName,
                                  arguments: {
                                    "author": article['author'],
                                    "author_image_url": article['author_image_url'],
                                    "title": article['title'],
                                    "article_image_url": article['article_image_url'],
                                    "upload_date": article['upload_date'],
                                    "study_time": article['study_time'],
                                    "description": article['description'],
                                  },
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(
                        height: height / 30,
                      ),
                      Text(
                        'آموزش های مفید برای سلامتی 🌿',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(
                        height: height / 100,
                      ),
                      TrainingIntroductionWidget(
                        lottieUrl: 'assets/lottie/yoga.json',
                        title: 'آموزش های حرفه ای یوگا را در همراه سلامت دنبال کنید',
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        onTap: () => Navigator.pushNamed(
                          context,
                          YogaExercisesScreen.routeName,
                        ),
                      ),
                      SizedBox(
                        height: height / 100,
                      ),
                      TrainingIntroductionWidget(
                        lottieUrl: 'assets/lottie/exercise.json',
                        title: 'تمرینات ورزشی موثر در سلامتی خود را در همراه سلامت دنبال کنید',
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                        onTap: () => Navigator.pushNamed(
                          context,
                          SportExercisesScreen.routeName,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Drawer buildDrawer() {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context, listen: true);
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: width,
                height: height / 5,
                decoration: BoxDecoration(
                  gradient: linearGradient(context: context),
                ),
              ),
              Positioned(
                top: height / 30,
                right: 10,
                child: Row(
                  children: [
                    CircleAvatar(
                      maxRadius: 50,
                      minRadius: 50,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          // right: 10,
                          // left: 10,
                          top: 10,
                        ),
                        child: Image(
                          image: AssetImage(
                            profileProvider.user?.imageUrl ?? 'assets/images/avatars/avatar1.png',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      profileProvider.user?.fullname ?? '',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: List.generate(
              drawerItems.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: ListTile(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      drawerItems[index]['route'],
                      arguments: drawerItems[index]['title'] == "دریافت برنامه غذایی" ? false : null,
                    );
                  },
                  splashColor: Theme.of(context).primaryColor,
                  title: Text(
                    drawerItems[index]['title'],
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  leading: Icon(
                    drawerItems[index]['icon'],
                    size: 30,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
