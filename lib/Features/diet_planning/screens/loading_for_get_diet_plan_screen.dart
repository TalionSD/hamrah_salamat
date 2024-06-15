import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hamrah_salamat/Core/common/widgets/loading_data.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Features/diet_planning/providers/diet_plan_provider.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/diet_plan_tracking_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/view_diet_plan_screen.dart';

class LoadingForGetDietPlanScreen extends StatefulWidget {
  static const String routeName = '/loading_for_get_diet_plan_screen';

  const LoadingForGetDietPlanScreen({super.key});

  @override
  State<LoadingForGetDietPlanScreen> createState() => _LoadingForGetDietPlanScreenState();
}

class _LoadingForGetDietPlanScreenState extends State<LoadingForGetDietPlanScreen> {
  late DietPlanProvider _dietPlanProvider;

  @override
  void initState() {
    _dietPlanProvider = Provider.of(context, listen: false);

    Future.delayed(const Duration(seconds: 1)).then((_) {
      Map<String, dynamic> value = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      if (value['screen'] == ViewDietPlanScreen.routeName) {
        if (value['type_of_diet_planing'] == TypeOfDietPlaning.template) {
          _dietPlanProvider.getDietPlanTemplate(
            data: value['template']!,
            context: context,
          );
        }
        _dietPlanProvider.getDietPlan(context: context).then((_) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ViewDietPlanScreen(
                template: value['template'],
                typeOfDietPlaning: value['type_of_diet_planing'],
              ),
            ),
          );
        });
      } else if (value['screen'] == DietPlanTrackingScreen.routeName) {
        _dietPlanProvider.getDietPlanAndCheckStatus(
          context: context,
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LoadingData(),
      ),
    );
  }
}
