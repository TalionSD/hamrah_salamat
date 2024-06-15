import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/screens/error_screen.dart';

import 'package:hamrah_salamat/Features/diet_planning/screens/bmi_calculator_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/bmi_status_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/calculate_nutrition_needs_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/choose_deit_plan_pattern_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/choose_type_of_diet_planning_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/diet_plan_tracking_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/view_diet_plan_screen.dart';
import 'package:hamrah_salamat/Features/home/screens/article_view_screen.dart';
import 'package:hamrah_salamat/Features/home/screens/home_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/help_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/sport_and_yoga_training_view_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/about_us_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/loading_for_get_diet_plan_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/edit_profile_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/profile_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/sport_exercises_screen.dart';
import 'package:hamrah_salamat/Features/profile/screens/yoga_exercises_screen.dart';
import 'package:hamrah_salamat/Features/root/screens/intro_screens.dart';
import 'package:hamrah_salamat/Features/root/screens/login_screen.dart';
import 'package:hamrah_salamat/Features/root/screens/root_screens.dart';
import 'package:hamrah_salamat/Features/root/screens/splash_screen.dart';
import 'package:hamrah_salamat/Features/targeting/screens/completing_target_build_information_screen.dart';
import 'package:hamrah_salamat/Features/targeting/screens/select_category_of_target_screen.dart';
import 'package:hamrah_salamat/Features/targeting/screens/select_tags_of_target_screen.dart';
import 'package:hamrah_salamat/Features/targeting/screens/target_details_screen.dart';

final Map<String, WidgetBuilder> routes = {
  IntroScreens.routeName: (context) => const IntroScreens(),
  RootScreens.routeName: (context) => const RootScreens(),
  BmiStatusScreen.routeName: (context) => const BmiStatusScreen(),
  SelectCategoryOfTargetScreen.routeName: (context) => const SelectCategoryOfTargetScreen(),
  SelectTagsOfTargetScreen.routeName: (context) => const SelectTagsOfTargetScreen(),
  CompletingTargetBuildInformationScreen.routeName: (context) => const CompletingTargetBuildInformationScreen(),
  ViewDietPlanScreen.routeName: (context) => const ViewDietPlanScreen(),
  ChooseTypeOfDietPlanningScreen.routeName: (context) => const ChooseTypeOfDietPlanningScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  DietPlanTrackingScreen.routeName: (context) => const DietPlanTrackingScreen(),
  BmiCalculatorScreen.routeName: (context) => const BmiCalculatorScreen(),
  ChooseDietPlanPatternScreen.routeName: (context) => const ChooseDietPlanPatternScreen(),
  TargetDetailsScreen.routeName: (context) => const TargetDetailsScreen(),
  EditProfileScreen.routeName: (context) => const EditProfileScreen(),
  ArticleViewScreen.routeName: (context) => const ArticleViewScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  NutritionNeedsScreen.routeName: (context) => const NutritionNeedsScreen(),
  SplashScreen.routeName: (context) => const SplashScreen(),
  YogaExercisesScreen.routeName: (context) => const YogaExercisesScreen(),
  AboutUsScreen.routeName: (context) => const AboutUsScreen(),
  LoadingForGetDietPlanScreen.routeName: (context) => const LoadingForGetDietPlanScreen(),
  SportExercisesScreen.routeName: (context) => const SportExercisesScreen(),
  SportAndYogaTrainingViewScreen.routeName: (context) => const SportAndYogaTrainingViewScreen(),
  HelpScreen.routeName: (context) => const HelpScreen(),
  ErrorScreen.routeName: (context) => const ErrorScreen(),
};

void navigateToErrorPage({
  required BuildContext context,
}) {
  Navigator.pushReplacementNamed(context, ErrorScreen.routeName);
}
