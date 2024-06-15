import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/providers/introduction_provider.dart';
import 'package:hamrah_salamat/Features/diet_planning/providers/diet_plan_provider.dart';
import 'package:hamrah_salamat/Features/profile/providers/profile_provider.dart';
import 'package:hamrah_salamat/Features/root/providers/root_provider.dart';
import 'package:hamrah_salamat/Features/targeting/providers/targets_provider.dart';

List<ChangeNotifierProvider> providers = [
  ChangeNotifierProvider<IntroductionProvider>(
    create: (context) => IntroductionProvider(),
  ),
  ChangeNotifierProvider<RootProvider>(
    create: (context) => RootProvider(),
  ),
  ChangeNotifierProvider<ProfileProvider>(
    create: (context) => ProfileProvider(),
  ),
  ChangeNotifierProvider<DietPlanProvider>(
    create: (context) => DietPlanProvider(),
  ),
  ChangeNotifierProvider<TargetsProvider>(
    create: (context) => TargetsProvider(),
  ),
];
