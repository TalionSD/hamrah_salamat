// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hamrah_salamat/Core/common/screens/empty_screen.dart';
import 'package:hamrah_salamat/Core/common/widgets/button.dart';
import 'package:hamrah_salamat/Core/common/widgets/snack_bar.dart';
import 'package:hamrah_salamat/Core/configs/routes.dart';
import 'package:hamrah_salamat/Core/utils/enums.dart';
import 'package:hamrah_salamat/Database/database.dart';
import 'package:hamrah_salamat/Features/diet_planning/classes/bmi_status.dart';
import 'package:hamrah_salamat/Features/diet_planning/classes/diet_plan.dart';
import 'package:hamrah_salamat/Features/diet_planning/classes/nutrition_need.dart';
import 'package:hamrah_salamat/Features/diet_planning/controllers/bmi_controller.dart';
import 'package:hamrah_salamat/Features/diet_planning/controllers/bmr_controller.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/choose_type_of_diet_planning_screen.dart';
import 'package:hamrah_salamat/Features/diet_planning/screens/diet_plan_tracking_screen.dart';

import 'package:hamrah_salamat/Features/profile/classes/user.dart';
import 'package:hamrah_salamat/Features/root/screens/root_screens.dart';

class DietPlanProvider with ChangeNotifier {
  late BMIController _bmiController;
  late BMRController _bmrController;
  late DatabaseHelper _databaseHelper;

  DietPlanProvider() {
    initializeData();
  }

  initializeData() {
    _bmiController = BMIController();
    _bmrController = BMRController();
    _databaseHelper = DatabaseHelper();
  }

  AppState _status = AppState.stable;
  AppState get status => _status;

  double? _bmi;
  double? get bmi => _bmi;

  BmiStatus? _bmiStatus;
  BmiStatus? get bmiStatus => _bmiStatus;

  NutritionNeeds? _nutritionNeeds;
  NutritionNeeds? get nutritionNeeds => _nutritionNeeds;

  List<DietPlanDay>? _dietPlanTemplateDays;
  List<DietPlanDay>? get dietPlanTemplateDays => _dietPlanTemplateDays;

  DietPlan? _dietPlan;
  DietPlan? get dietPlan => _dietPlan;

  double? _calculateBMI({
    required double height,
    required double weight,
  }) {
    double result = _bmiController.calculateBMI(
      height: height,
      weight: weight,
    );
    _bmi = result;
    notifyListeners();

    return _bmi;
  }

  BmiStatus? getBMIStatus({
    required User user,
  }) {
    _calculateBMI(
      height: user.height!,
      weight: user.weight!,
    );

    if (_bmi != null) {
      BmiStatus result = _bmiController.getBMIStatus(
        bmi: _bmi!,
        age: user.age!,
        gender: user.gender == "آقا" ? Gender.male : Gender.female,
      );
      _bmiStatus = result;
      notifyListeners();
    }

    return _bmiStatus;
  }

  NutritionNeeds? calculateNutritionNeeds({
    required User user,
  }) {
    NutritionNeeds result = _bmrController.calculateNutritionNeeds(
      user: User(
        height: user.height,
        weight: user.weight,
        age: user.age!,
        gender: user.gender!,
        bmiStatus: user.bmiStatus,
        activityLevel: user.activityLevel,
      ),
    );
    _nutritionNeeds = result;

    notifyListeners();

    return _nutritionNeeds;
  }

  List<DietPlanDay>? getDietPlanTemplate({
    required Map<String, dynamic> data,
    required BuildContext context,
  }) {
    try {
      _status = AppState.loading;
      notifyListeners();

      List<DietPlanDay> decodeDietPlanDays = [];

      decodeDietPlanDays = (data['diet_plan_days'] as List)
          .map(
            (i) => DietPlanDay.fromJson(i),
          )
          .toList();

      _dietPlanTemplateDays = decodeDietPlanDays;

      _status = AppState.success;
      notifyListeners();
    } catch (_) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }

    return _dietPlanTemplateDays;
  }

  Future<void> createDietPlan({
    required BuildContext context,
    required DietPlan dietPlan,
  }) async {
    try {
      _status = AppState.loading;
      // notifyListeners();

      await _databaseHelper.insertIntoDietPlan({
        'start_date': dietPlan.startDate,
        'end_date': dietPlan.endDate,
        'editable': dietPlan.editable,
        'diet_plan_days': dietPlan.dietPlanDays!.map((item) => item.toJson()).toList(),
      }).then((_) {
        Navigator.pushReplacementNamed(
          context,
          RootScreens.routeName,
          arguments: RootScreenItems.profile,
        );
      });

      showSnackBar(
        context,
        message: "برنامه غذایی شما با موفقیت ثبت شد، از قسمت برنامه غذایی من میتوانید مدیریت کنید",
        snackbarType: SnackBarType.success,
      );

      _status = AppState.success;
      notifyListeners();
    } catch (e) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }

  Future<void> updateDietPlan({
    required BuildContext context,
    required DietPlan dietPlan,
  }) async {
    try {
      // _status = AppState.loading;
      // notifyListeners();

      await _databaseHelper.updateDietPlan({
        'id': 1,
        'start_date': dietPlan.startDate,
        'end_date': dietPlan.endDate,
        'editable': dietPlan.editable,
        'diet_plan_days': dietPlan.dietPlanDays!.map((item) => item.toJson()).toList(),
      });

      // _status = AppState.success;
      // notifyListeners();
    } catch (_) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }

  Future<void> deleteDietPlan({
    required BuildContext context,
    required String startDate,
  }) async {
    try {
      _status = AppState.loading;
      // notifyListeners();

      await _databaseHelper.deleteFromDietPlan(startDate).then((_) {
        Navigator.pushReplacementNamed(
          context,
          RootScreens.routeName,
          arguments: RootScreenItems.profile,
        );
      });

      _dietPlan = null;

      showSnackBar(
        context,
        message: "برنامه غذایی شما با موفقیت حذف شد",
        snackbarType: SnackBarType.success,
      );

      _status = AppState.success;
      notifyListeners();
    } catch (e) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }
  }

  Future<DietPlan?> getDietPlan({
    required BuildContext context,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      Map<String, dynamic> result = await _databaseHelper.queryRowDietPlan();
      if (result.isNotEmpty) _dietPlan = DietPlan.fromJson(result);

      _status = AppState.success;
      notifyListeners();
    } catch (_) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }

    return _dietPlan;
  }

  Future<DietPlan?> getDietPlanAndCheckStatus({
    required BuildContext context,
  }) async {
    try {
      _status = AppState.loading;
      notifyListeners();

      Map<String, dynamic> result = await _databaseHelper.queryRowDietPlan();
      if (result.isEmpty) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmptyScreen(
              content: Text(
                'هنوز برنامه غذایی ثبت نکرده اید!',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              button: Button(
                borderRadius: BorderRadius.circular(30),
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  ChooseTypeOfDietPlanningScreen.routeName,
                  arguments: false,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.menu,
                      size: 20,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'برنامه های غذایی',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        _dietPlan = DietPlan.fromJson(result);
        Navigator.pushReplacementNamed(
          context,
          DietPlanTrackingScreen.routeName,
        );
      }

      _status = AppState.success;
      notifyListeners();
    } catch (_) {
      _status = AppState.error;
      navigateToErrorPage(context: context);
    }

    return _dietPlan;
  }
}
